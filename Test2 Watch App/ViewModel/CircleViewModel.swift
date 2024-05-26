//
//  CircleViewModel.swift
//  Test2 Watch App
//
//  Created by Renaldi Antonio on 21/05/24.
//

import Foundation
import SwiftUI

class CircleViewModel: ObservableObject {
    @Published var gameText: String = "Start!"
    @Published var color = Color(.orange)
    @Published var strokeColor = Color(.white)
    
    let randomColor = {
        let colors: [Color] = [.green, .blue, .orange, .purple, .pink, .yellow]
        return colors.randomElement() ?? .black
    }
    
    func getRandomColor(){
        self.color = randomColor()
    }
    
    func tapNow(){
        strokeColor = Color(.green)
    }
    
    func tapMissed(){
        strokeColor = Color.red
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){ [self] in
            strokeColor = Color.white
        }
    }
    
    func hasTapped(){
        strokeColor = Color.white
    }
}
