//
//  AudioManager.swift
//  BlueBudget
//
//  Created by Isabela Bastos Jastrombek on 22/02/24.
//

import Foundation
import AVFoundation

class AudioManager: ObservableObject {
    var players: [AVAudioPlayer] = []

    func playAudio(for songName: String) {
        if let path = Bundle.main.path(forResource: songName, ofType: "mp3") {
            let url = URL(fileURLWithPath: path)

            do {
                let player = try AVAudioPlayer(contentsOf: url)
                players.append(player)
                player.play()
            } catch {
                print("Erro ao carregar o arquivo de áudio.")
            }
        }
    }
    
    func playTick() {
        playAudio(for: "tick")
    }
    
    func playTrash() {
        playAudio(for: "paper")
    }

    func stopAll() {
        for player in players {
            player.stop()
        }
        players.removeAll()
    }
}
