//
//  SongModel.swift
//  AudioPlayer
//
//  Created by miqo on 23.12.23.
//

import Foundation

struct SongModel: Identifiable, Hashable {
    let index: Int
    let title: String
    let url: URL?
    
    var id: Int { return index }
}
