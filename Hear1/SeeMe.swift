import AVFoundation
import SwiftUI
import UIKit



class SeeMe: UIViewController, AVAudioRecorderDelegate {
    // 引入 AVFoundation 库，声明 ViewController 类并继承自 UIViewController 和 AVAudioRecorderDelegate 类
    
    var audioSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    // 声明两个实例变量，audioSession 和 audioRecorder，用于配置和录制音频
    
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
    
    override func viewDidLoad() {
        print("你终于到了")
        super.viewDidLoad()
        // 在视图加载时执行父类的 viewDidLoad 方法
        
        audioSession = AVAudioSession.sharedInstance()
        // 获取音频会话的共享实例
        
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
            // 配置音频会话为同时录制和播放，并激活音频会话
        } catch {
            print("Error configuring audio session")
            // 输出错误信息
        }
        
        let audioURL = getDocumentsDirectory().appendingPathComponent("recording.wav")
        // 获取应用程序的 Documents 目录，并在其下创建名为 "recording.wav" 的音频文件
        
        let audioSettings: [String:Any] = [AVFormatIDKey: Int(kAudioFormatLinearPCM),
                                         AVSampleRateKey: 44100.0,
                                   AVNumberOfChannelsKey: 2,
                                  AVLinearPCMBitDepthKey: 16,
                               AVLinearPCMIsBigEndianKey: false,
                                   AVLinearPCMIsFloatKey: false]
        // 配置音频文件格式、采样率、通道数和比特深度等设置
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioURL, settings: audioSettings)
            audioRecorder.delegate = self
            audioRecorder.record()
            // 根据指定的音频 URL 和设置创建音频录制器，将其委托设置为 ViewController，开始录制音频
        } catch {
            print("Error creating audio recorder")
            // 输出错误信息
        }
        
    }
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
        // 返回应用程序的 Documents 目录
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            print("Audio recording was successful")
            // 输出成功录制音频的信息
        } else {
            print("Audio recording failed")
            // 输出录制音频失败的信息
        }
    }
    
    
   
}




