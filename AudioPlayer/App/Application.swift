//
//  AudioPlayerApp.swift
//  AudioPlayer
//
//  Created by miqo on 23.12.23.
//

import SwiftUI
import AVKit

@main
struct AudioPlayerApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView()
                .onAppear(perform: setupAudioSession)
        }
    }
    
    func setupAudioSession() {
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setCategory(.playback, options: [])
            try audioSession.setActive(true)
        } catch {
            print("Unable to activate audio session:  \(error.localizedDescription)")
        }
    }
}
