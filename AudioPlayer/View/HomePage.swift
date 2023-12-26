//
//  HomeView.swift
//  AudioPlayer
//
//  Created by miqo on 23.12.23.
//

import SwiftUI
import AVKit

struct HomeView: View {
    @StateObject var homeVM: HomePageVM = .init()
    @StateObject var playerVM: PlayerVM = .init()
    
    @State var selectedSong: SongModel?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(Array(homeVM.songData.enumerated()), id:\.offset) { index, song in
                    SongItemView(song: song)
                }
            }
            .navigationDestination(item: $selectedSong, destination: { item in
                PlayerPage(item: item)
            })
        }
        .onAppear(perform: setupPlayer)
        .environmentObject(playerVM)
    }
    
    func setupPlayer() {
        var itemList: [AVPlayerItem] = []
        
        
        for song in homeVM.songData {
            itemList.append(AVPlayerItem(url: song.url!))
        }
        playerVM.player = .init(items: itemList)
    }
    
    @ViewBuilder
    func SongItemView(song: SongModel) -> some View {
        Button(action: {
            selectedSong = song
            //playerVM.player.replaceCurrentItem(with: AVPlayerItem(url: song.url!))
        }) {
            Text(song.title)
        }
    }
}

#Preview {
    HomeView()
}
