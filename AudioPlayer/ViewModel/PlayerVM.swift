//
//  PlayerVM.swift
//  AudioPlayer
//
//  Created by miqo on 23.12.23.
//

import SwiftUI
import AVKit
import AVFAudio

class PlayerVM: ObservableObject {
    var player = AVQueuePlayer()
        
    @Published var isPlaying = false
    @Published var totalTime: Double = 0
    @Published var currentTime: Double = 0
    
    func playAudio(){
        player.play()
        isPlaying = true
    }
    
    func stopAudio() {
        player.pause()
        isPlaying = false
    }
    
    func updateProgress() {
        //currentTime = player.
    }
    
    func seekAudio(to time: TimeInterval) {
        //player.currentTime = time
    }
}
