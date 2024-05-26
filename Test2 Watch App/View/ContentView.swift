//
//  ContentView.swift
//  Test2 Watch App
//
//  Created by Renaldi Antonio on 15/05/24.
//

import SwiftUI
import CoreMotion
import AVFAudio

struct ContentView: View {
    @ObservedObject var gameViewModel = GameViewModel(
        filename: "Once Upon A Time",
        beatMap: [1.0, 1.95, 3.8, 4.7, 5.6, 7.5, 8.3, 9.3, 10.2, 11.1, 12.0, 12.9, 14.7, 15.7, 16.6, 18.5, 19.38, 20.3, 22.1, 23.05, 23.9, 24.8, 25.7, 26.7, 27.6, 29.5, 30.4, 30.8, 31.2, 31.7, 32.2, 32.6, 33.2, 34, 34.6, 36.8, 37.7, 38.2, 38.6, 39.1, 39.6, 40, 40.5, 41.6, 42.4, 42.7, 43.2, 43.7, 44.1, 45, 45.5, 46.1, 46.4, 46.8, 47.5, 47.9, 48.7, 49.9, 51.6, 52.4, 52.9, 53.4, 53.7, 54.1, 54.6, 55.1, 56, 57, 57.5, 57.8, 58.4, 60.6, 62.4, 64.2, 66.1, 68, 69.7, 71.5, 100]
    )
    
    var body: some View {
        VStack(alignment: .center, content: {
            Text(gameViewModel.isGameOn ? "" : "Beat! Slam!")
                .padding(.top, 25)
            
            Button("\(gameViewModel.score)"){
                withAnimation(.easeInOut(duration: 0.5)) {
                    if gameViewModel.isGameOn{
                        gameViewModel.stopGame()
                    }
                }
            }
            .disabled(gameViewModel.disableButton)
            
            Button(action: {
                withAnimation(.easeInOut(duration: 0.5)) {
                    
                    if gameViewModel.isGameOn {
                        gameViewModel.checkTap()
                    }else{
                        gameViewModel.startGame()
                    }
                }
            }, label: {
                GeometryReader{ geometry in
                    ZStack{
//                        Circle()
//                            .stroke(gameViewModel.showOutline ? .white : .clear, lineWidth: 5)
                        Circle()
                            .stroke(gameViewModel.circleViewModel.strokeColor, lineWidth: 5)
                            .fill(gameViewModel.circleViewModel.color)
                            .aspectRatio(contentMode: .fit)
//                            .foregroundStyle(gameViewModel.circleViewModel.color)
                            .overlay{
                                Text(gameViewModel.circleViewModel.gameText)
                                    .transition(.blurReplace)
                                    .id("Info" + gameViewModel.circleViewModel.gameText)
                            }
                            .frame(width: gameViewModel.isGameOn ? 150 : 100)
                            .position(x: geometry.size.width/2, y: geometry.size.height/2)
                            
                    }
                }
                
            })
            .buttonStyle(PlainButtonStyle())
            .disabled(gameViewModel.disableButton)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.all)
            
        })
        .ignoresSafeArea(.all)
    }
}

#Preview {
    ContentView()
}
