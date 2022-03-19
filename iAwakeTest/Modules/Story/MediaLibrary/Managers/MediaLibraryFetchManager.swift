//
//  MediaLibraryFetchManager.swift
//  iAwakeTest
//
//  Created by Nikesh Shakya on 18/03/2022.
//

import Foundation

struct MediaLibraryFetchParamKeys {
    struct Free {
        static let resetCache = "resetCache"
    }
}

class MediaLibraryFetchManager {
    private let manager = NetworkRequestManager(session: NetworkRequestManager.getNewSession())
    
    func fetchFreeMediaLibrary(resetCache: Bool = true, completion: @escaping responseBlock) {
        var param = [String: Any]()
        if resetCache {
            param[MediaLibraryFetchParamKeys.Free.resetCache] = true
        }
        let url = GetApiAddress.mediaLibrary(.getFreeLibrary, []).url
        manager.processApiRequest(urlLink: url, returnType: MediaModel.self, parameters: param, method: .get, headers: [:], completion: completion)
    }
}
