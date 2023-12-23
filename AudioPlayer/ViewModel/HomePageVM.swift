//
//  HomePageVM.swift
//  AudioPlayer
//
//  Created by miqo on 23.12.23.
//

import SwiftUI

class HomePageVM: ObservableObject {
    
    let songData: [SongModel] = [
        SongModel(
            index: 0,
            title: "Mercury Planet",
            url: URL(string: "https://firebasestorage.googleapis.com/v0/b/serene-78eed.appspot.com/o/media%2F21701.mp3?alt=media&token=b0ac8fff-6f58-410a-9f0f-28c7789bfb3f&_gl=1*19ydpuu*_ga*NDAwMzU4MDkwLjE2OTc0ODI5MTY.*_ga_CW55HF8NVT*MTY5ODc1MjMwNy42MC4xLjE2OTg3NTY1MjkuNjAuMC4w")
        ),
        SongModel(
            index: 1,
            title: "Beautiful 80s Journey",
            url: URL(string: "https://firebasestorage.googleapis.com/v0/b/serene-78eed.appspot.com/o/media%2F30513.mp3?alt=media&token=ee3926cd-b182-47f3-b967-08636d3acf14")
        ),
        SongModel(
            index: 2,
            title: "Garden of Wonders",
            url: URL(string: "https://firebasestorage.googleapis.com/v0/b/serene-78eed.appspot.com/o/media%2F31308.mp3?alt=media&token=5a048d0c-d3b6-4aa0-aeb8-0409291d6105&_gl=1*atmpp3*_ga*NDAwMzU4MDkwLjE2OTc0ODI5MTY.*_ga_CW55HF8NVT*MTY5ODMwMjg2Ny4zOS4xLjE2OTgzMDQ5NDQuMzkuMC4w")
        ),
        SongModel(
            index: 3,
            title: "Relaxing Piano Ocean Sounds",
            url: URL(string: "https://firebasestorage.googleapis.com/v0/b/serene-78eed.appspot.com/o/media%2F30807.mp3?alt=media&token=54b93869-06d6-492c-bc88-5dd89778c611&_gl=1*1x5uhmj*_ga*NDAwMzU4MDkwLjE2OTc0ODI5MTY.*_ga_CW55HF8NVT*MTY5NzYwNzUzOC43LjEuMTY5NzYwNzgwNy44LjAuMA")
        )
    ]

}
