//
//  ViewController.swift
//  Hear1
//
//  Created by 姚东 on 2023/4/19.
//

import Foundation
import UIKit
import Speech
import AVFoundation

extension ViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        return false // 阻止用户编辑 textView
    }
}

class ViewController: UIViewController, SFSpeechRecognizerDelegate {
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "zh_CN"))
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var recognitionTask: SFSpeechRecognitionTask?
    private let audioEngine = AVAudioEngine()
    private let speechSynthesizer = AVSpeechSynthesizer()
    
    private var chatGPTStreamClient: ChatGPTStreamClient?
    // 发送端样式
    let senderIStyle: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor(red: 30/255, green: 144/255, blue: 255/255, alpha: 1) : UIColor(red: 30/255, green: 144/255, blue: 255/255, alpha: 1) // 根据系统外观设置颜色
        },
        .font: UIFont.systemFont(ofSize: 18, weight: .medium) // 字体大小为18，字体权重为中等
    ]

    // 回答端样式
    let senderChatGPTStyle: [NSAttributedString.Key: Any] = [
        .foregroundColor: UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor.white : UIColor(red: 47/255, green: 79/255, blue: 79/255, alpha: 1) // 根据系统外观设置颜色
        },
        .font: UIFont.systemFont(ofSize: 16, weight: .regular) // 字体大小为16，字体权重为常规
    ]


    


    private var silenceTimer: Timer?

    private func resetTimer(waitingTime: TimeInterval) {
        silenceTimer?.invalidate()
        silenceTimer = Timer.scheduledTimer(withTimeInterval: waitingTime, repeats: false) { [weak self] _ in
            self?.audioEngine.stop()
            self?.recognitionRequest?.endAudio()
        }
    }

    
    func startRecording(waitingTime: TimeInterval = 2) throws {
        // 1. 检查 recognitionTask 是否正在运行
        if let recognitionTask = recognitionTask {
            recognitionTask.cancel()
            self.recognitionTask = nil
        }

        // 2. 设置音频会话
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)

        // 3. 创建 recognitionRequest
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()

        // 4. 设置输入源
        let inputNode = audioEngine.inputNode
        guard let recognitionRequest = recognitionRequest else {
            fatalError("无法创建 SFSpeechAudioBufferRecognitionRequest 对象")
        }

        recognitionRequest.shouldReportPartialResults = true
        // ...
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest) { [weak self] (result, error) in
            var isFinal = false

            if let result = result {
                print(result.bestTranscription.formattedString)
                isFinal = result.isFinal
            }

            if error != nil || isFinal {
                self?.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                self?.recognitionRequest = nil
                self?.recognitionTask = nil

                if let result = result {
                    // 当识别完成时调用 getChatGPTResponse 方法
                    print(result.bestTranscription.formattedString+"=====哈哈哈")
                    if !result.bestTranscription.formattedString.isEmpty && !result.bestTranscription.formattedString.contains("太阳") {
                        print(result.bestTranscription.formattedString+"=====开始调接口")
                        self?.appendMessageToTextView(result.bestTranscription.formattedString, sender: "Me",style: self!.senderIStyle)
                        
                        
                        
//                        self?.getChatGPTResponse(for: result.bestTranscription.formattedString) { response in
//                            self?.speak(response)
//                        }
                        
                        self?.chatGPTStreamClient?.createStreamTask(for: result.bestTranscription.formattedString)

                    }
                   
                }
            } else {
                // 重置计时器
                self?.resetTimer(waitingTime: waitingTime)
            }
        }
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, _) in
            self.recognitionRequest?.append(buffer)
        }

        // 6. 开始音频引擎
        audioEngine.prepare()
        try audioEngine.start()
    }
        
        func getChatGPTResponse(for text: String, completion: @escaping (String) -> Void) {
            //        let url = URL(string: "https://api.openai.com/v1/engines/davinci-codex/completions")!

            let url = URL(string: "https://api.openai.com/v1/chat/completions")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.addValue("Bearer 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", forHTTPHeaderField: "Authorization")
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//            let prompt = "ss'\(text)'"
            let prompt = text
            let messages: [[String: Any]] = [
                [
                    "role": "user",
                    "content": prompt
                ]
            ]

            let requestBody: [String: Any] = [
                "model":"gpt-3.5-turbo",
                "messages":messages
//
            ]
            request.httpBody = try? JSONSerialization.data(withJSONObject: requestBody, options: [])

            // 增加代理地址
            let configuration = URLSessionConfiguration.default
            configuration.connectionProxyDictionary = [
                kCFProxyHostNameKey as AnyHashable: "localhost",
                kCFProxyPortNumberKey as AnyHashable: 7890
            ]
            let session = URLSession(configuration: configuration)

            let task = session.dataTask(with: request) { data, response, error in
                if let data = data {
                    do {
                        if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                           let choices = jsonResponse["choices"] as? [[String: Any]],
                         
                           let firstChoice = choices.first,
                           //json对象解析
                           let message = firstChoice["message"]as? [String: Any],
                           let text = message["content"] as? String {
                            print(text)
                            DispatchQueue.main.async {
                                completion(text)

                                self.appendMessageToTextView(text, sender: "ChatGPT",style: self.senderChatGPTStyle)
                                self.saveTextToFile()
                                
                                // 停止录音
                                self.audioEngine.stop()
                                self.recognitionRequest?.endAudio()
                                self.recognitionTask?.cancel()
                                self.recognitionTask = nil
                                self.isRecording = false
                            
                                self.startListeningButton.setTitle("开始录音", for: .normal)
                            }
                        }
                    } catch {
                        print("Error parsing the response: \(error)")
                    }
                } else if let error = error {
                    print("Error fetching the response: \(error)")
                }
            }

            task.resume()
        }


    
    
    func speak(_ text: String) {
        let speechUtterance = AVSpeechUtterance(string: text)
        speechUtterance.voice = AVSpeechSynthesisVoice(language: "zh-CN")
        
        selectAudioOutput() // 在这里调用 selectAudioOutput
        
        speechSynthesizer.speak(speechUtterance)
    }
    
    //往文本框追加内容
    func appendMessageToTextView(_ message: String, sender: String, style: [NSAttributedString.Key: Any]) {
        let formattedMessage = "\(sender): \(message)"
        addTextToTextView(formattedMessage, with: style)
    }


    
    //添加带样式的方法
    private func addTextToTextView(_ text: String, with attributes: [NSAttributedString.Key: Any]) {
        let attributedText = NSMutableAttributedString(attributedString: textView.attributedText)
        let newAttributedText = NSAttributedString(string: text, attributes: attributes)
        attributedText.append(newAttributedText)
        attributedText.append(NSAttributedString(string: "\n")) // 添加换行符
        
        textView.attributedText = attributedText
    }
    
    var isRecording = false
    private var startListeningButton = UIButton(type: .system)
    private var textView = UITextView()
    
    //定义文本框
