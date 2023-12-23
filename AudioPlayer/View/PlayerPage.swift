//
//  PlayerPage.swift
//  AudioPlayer
//
//  Created by miqo on 23.12.23.
//

import SwiftUI
import AVKit

struct PlayerPage: View {
    @EnvironmentObject var playerVM: PlayerVM
    
    var item: SongModel
    @State private var animation: Bool = false
    
    private func timeString(time: TimeInterval) -> String {
        let minute = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minute, seconds)
    }
    
    var body: some View {
        VStack {
            VStack {
                PlayerInfoView()
                
                PlayerControllView()
            }
            .padding(.vertical, 30)
            
            Spacer()
            
            BottomControlView()
        }
        .navigationBarBackButtonHidden()
        .padding(.horizontal, 30)
        .ignoresSafeArea()
        .background { BackgroundView() }
    }
    
    @ViewBuilder
    func BackgroundView() -> some View {
        ZStack {
            Rectangle()
                .fill(.ultraThickMaterial)
                .overlay(content: {
                    Rectangle()
                    Image("player_background")
                        .blur(radius: 55)
                    //.opacity(animationContent ? 1 : 0)
                })
        }
    }

    @ViewBuilder
    func PlayerInfoView() -> some View {
        VStack(spacing: 20){
            VStack(spacing: 15){
                Image("player_background")
                    .resizable().scaledToFill()
                    .frame(width: UIScreen.screenWidth*0.8)
                    .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    .padding(.vertical, 30)
            }
            
            HStack(alignment: .center, spacing: 15){
                VStack(alignment: .leading, spacing: 4){
                    Text(item.title)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Button(action: { }) {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.white)
                        .padding(12)
                        .background{
                            Circle()
                                .fill(.ultraThinMaterial)
                                .environment(\.colorScheme, .light)
                        }
                }
            }
            
        }
    }
    
    @ViewBuilder
    func PlayerControllView() -> some View {
        VStack(spacing: 20) {
            VStack(spacing: 5) {
                Slider(value: Binding(get: {
                    playerVM.currentTime
                }, set: { newValue in
                    playerVM.seekAudio(to: newValue)
                }), in: 0...playerVM.totalTime)
                .accentColor(.white)
                
                HStack{
                    Text(timeString(time: playerVM.currentTime))
                    Spacer()
                    Text(timeString(time: playerVM.totalTime))
                }
            }
            
            HStack(spacing: 0){
                Button(action: { }) {
                    Image(systemName: "backward.fill")
                        .font(.title)
                }
                
                Spacer()
                
                Button(action: {}){
                    Image(systemName: playerVM.isPlaying ? "pause.fill" : "play.fill")
                        .font(.largeTitle)
                        .onTapGesture {
                            playerVM.isPlaying ? playerVM.stopAudio() : playerVM.playAudio()
                        }
                }
                
                Spacer()
                
                Button(action: { playerVM.player.advanceToNextItem() }) {
                    Image(systemName: "forward.fill")
                        .font(.title)
                }
            }
            .foregroundColor(.white)
            .padding(.horizontal, 50)
            .frame(height: UIScreen.screenHeight*0.05)
            
            HStack(spacing: 15){
                Image(systemName: "speaker.fill")
                
                ZStack {
                    Capsule()
                        .fill(.ultraThinMaterial)
                        .environment(\.colorScheme, .light)
                        .frame(height: 5)
                    
                }
                
                Image(systemName: "speaker.wave.3.fill")
            }
        }
    }
    
    @ViewBuilder
    func BottomControlView() -> some View {
        HStack {
            Button(action: { }) {
                VStack {
                    Image(systemName: "quote.bubble")
                        .font(.title2)
                    Text("Info")
                        .font(.caption)
                }
            }
            
            Spacer()
            
            Button(action: { }) {
                VStack(spacing: 6){
                    Image(systemName: "airpodspro.chargingcase.wireless.fill")
                        .font(.title2)
                    Text("Airpods")
                        .font(.caption)
                }
            }
            
            Spacer()
            
            Button(action: { }) {
                VStack {
                    Image(systemName: "list.bullet")
                        .font(.title2)
                    Text("List")
                        .font(.caption)
                }
            }
            
        }
        .foregroundColor(.white)
        .blendMode(.overlay)
        .padding(.horizontal)
        .padding(.bottom, 30)
    }
}
