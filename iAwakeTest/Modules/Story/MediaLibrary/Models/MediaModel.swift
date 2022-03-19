//
//  MediaModel.swift
//  iAwakeTest
//
//  Created by Nikesh Shakya on 18/03/2022.
//

import Foundation

// MARK: - MediaModel
struct MediaModel: Codable {
    let type: String?
    let programs: MediaPrograms?
    let categories: MediaCategories?
    let playlists: Playlists?
    let plan: MediaPlan?

    enum CodingKeys: String, CodingKey {
        case type
        case programs, categories, playlists, plan
    }
}

typealias MediaCategories = [MediaCategory]
// MARK: - MediaCategory
struct MediaCategory: Codable {
    let type, id, title: String?
    let cover: MediaCover?
    let subtitle: String?

    enum CodingKeys: String, CodingKey {
        case type
        case id, title, cover, subtitle
    }
}

// MARK: - MediaCover
struct MediaCover: Codable {
    let type: String?
    let url: String?
    let thumbnail: String?
    let resolutions: [MediaCoverResolution]?

    enum CodingKeys: String, CodingKey {
        case type
        case url, thumbnail, resolutions
    }
}

// MARK: - MediaCoverResolution
struct MediaCoverResolution: Codable {
    let type: String?
    let url: String?
    let size: Int?

    enum CodingKeys: String, CodingKey {
        case type
        case url, size
    }
}

// MARK: - MediaPlan
struct MediaPlan: Codable {
    let name: String?
    let startDate, endDate: String?
}

typealias Playlists = [Playlist]
// MARK: - Playlist
struct Playlist: Codable {
    let type, id, title: String?
    let cover: MediaCover?
    let descriptionHTML: String?
    let order: Int?

    enum CodingKeys: String, CodingKey {
        case type
        case id, title, cover, descriptionHTML, order
    }
}

typealias MediaPrograms = [MediaProgram]
// MARK: - Program
struct MediaProgram: Codable {
    let type, id: String?
    let folders: [Folder]?
    let title: String?
    let isFree, isAvailable, isFeatured: Bool?
    let banner: Banner?
    let cover: MediaCover?
    let headphones: Bool?
    let descriptionHTML: String?
    let tracks: [Track]?

    enum CodingKeys: String, CodingKey {
        case type
        case id, folders, title, isFree, isAvailable, isFeatured, banner, cover, headphones, descriptionHTML, tracks
    }
}

// MARK: - Banner
struct Banner: Codable {
    let type: String?
    let url: String?
    let thumbnail: String?
    let resolutions: [BannerResolution]?

    enum CodingKeys: String, CodingKey {
        case type
        case url, thumbnail, resolutions
    }
}

// MARK: - BannerResolution
struct BannerResolution: Codable {
    let type: String?
    let url: String?
    let size: Size?

    enum CodingKeys: String, CodingKey {
        case type
        case url, size
    }
}

// MARK: - Size
struct Size: Codable {
    let width, height: Int?
}

// MARK: - Folder
struct Folder: Codable {
    let type, title: String?
    let cover: MediaCover?
    let descriptionHTML: String?
    let folders: [String]?

    enum CodingKeys: String, CodingKey {
        case type
        case title, cover, descriptionHTML, folders
    }
}

// MARK: - Track
struct Track: Codable {
    let type, key, title: String?
    let folderPath: [[String]]?
    let order, duration: Int?
    let isAvailable: Bool?
    let media: Media?

    enum CodingKeys: String, CodingKey {
        case type
        case key, title, folderPath, order, duration, isAvailable, media
    }
}

// MARK: - Media
struct Media: Codable {
    let type: String?
    let mp3, flac, m4A: FLAC?

    enum CodingKeys: String, CodingKey {
        case type
        case mp3, flac
        case m4A = "m4a"
    }
}

// MARK: - FLAC
struct FLAC: Codable {
    let type: String?
    let url, headURL: String?

    enum CodingKeys: String, CodingKey {
        case type
        case url
        case headURL = "headUrl"
    }
}
