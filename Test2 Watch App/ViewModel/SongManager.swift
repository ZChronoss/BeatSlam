//
//  SongManager.swift
//  Test2 Watch App
//
//  Created by Renaldi Antonio on 18/05/24.
//

import Foundation
import AVFAudio

class SongManager {
    var audioPlayer = AVAudioPlayer()
    let song: SongModel
    
    init(song: SongModel){
        self.song = song
        prepareAudio(song: song)
    }
    
    private func prepareAudio(song: SongModel){
        let path = Bundle.main.path(forResource: song.name, ofType: ".mp3")!
        let url = URL(fileURLWithPath: path)
        audioPlayer = try! AVAudioPlayer(contentsOf: url)
        audioPlayer.prepareToPlay()
    }
    
    func play(){
        audioPlayer.play()
    }
    
    func stop(){
        audioPlayer.currentTime = 0
        audioPlayer.stop()
    }
}
