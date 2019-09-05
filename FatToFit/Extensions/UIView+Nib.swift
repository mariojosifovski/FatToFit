//
//  UIView+Nib.swift
//  FatToFit
//
//  Created by Mario Josifovski on 05/09/2019.
//  Copyright © 2019 Planesarc. All rights reserved.
//

import UIKit

public extension UIView {
    
    class func createFromNib() -> Self {
        
        func genericCreate<T>() -> T where T: UIView {
            let nibName = String(describing: T.self);
            let nib = UINib(nibName: nibName, bundle: Bundle.main);
            
            guard let result = nib.instantiate(withOwner: nil, options: nil).first as? T else {
                fatalError("\(nibName).xib is not present in the given bundle");
            }
            
            return result;
        }
        
        return genericCreate();
    }
    
    
    class func createFromNib(nib: String) -> UIView {
        let nib = UINib(nibName: nib, bundle: Bundle.main);
        
        guard let result = nib.instantiate(withOwner: nil, options: nil).first as? UIView else {
            fatalError("\(nib).xib is not present in the given bundle");
        }
        
        return result;
    }
    
}
