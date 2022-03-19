//
//  MediaProgramItemViewModel.swift
//  iAwakeTest
//
//  Created by Nikesh Shakya on 18/03/2022.
//

import Foundation

class MediaProgramItemViewModel {
    let model: MediaProgram!
    
    init(model: MediaProgram) {
        self.model = model
    }
    
    var title: String {
        return model.title ?? ""
    }
    
    var description: String {
        return model.descriptionHTML?.html2String ?? ""
    }
    
    var bannerThumbnailUrl: String {
        return model.banner?.url ?? ""
    }
    
    var tracksCount: String {
        return "\(model.tracks?.count ?? 0)"
    }
}
