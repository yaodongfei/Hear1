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

class ChatGPTStreamClient: NSObject  {
    private weak var textView: UITextView?
//    private var streamRequest: UploadRequest?
    private var streamRequest: DataStreamRequest?


    init(textView: UITextView) {
        self.textView = textView
    }

//    func createStreamTask(for text: String) {
//        let url = "https://api.openai.com/v1/chat/completions" 
//        let headers: HTTPHeaders = [
//            "Authorization": "Bearer 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",
//            "Content-Type": "application/json"
//        ]
//
//        let messages: [[String: Any]] = [
//            [
//                "role": "user",
//                "content": text
//
//            ]
//        ]
//
//        let parameters: [String: Any] = [
//            "model": "gpt-3.5-turbo",
//            "messages": messages,
//            "stream": true
//        ]
//
//        guard let jsonData = try? JSONSerialization.data(withJSONObject: parameters) else {
//            print("Error converting parameters to JSON data")
//            return
//        }
//
//        streamRequest = AF.upload(jsonData, to: url, headers: headers)
//            .uploadProgress { progress in
//                print("Upload Progress: \(progress.fractionCompleted)")
//            }
//            .responseJSON { [weak self] response in
//                switch response.result {
//                case .success(let value):
//                    let json = JSON(value)
//                    if let content = json["choices"][0]["message"]["content"].string {
//                        DispatchQueue.main.async {
//                            self?.appendMessageToTextView(content)
//                        }
//                    }
//                case .failure(let error):
//                    print("Error in data stream: \(error)")
//                }
//            }
//    }



    func createStreamTask(for text: String) {
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
        task.resume()
    }

    private func appendMessageToTextView(_ message: String) {
        guard let textView = textView else { return }
        let updatedText = textView.text  + message
        textView.text = updatedText
    }
    
//    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
//        DispatchQueue.main.async { [weak self] in
//            let json = try? JSON(data: data)
//            if let content = json?["choices"][0]["message"]["content"].string {
//                self?.appendMessageToTextView(content)
//            }
//        }
//    }
}

//
//if let response = String(bytes: data, encoding: .utf8) {
//    print(response)
//    self?.appendMessageToTextView(response)
//}
// 将扩展添加到 ViewController 类所在的文件中
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
                        } else {
                            if let jsonData = jsonString.data(using: .utf8), !jsonString.isEmpty {
                                let json = try! JSON(data: jsonData)
                                let id = json["id"].string
                                if let content = json["choices"][0]["delta"]["content"].string {
                                    print(content)
                                    self?.appendMessageToTextView(content)
                                }
                            }
                        }
                       
                    
                   
                }
                
               
            }
           
        }
    }
}
