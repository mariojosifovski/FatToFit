//
//  ExerciseHeaderView.swift
//  FatToFit
//
//  Created by Mario Josifovski on 05/09/2019.
//  Copyright © 2019 Planesarc. All rights reserved.
//

import UIKit


protocol ExerciseHeaderViewDelegate: class {
    func exerciseHeaderView(_ view: ExerciseHeaderView, didInvoke action: UserActions)
}

class ExerciseHeaderView: UIView {

    // MARK: - user interface
    
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var controlsPannel: UIStackView!
    
    // TODO: Add logic for different modes if we want
    
    
    // MARK: - data connection
    
    weak var delegate: ExerciseHeaderViewDelegate?
    
    var datasource: Exercise? {
        didSet {
            updateInterface()
        }
    }
    
    
    // MARK: - lifecycle
    
    deinit {
        datasource = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        controlsPannel.isHidden = true
        
        UIView.animate(withDuration: 0.35) {
            self.controlsPannel.isHidden = false
        }
        
    }
    
    func updateInterface() {
        titleLabel.text = datasource?.title
    }
    
    
    // MARK: - actions

    @IBAction func addAction(_ sender: Any?) {
        delegate?.exerciseHeaderView(self, didInvoke: .add)
    }
    
    @IBAction func editAction(_ sender: Any?) {
        delegate?.exerciseHeaderView(self, didInvoke: .edit)
    }
    
    @IBAction func viewAction(_ sender: Any?) {
        delegate?.exerciseHeaderView(self, didInvoke: .view)
    }
    
    @IBAction func deleteAction(_ sender: Any?) {
        delegate?.exerciseHeaderView(self, didInvoke: .delete)
    }
    
    @IBAction func tapAction(_ sender: Any?) {
        delegate?.exerciseHeaderView(self, didInvoke: .view)
    }
    
}
