//
//  AlbumDetail.swift
//  MusicPlayer
//
//  Created by Şehriban Yıldırım on 12.05.2023.
//

import Foundation

// MARK: - AlbumDetail
struct AlbumDetail: Codable {
    let data: [AlbumDetailData]
    let total: Int
}

// MARK: - AlbumDetailData
struct AlbumDetailData: Codable {
    let id: Int
    let title: String
    let duration: Int
    let preview: String
}



