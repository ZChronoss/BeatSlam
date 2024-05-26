//
//  GameViewModel.swift
//  Test2 Watch App
//
//  Created by Renaldi Antonio on 21/05/24.
//

import Foundation
import AVFAudio
import CoreMotion
import WatchKit

class GameViewModel: ObservableObject{
//    Game
    @Published var isGameOn = false
    @Published var beatTimesIndex = 0
    @Published var score: Int = 0
    private let tolerance: Double = 0.29
    var timer: Timer?
    
//    Song
    private let song: SongModel
    let songManager: SongManager
    let beatMap: [Double]
    
//    Motion
    let motion = CMMotionManager()
    var queue = OperationQueue()
    
//    Circle
    var circleViewModel = CircleViewModel()
    @Published var disableButton = false
    
    init(filename: String, beatMap: [Double]){
        self.song = SongModel(name: filename, beatMap: beatMap)
        self.songManager = SongManager(song: song)
        self.beatMap = song.beatMap
    }
    
    func startGame(){
        beatTimesIndex = 0
        score = 0
        disableButton = true
        circleViewModel.gameText = "Ready?"
        isGameOn.toggle()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
            self.disableButton = false
            self.circleViewModel.gameText = "Slam!"
            self.songManager.play()
            self.startAccelerometer()
            self.hasPassedIndex()
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { [self] _ in
                hasPassedIndex()
                
                if self.songManager.audioPlayer.currentTime == self.songManager.audioPlayer.duration {
                    stopGame()
                }
            }
        }
    }
    
    func stopGame(){
        songManager.stop()
        circleViewModel.gameText = "Start!"
        timer!.invalidate()
        circleViewModel.hasTapped()
        isGameOn.toggle()
    }
    
    func hasPassedIndex(){
        let curSongTime = self.songManager.audioPlayer.currentTime
        let timing = curSongTime - beatMap[self.beatTimesIndex]
        if timing > self.tolerance && self.beatTimesIndex < beatMap.count - 1 {
            self.beatTimesIndex += 1
        }
    }
    
    func startAccelerometer(){
        if motion.isAccelerometerAvailable{
            motion.accelerometerUpdateInterval = 1/5
            motion.startAccelerometerUpdates(to: self.queue) { data, error in
                
                if abs((data?.acceleration.x)!) > 1.0 || abs((data?.acceleration.z)!) > 1.0  {
                    self.circleViewModel.getRandomColor()
                    
                    self.checkTap()
                }
            }
        }
    }
    
    func checkTap(){
        let songTime = songManager.audioPlayer.currentTime
        let beatMap = song.beatMap
        
        if abs(songTime - beatMap[beatTimesIndex]) <= tolerance {
            WKInterfaceDevice.current().play(WKHapticType.success)
            score += 10
            circleViewModel.hasTapped()
            if beatTimesIndex + 1 != beatMap.count {
                beatTimesIndex += 1
            }
        }else{
            if score > 0 && isGameOn{
                score -= 5
                circleViewModel.tapMissed()
            }
        }
    }
}
