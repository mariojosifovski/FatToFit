//
//  ExerciseSetTableViewCell.swift
//  FatToFit
//
//  Created by Mario Josifovski on 05/09/2019.
//  Copyright © 2019 Planesarc. All rights reserved.
//

import UIKit

class ExerciseSetTableViewCell: UITableViewCell {

    // MARK: user interface
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var repetitionsLabel: UILabel!
    @IBOutlet weak var typeIndicatorView: UIView!
    
    // MARK: data connections
    
    var datasource: ExerciseSet? {
        didSet {
            updateInterface()
        }
    }
    
    func updateInterface() {
        
        guard
            let set = datasource
        else {
        //    reset()
            return
        }
        
        
        // Set the title value
        titleLabel.text = set.title
        
        // Set the repetitions
        repetitionsLabel.text = "x\(set.repetitions)"
        repetitionsLabel.isHidden = set.repetitions == 0
        
        // Set the indicator color
        typeIndicatorView.backgroundColor = set.type.indicatorColor
        
    }
    
    
    
    // MARK: lifecycle

    deinit {
        datasource = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}



extension ExerciseSet.SetType {
    var indicatorColor: UIColor {
        switch self {
        case .regular:
            return UIColor(red: 33/255, green: 187/255, blue: 215/255, alpha: 1.0)
        case .warmup:
            return UIColor.orange
        }
    }
}
