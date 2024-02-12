//
//  HomeView.swift
//  AudioPlayer
//
//  Created by miqo on 23.12.23.
//

import SwiftUI
import AVKit

struct HomeView: View {
    @EnvironmentObject var notificationService: NotificationService
    
    @StateObject var homeVM: HomePageVM = .init()
    @StateObject var playerVM: PlayerVM = .init()
    
    @State var selectedSong: SongModel?
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(Array(homeVM.songData.enumerated()), id:\.offset) { index, song in
                        SongItemView(song: song)
                    }
                }
                .navigationDestination(item: $selectedSong, destination: { item in
                    PlayerPage(item: item)
                })
                
                NotificationContent()
            }
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
    
    @ViewBuilder
    func NotificationContent() -> some View {
        VStack {
            Image(systemName: "figure.gymnastics")
                .resizable()
                .foregroundColor(.red)
                .frame(width: 100, height: 100)
            
            Text("Hello, Gymnastics!")
                .font(.title)
            
            Button("Send Notification") {
                notificationService.scheduleNotification(title: "1 new message", subtitle: "The meeting tomorrow is rescheduled...")
            }
            .buttonStyle(.borderedProminent)
            .padding()
            
            Button("Request Permissions") {
                Task { await notificationService.requestPushNotificationAuthorization() }
            }
            .buttonStyle(.borderedProminent)
            .padding()
            
            Stepper("Badge Number \(notificationService.badgeNumber != 0 ? notificationService.badgeNumber.description : "")", value: $notificationService.badgeNumber, in: 0...Int.max)
            
        }
        .fullScreenCover(isPresented: $notificationService.showSettingsPage, content: {
            // your settings page here
            VStack {
                Text("Settings Page").font(.title)
                Text("All your settings here").font(.subheadline)
                Button("Dismiss") {
                    notificationService.showSettingsPage = false
                }
                .padding()
                .buttonStyle(.borderedProminent)
            }
        })
        .padding()
    }
}


#Preview {
    HomeView()
        .environmentObject(NotificationService())
}