//    @IBOutlet weak var textView: UITextView!
    //@IBOutlet weak var startListeningButton: UIButton!

 

    //将输入框的所有文字存储到本地文件：
//    func saveTextToFile() {
//        let fileName = "conversation.txt"
//        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)
//
//        do {
//            try textView.text.write(to: fileURL, atomically: true, encoding: .utf8)
//        } catch {
//            print("保存文件出错: \(error)")
//        }
//    }
    
    func saveTextToFile() {
        let fileName = "conversation.rtf"
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)
        
        do {
            let data = try textView.attributedText.data(from: NSRange(location: 0, length: textView.attributedText.length), documentAttributes: [.documentType: NSAttributedString.DocumentType.rtf])
            try data.write(to: fileURL)
        } catch {
            print("保存文件出错: \(error)")
        }
    }

    
    //在打开应用时读取本地文件并显示在输入框中：
//    func loadTextFromFile() {
//        let fileName = "conversation.txt"
//        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)
//
//        do {
//            let savedText = try String(contentsOf: fileURL, encoding: .utf8)
//            textView.text = savedText
//        } catch {
//            print("读取文件出错: \(error)")
//        }
//    }

    func loadTextFromFile() {
        let fileName = "conversation.rtf"
        let fileURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(fileName)
        
        do {
            let data = try Data(contentsOf: fileURL)
            let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [.documentType: NSAttributedString.DocumentType.rtf]
            let attributedString = try NSAttributedString(data: data, options: options, documentAttributes: nil)
            textView.attributedText = attributedString
        } catch {
            print("加载文件出错: \(error)")
        }
    }


    
    /**
     我们需要在视图控制器中添加一个按钮，用户点击该按钮即可启动实时收听功能。将以下代码添加到 viewDidLoad 方法中：
     */
    override func viewDidLoad() {
        super.viewDidLoad()

        // 初始化 textView
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false // 不允许修改内容
        textView.isSelectable = true // 允许选中和复制文本
        textView.delegate = self

        // 初始化 startListeningButton
        startListeningButton.translatesAutoresizingMaskIntoConstraints = false

        // 设置 UITextView 的样式
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.systemGray4.cgColor
        textView.backgroundColor = UIColor.systemGray6
        textView.textColor = UIColor.label
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        // 设置 startListeningButton 的样式
        startListeningButton.setTitle("开始收听", for: .normal)
        startListeningButton.setTitleColor(.white, for: .normal)
        startListeningButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        startListeningButton.layer.cornerRadius = 20
        startListeningButton.backgroundColor = UIColor(red: 0.2, green: 0.6, blue: 1, alpha: 1)
        startListeningButton.addTarget(self, action: #selector(startListeningButtonTapped), for: .touchUpInside)

        view.addSubview(startListeningButton)
        view.addSubview(textView)

        // 设置 textView 和 startListeningButton 的约束
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: startListeningButton.topAnchor, constant: -10),

            startListeningButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            startListeningButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            startListeningButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            startListeningButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        // 添加双击屏幕事件
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(startListeningButtonTapped))
        doubleTapRecognizer.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTapRecognizer)

        loadTextFromFile()

        // 最后，在初始化 ChatGPTStreamClient 实例的地方设置其代理：
        chatGPTStreamClient = ChatGPTStreamClient(textView: textView)
        chatGPTStreamClient?.delegate = self
    }

    
        /**
         您实际上不需要调用 overrideOutputAudioPort 方法。因为默认情况下，AVAudioSession 会自动选择合适的音频输出设备
         */
    func selectAudioOutput() {
        let session = AVAudioSession.sharedInstance()
        
        do {
            try session.setCategory(.playback, mode: .default, options: [])
            try session.setActive(true)
        } catch {
            print("音频输出选择失败: \(error)")
        }
    }


    @objc func startListeningButtonTapped() {
        if isRecording {
                // 停止录音
                audioEngine.stop()
                recognitionRequest?.endAudio()
                recognitionTask?.cancel()
                recognitionTask = nil
                isRecording = false
            
            startListeningButton.setTitle("开始录音", for: .normal)
            } else {
                // 开始录音
                do {
                    try startRecording()
                    isRecording = true
                    startListeningButton.setTitle("停止录音", for: .normal)
                } catch {
                    print("无法开始录音：\(error)")
                }
            }
    }
}


extension ViewController: ChatGPTStreamClientDelegate {
    func chatGPTStreamClientDidReceiveDoneMessage(_ client: ChatGPTStreamClient) {
        self.speak(client.responseText)
        self.saveTextToFile()
        self.audioEngine.stop()
        self.recognitionRequest?.endAudio()
        self.recognitionTask?.cancel()
        self.recognitionTask = nil
        self.isRecording = false
        self.startListeningButton.setTitle("开始录音", for: .normal)
    }
    
    func speakWord(_ client: ChatGPTStreamClient) {
        self.speak(client.responseText)
    }
    
}

