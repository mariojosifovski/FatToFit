//
//  AddSetViewController.swift
//  FatToFit
//
//  Created by Mario Josifovski on 05/09/2019.
//  Copyright © 2019 Planesarc. All rights reserved.
//

import UIKit


protocol AddSetViewControllerDelegate : class {
    func addSetViewController(_ controller: AddSetViewController, didAdd set: ExerciseSet)
    func addSetViewController(_ controller: AddSetViewController, didFinishEditing set: ExerciseSet)
    func addSetViewControllerDidCancel()
}


class AddSetViewController: UIViewController {

    // MARK: - user interface
    
    @IBOutlet weak var txtTitle: UITextField!
    @IBOutlet weak var setType: UISegmentedControl!
    @IBOutlet weak var txtRepetitions: UITextField!
    @IBOutlet weak var stepperRepetitions: UIStepper!
    @IBOutlet weak var submitButton: UIButton!
    
    
    // MARK: - data connections
    
    var datasource: ExerciseSet?
    
    weak var delegate: AddSetViewControllerDelegate?
    
    // MARK: - lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let contentView = view.subviews.first {
            
            contentView.transform = CGAffineTransform(translationX: 0, y: view.bounds.height)
            
            UIView.animate(withDuration: 0.35,
                           delay: 0.3,
                           usingSpringWithDamping: 0.7,
                           initialSpringVelocity: 1,
                           options: .curveEaseInOut,
                           animations: {
                                contentView.transform = CGAffineTransform.identity
                           },
                           completion: nil)
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        submitButton.layer.cornerRadius = 10
        submitButton.layer.masksToBounds = true
        
        // Reverse delegate for text field - to - stepper
        txtRepetitions.delegate = self
        
        
        // Edit mode
        if let set = datasource {
            txtTitle.text = set.title
            setType.selectedSegmentIndex = set.type == ExerciseSet.SetType.warmup ? 0 : 1
            stepperRepetitions.value = Double(set.repetitions)
            txtRepetitions.text = "\(set.repetitions)"
        }
        
    }
    
    
    // MARK: - user actions
    
    @IBAction func stepperValueDidChange(_ sender: Any?) {
        txtRepetitions.text = "\(Int(stepperRepetitions.value))"
    }
    
    
    @IBAction func tapOutsideAction(_ sender: Any?) {
        
        if txtRepetitions.isFirstResponder {
            txtRepetitions.resignFirstResponder()
        }
        else if txtTitle.isFirstResponder {
            txtTitle.resignFirstResponder()
        }
        else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    @IBAction func submitAction(_ sender: Any?) {
        
        if datasource != nil {
            
            // Push the values back to the set
            datasource?.title = txtTitle.text
            datasource?.type = setType.selectedSegmentIndex == 0 ? ExerciseSet.SetType.warmup : ExerciseSet.SetType.regular
            datasource?.repetitions = Int(stepperRepetitions.value)
            
            // Notify the delegate
            delegate?.addSetViewController(self, didFinishEditing: datasource!)
        }
        else {
            
            // Generate the new set
            let set = ExerciseSet()
            set.title = txtTitle.text
            set.type = setType.selectedSegmentIndex == 0 ? ExerciseSet.SetType.warmup : ExerciseSet.SetType.regular
            set.repetitions = Int(stepperRepetitions.value)
            
            // Send forward the new set using delegate
            delegate?.addSetViewController(self, didAdd: set)
        }
            
            
        dismiss(animated: true, completion: nil)
    }
    
}


extension AddSetViewController : UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        //stepperRepetitions.value = Double( Int(textField.text ?? "") ?? 0 )
        //txtRepetitions.text = "\(Int(stepperRepetitions.value))"
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
}
