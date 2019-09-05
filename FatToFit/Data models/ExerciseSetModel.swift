//
//  ExerciseSetModel.swift
//  FatToFit
//
//  Created by Mario Josifovski on 05/09/2019.
//  Copyright © 2019 Planesarc. All rights reserved.
//

import Foundation


class ExerciseSet {

    enum SetType {
        case warmup
        case regular
    }
    
    var id = 0
    var title: String?
    var repetitions: Int = 0
    var type: SetType = .warmup
    
}
