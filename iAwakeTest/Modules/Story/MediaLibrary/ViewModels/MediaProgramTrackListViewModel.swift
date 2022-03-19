//
//  MediaProgramTrackListViewModel.swift
//  iAwakeTest
//
//  Created by Nikesh Shakya on 18/03/2022.
//

import Foundation

class MediaProgramTrackListViewModel {
    var model: [Track]!
    
    init(model: [Track]) {
        self.model = model
    }
    
    var tracksCount: Int {
        return model.count
    }
    
    func getTrackItem(at index: Int) -> Track {
        return model[index]
    }
}
