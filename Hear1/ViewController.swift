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
    
    // 添加按钮和 UITextView 属性

    private var textView: UITextView!
    private var chatGPTStreamClient: ChatGPTStreamClient?
    var isRecording = false
    var canChange = false
    private var createTextViewButton: UIButton!

    private var startListeningButton = UIButton(type: .system)
    private var startListeningButton2 = UIButton(type: .system)
    
//    private var rtfManager: RTFManager!

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
    
    
    /**
     我们需要在视图控制器中添加一个按钮，用户点击该按钮即可启动实时收听功能。将以下代码添加到 viewDidLoad 方法中：
     */
    override func viewDidLoad() {
        super.viewDidLoad()
       

        // 初始化 textView
       textView = UITextView()

       textView.translatesAutoresizingMaskIntoConstraints = false
       textView.isEditable = false // 不允许修改内容
       textView.isSelectable = true // 允许选中和复制文本
       textView.delegate = self


       // 设置 UITextView 的样式
       textView.layer.cornerRadius = 10
       textView.layer.borderWidth = 1
       textView.layer.borderColor = UIColor.systemGray4.cgColor
       textView.backgroundColor = UIColor.systemGray6
       textView.textColor = UIColor.label
       textView.font = UIFont.systemFont(ofSize: 16)
       textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        // 设置 startListeningButton 的样式
        // 初始化 startListeningButton
        startListeningButton.translatesAutoresizingMaskIntoConstraints = false
        startListeningButton.setTitle("开始收听", for: .normal)
        startListeningButton.setTitleColor(.white, for: .normal)
        startListeningButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        startListeningButton.layer.cornerRadius = 20
        startListeningButton.backgroundColor = UIColor(red: 0.2, green: 0.6, blue: 1, alpha: 1)
        startListeningButton.addTarget(self, action: #selector(startListeningButtonTapped), for: .touchUpInside)
        
        view.addSubview(startListeningButton)
        view.addSubview(textView)

        //设置startListeningButton2和startListeningButton的功能差不多，但是可以在用户说完话识别完成以后，修改其中的内容，并去触发chatgpt接口
        startListeningButton2.translatesAutoresizingMaskIntoConstraints = false
        startListeningButton2.setTitle("开始收听", for: .normal)
        startListeningButton2.setTitleColor(.white, for: .normal)
        startListeningButton2.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        startListeningButton2.layer.cornerRadius = 20
        startListeningButton2.backgroundColor = UIColor(red: 0.2, green: 0.6, blue: 1, alpha: 1)
        startListeningButton2.addTarget(self, action: #selector(startListeningButtonTapped), for: .touchUpInside)

        
        // 设置 textView 和 startListeningButton 的约束
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            textView.bottomAnchor.constraint(equalTo: startListeningButton.topAnchor, constant: -10),
            
            startListeningButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                startListeningButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
                startListeningButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        //setupCreateTextViewButton()
        
        // 添加双击屏幕事件
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(startListeningButtonTapped))
        doubleTapRecognizer.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTapRecognizer)
        
       loadTextFromFile()
        
        // 最后，在初始化 ChatGPTStreamClient 实例的地方设置其代理：
        chatGPTStreamClient = ChatGPTStreamClient(textView: textView)
        chatGPTStreamClient?.delegate = self
        
//        rtfManager = RTFManager(viewController: self)

    }
    
    // 设置按钮样式和位置
        private func setupCreateTextViewButton() {
            createTextViewButton = UIButton(type: .system)
            createTextViewButton.setTitle("添加会话", for: .normal)
            createTextViewButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            createTextViewButton.backgroundColor = .systemBlue
            createTextViewButton.setTitleColor(.white, for: .normal)
            createTextViewButton.layer.cornerRadius = 10
            
            createTextViewButton.addTarget(self, action: #selector(createNewTextView), for: .touchUpInside)
             self.view.addSubview(createTextViewButton)
            
            // 设置按钮的自动布局约束
            createTextViewButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                createTextViewButton.heightAnchor.constraint(equalTo: startListeningButton.heightAnchor),
                createTextViewButton.widthAnchor.constraint(equalTo: startListeningButton.widthAnchor, multiplier: 1/5),
                createTextViewButton.bottomAnchor.constraint(equalTo: startListeningButton.bottomAnchor),
                createTextViewButton.leadingAnchor.constraint(equalTo: startListeningButton.trailingAnchor, constant: 10)
            ])
            
            

        }
    
    
    @objc private func createNewTextView() {
            // 移除当前的 UITextView
            textView?.removeFromSuperview()
            
            // 创建并设置新的 UITextView
            textView = UITextView()
            textView.font = UIFont.systemFont(ofSize: 16)
            textView.layer.borderColor = UIColor.lightGray.cgColor
            textView.layer.borderWidth = 1.0
            textView.layer.cornerRadius = 5.0
            self.view.addSubview(textView)
            
            // 设置新 UITextView 的自动布局约束
            textView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                textView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                textView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                textView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                textView.bottomAnchor.constraint(equalTo: createTextViewButton.topAnchor, constant: -20)
            ])
        
            // 使用 setNewTextView 方法设置新的 UITextView
            chatGPTStreamClient?.setNewTextView(textView
            
            )
        }
    
    
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
    

    /**
        从指定文件中加载文本
        */


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


