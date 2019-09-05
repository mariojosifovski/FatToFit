//
//  UITableViewExtension.swift
//  FatToFit
//
//  Created by Mario Josifovski on 05/09/2019.
//  Copyright © 2019 Planesarc. All rights reserved.
//

import UIKit

extension UITableView {
    
    func animateUpdates(_ block: @escaping (UITableView)->Void ) {
        
        DispatchQueue.main.async {
            
            self.beginUpdates()
            
            block(self)
            
            self.endUpdates()
            
        }
        
    }
    
}
