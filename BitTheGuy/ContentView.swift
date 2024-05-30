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
    var body: some View {
        VStack {
            Spacer()
            Image ("clown")
                .resizable()
                .scaledToFit()
                .onTapGesture {
                    playSound(soundName: "punchSound")
                }
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
