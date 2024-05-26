//
//  SongModel.swift
//  Test2 Watch App
//
//  Created by Renaldi Antonio on 18/05/24.
//

import Foundation

class SongModel{
    let name: String
    let beatMap: [Double]
    
    init(name: String, beatMap: [Double]) {
        self.name = name
        self.beatMap = beatMap
    }
}
