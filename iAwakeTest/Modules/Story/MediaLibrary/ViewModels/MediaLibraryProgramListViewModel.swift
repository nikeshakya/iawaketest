//
//  MediaLibraryProgramListViewModel.swift
//  iAwakeTest
//
//  Created by Nikesh Shakya on 18/03/2022.
//

import Foundation

class MediaLibraryProgramListViewModel {
    private let manager = MediaLibraryFetchManager()
    var model: MediaModel?
    var isFetching = false
    
    var onFreeLibraryFetchError: ((Error) -> Void)?
    var onFreeLibraryFetchSuccess: (() -> Void)?
    
    init() {
        model = nil
    }
    
    var programs: MediaPrograms {
        return model?.programs ?? []
    }
    
    var programsCount: Int {
        return programs.count
    }
    
    func getProgramItem(at index: Int) -> MediaProgram {
        return programs[index]
    }
}

extension MediaLibraryProgramListViewModel {
    
    func fetchFreeLibraries() {
        guard !isFetching else { return }
        manager.fetchFreeMediaLibrary(resetCache: true) { [weak self] result, error in
            guard let self = self else { return }
            self.isFetching = false
            if let error = error {
                self.onFreeLibraryFetchError?(error)
            }
            else {
                if let obj = result as? MediaModel {
                    self.model = obj
                    self.onFreeLibraryFetchSuccess?()
                }
                else if let respData = result as? Data {
                    let decoder = JSONDecoder()
                    do {
                        let obj = try decoder.decode(MediaModel.self, from: respData)
                        self.model = obj
                        self.onFreeLibraryFetchSuccess?()
                    } catch {
                        debugPrint("Error: \(error.localizedDescription)")
                        self.onFreeLibraryFetchError?(error)
                    }
                }
                else {
                    self.onFreeLibraryFetchError?(CommonError.invalidDataFormat)
                }
            }
            
        }
    }
}
