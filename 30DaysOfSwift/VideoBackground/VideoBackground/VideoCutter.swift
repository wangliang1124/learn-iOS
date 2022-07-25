//
//  VideoCutter.swift
//  VideoBackground
//
//  Created by 王亮 on 2022/7/24.
//

import Foundation
import AVFoundation

class VideoCutter: NSObject {
    func cropVideoWithUrl(videoUrl url: URL, startTime: CGFloat, duration: CGFloat, completion:((_ videoPath: URL?, _ error: NSError?) -> Void)?){
        let asset = AVURLAsset(url: url)
        let exportSession = AVAssetExportSession(asset: asset, presetName: "AVAssetExportPresetHighestQuality")
//        let paths: NSArray =  NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as NSArray
        
        let manager = FileManager.default
//        let path = manager.urls(for: .itemReplacementDirectory, in: .userDomainMask).first
//        var outputURL = paths.object(at: 0) as! String
        
//        do {
//            try manager.createDirectory(atPath: outputURL, withIntermediateDirectories: true)
//        } catch _ {
//
//        }
        
        let outputURL = manager.temporaryDirectory.appendingPathComponent("output.mp4").path //(outputURL as NSString).appendingPathComponent("output.mp4")
        
        do {
            try manager.removeItem(atPath: outputURL)
        } catch _ {
            
        }
        
        if let exportSession  = exportSession as AVAssetExportSession? {
            exportSession.outputURL = URL(fileURLWithPath: outputURL)
            exportSession.shouldOptimizeForNetworkUse = true
            exportSession.outputFileType = AVFileType.mp4
            
            let start = CMTimeMakeWithSeconds(Float64(startTime), preferredTimescale: 600)
            let duration = CMTimeMakeWithSeconds(Float64(duration), preferredTimescale: 600)
            let range = CMTimeRange(start: start, duration: duration)
            
            exportSession.timeRange = range
            
            exportSession.exportAsynchronously {
                switch exportSession.status {
                case .completed:
                    completion?(exportSession.outputURL, nil)
                case .failed:
                    print("Failed: \(String(describing: exportSession.error))")
                case .cancelled:
                    print("Failed: \(String(describing: exportSession.error))")
                    
                default:
                    print("default case")
                }
            }
        }
    }
}
