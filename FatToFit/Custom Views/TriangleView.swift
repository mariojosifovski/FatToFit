//
//  TriangleView.swift
//  FatToFit
//
//  Created by Mario Josifovski on 05/09/2019.
//  Copyright © 2019 Planesarc. All rights reserved.
//

import UIKit

class TriangleView: UIView {

    override public class var layerClass: Swift.AnyClass {
        get {
            return CAShapeLayer.self
        }
    }
    
    var shapeLayer: CAShapeLayer {
        return self.layer as! CAShapeLayer
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Make a triangle path right aligned (pointed to the right)
        let w = bounds.width
        let h = bounds.height
        
        let path = UIBezierPath()
        path.move(to: CGPoint.zero)
        path.addLine(to: CGPoint(x: w, y: h/2))
        path.addLine(to: CGPoint(x: 0, y: h))
        path.close()
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }

    
}
