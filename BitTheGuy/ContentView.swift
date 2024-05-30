//
//  ContentView.swift
//  BitTheGuy
//
//  Created by Rafael Rodriguez on 5/30/24.
//

import SwiftUI
import AVFAudio
import PhotosUI


struct ContentView: View {
    @State private var audioPlayer: AVAudioPlayer!
    //    @State private var scale = 1.0  // 100% scale
    @State private var animateImage = true
    @State private var selectedPhoto: PhotosPickerItem?
    @State private var bipImage = Image("clown")
    var body: some View {
        VStack {
            Spacer()
//                        Image ("clown")
            bipImage
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
            
            PhotosPicker(selection: $selectedPhoto, matching: .images, preferredItemEncoding: .automatic) {
                Label("Photo Library", systemImage: "photo.fill.on.rectangle.fill")
            }
            .onChange(of: selectedPhoto) { oldValue, newValue in
                // - get the data inside the PhotosPickerItem selectedPhoto
                // - use the data to create a UIImage,
                // - use the UIImage to create an Image,
                // - and assign that image to bipImage
                Task {
                    do {
                        if let data = try await newValue?.loadTransferable(type: Data.self) {
                            if let uiImage = UIImage(data: data) {
                                bipImage = Image(uiImage: uiImage)
                            }
                        }
                    } catch {
                        print ("😡 ERROR: loading failed \(error.localizedDescription)")
                    }
                }
            }
            
            .buttonStyle(.borderedProminent)
            
            //            Button(action: {
            //                //TODO: Button action here
            //            }, label: {
            //                Label("Photo Library", systemImage: "photo.fill.on.rectangle.fill")
            //            })
        }
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
