//
//  ChatGPTStreamClient.swift
//  Hear1
//
//  Created by 姚东 on 2023/4/20.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

protocol ChatGPTStreamClientDelegate: AnyObject {
    func chatGPTStreamClientDidReceiveDoneMessage(_ client: ChatGPTStreamClient)
    func speakWord(_ client: ChatGPTStreamClient)
}

class ChatGPTStreamClient: NSObject  {
    private weak var textView: UITextView?
    private var streamRequest: DataStreamRequest?
    weak var delegate: ChatGPTStreamClientDelegate?
    private(set) var responseText: String = ""
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
    
    // 添加 setNewTextView 方法
        func setNewTextView(_ newTextView: UITextView) {
            self.textView = newTextView
        }
    
    init(textView: UITextView?) {
        self.textView = textView
    }
    func createStreamTask(for text: String) {
        responseText = ""
        let url = URL(string: "https://api.openai.com/v1/chat/completions")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer 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", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let messages: [[String: Any]] = [
            [
                "role": "user",
                "content": text
            ]
        ]
        let parameters: [String: Any] = [
            "model": "gpt-3.5-turbo",
            "messages": messages,
            "stream": true
        ]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else {
            print("Error converting parameters to JSON data")
            return
        }
        request.httpBody = jsonData
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        let task = session.dataTask(with: request)
        appendMessageToTextView("ChatGPT:")
        task.resume()
    }
    
    private func appendMessageToTextView(_ message: String) {
        guard let textView = textView else { return }
        let updatedText = message
        let attributedText = NSMutableAttributedString(attributedString: textView.attributedText)
        let newAttributedText = NSAttributedString(string: updatedText, attributes: senderChatGPTStyle)
        attributedText.append(newAttributedText)
        
        textView.attributedText = attributedText
    }
    
    private func appendMessageToTextView2(_ message: String) {
        guard let textView = textView else { return }
        let updatedText = textView.text + message
        textView.text = updatedText
    }
    
    
    
    
    
}


// 将扩展添加到 ChatGPTStreamClient 类所在的文件中
extension ChatGPTStreamClient: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        DispatchQueue.main.async { [weak self] in
            
            if let result = String(bytes: data, encoding: .utf8) {
                let cleanedStr = result.replacingOccurrences(of: "data: ", with: "")
                let jsonStrings = cleanedStr.components(separatedBy: "\n\n")
                for jsonString in jsonStrings {
                    if jsonString == "[DONE]" {
                        self?.appendMessageToTextView("\n")
                        self?.delegate?.chatGPTStreamClientDidReceiveDoneMessage(self!)
                        
                    } else {
                        if let jsonData = jsonString.data(using: .utf8), !jsonString.isEmpty {
                            let json = try! JSON(data: jsonData)
                            let id = json["id"].string
                            if let content = json["choices"][0]["delta"]["content"].string {
                                print(content)
                                self?.responseText += content
                                self?.appendMessageToTextView(content)
                                //                                self?.delegate?.speakWord(self!)
                            }
                        }
                    }
                    
                }
            }
            
        }
    }
}
