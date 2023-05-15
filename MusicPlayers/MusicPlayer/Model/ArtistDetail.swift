//
//  ArtistDetail.swift
//  MusicPlayer
//
//  Created by Şehriban Yıldırım on 12.05.2023.
//

import Foundation

// MARK: - AlbumDetail
struct ArtistDetail: Codable {
    let data: [ArtistDetailData]
}

 // MARK: - ArtistDetailData
struct ArtistDetailData: Codable {
    let id: Int
    let title: String
    let cover_big: String
    let release_date: String
}

