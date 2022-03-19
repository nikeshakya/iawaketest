//
//  MediaTrackItemViewModel.swift
//  iAwakeTest
//
//  Created by Nikesh Shakya on 18/03/2022.
//

import Foundation
import UIKit

class MediaTrackItemViewModel {
    let model: Track!
    var audioDuration: Double = 0
    var currentTime: Double = 0
    
    var isPlaying: Bool = false
    var isPlayerReady: Bool = false
    
    init(model: Track) {
        self.model = model
        self.audioDuration = model.duration?.toDouble ?? 0
    }
    
    var title: String {
        return model.title ?? ""
    }
    
    var description: String {
        return model.key ?? ""
    }
    
    var duration: String {
        return (audioDuration - currentTime).toDurationString()
    }
    
    var trackUrl: String {
        return model.media?.mp3?.url ?? ""
    }
    
    var playPauseIcon: UIImage? {
        return isPlaying ? .audioPauseIcon : .audioPlayIcon
    }
}
