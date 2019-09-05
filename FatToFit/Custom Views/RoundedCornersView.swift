//
//  RoundedCornersView.swift
//  FatToFit
//
//  Created by Mario Josifovski on 05/09/2019.
//  Copyright © 2019 Planesarc. All rights reserved.
//

import UIKit

class RoundedCornersView: UIView {

    override func awakeFromNib() {
        
        layer.cornerRadius = 20
        layer.masksToBounds = true
        
    }

}
