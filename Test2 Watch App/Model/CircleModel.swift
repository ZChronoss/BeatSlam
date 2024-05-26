//
//  CircleModel.swift
//  Test2 Watch App
//
//  Created by Renaldi Antonio on 18/05/24.
//

import Foundation
import SwiftUI

class CircleModel: ObservableObject{
    let shape = Circle()
    @Published var posX = 0.0
    @Published var posY = 0.0
    @Published var color = Color(.red)
    @Published var strokeColor = Color(.white)
}
