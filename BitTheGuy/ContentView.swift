//
//  ContentView.swift
//  BitTheGuy
//
//  Created by Rafael Rodriguez on 5/30/24.
//

import SwiftUI
import AVFAudio

struct ContentView: View {
    @State private var audioPlayer: AVAudioPlayer!
//    @State private var scale = 1.0  // 100% scale
    @State private var animateImage = true
    var body: some View {
        VStack {
            Spacer()
            Image ("clown")
                .resizable()
                .scaledToFit()
//                .scaleEffect(scale)
                .scaleEffect(animateImage ? 1.0 : 0.9)
                .onTapGesture {
                    playSound(soundName: "punchSound")
//                    scale += 0.1 // Increase scale by 10%
                    animateImage = false // will immediately shrink using .scaleEffect to 90% of size
                    withAnimation (.spring(response: 0.3, dampingFraction: 0.3)) {
                        animateImage = true  // will go from 90% to 100% using the .spring animation
                    }
                }
//                .animation(.spring(response: 0.3, dampingFraction: 0.3), value: scale)
            
            Spacer()
            
            Button(action: {
                //TODO: Button action here
            }, label: {
                Label("Photo Library", systemImage: "photo.fill.on.rectangle.fill")
            })        }
        .padding()
    }
    
    func playSound(soundName: String) {
        guard let soundFile = NSDataAsset(name: soundName) else {
            print ("😡 ERROR: Could not read file named \(soundName)")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.play()
        } catch {
            print ("😡 ERROR: \(error.localizedDescription) playing audioPlayer.")
            
        }
    }
}

#Preview {
    ContentView()
}
