//
//  ExercisesTableViewController.swift
//  FatToFit
//
//  Created by Mario Josifovski on 05/09/2019.
//  Copyright © 2019 Planesarc. All rights reserved.
//

import UIKit

class ExercisesTableViewController: UITableViewController {

    
    // MARK: - data and logic variables
    
    var datasource: [Exercise] = []
    
    // Used when we fill in exercise data and expect return to this value
    weak var selectedExercise: Exercise?
    weak var selectedSet: ExerciseSet?
    
    // Expansion control array for the table view
    var cellControl: [Bool] = []
    
    
    // MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.tableFooterView = UIView()
        
        // Uncomment the following line to preserve selection between presentations
        self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
        // Let's add some tutorial data
        let exercise = Exercise()
        exercise.title = "Tutorial"
        
        let set1 = ExerciseSet()
        set1.title = "Tap top right \"+\" to add a new exercise"
        
        let set2 = ExerciseSet()
        set2.title = "Tap on this exercise to minimise or expand"
        
        let set3 = ExerciseSet()
        set3.title = "Swipe left on a set to edit or delete"
        
        let set4 = ExerciseSet()
        set4.title = "Tap \"add set\" to add more like me"
        
        let set5 = ExerciseSet()
        set5.title = "Tap \"delete set\" to remove it"
        
        exercise.sets = [set1, set2, set3, set4, set5]
        
        datasource.append(exercise)
        cellControl.append(true)
    }

    
    
    // MARK: - user actions
    
    @IBAction func addNewExerciseAction(_ sender: Any?) {
        
        // Add new set to the datasource
        let exercise = Exercise()
        datasource.append(exercise)
        cellControl.append(true)
        
        // Update the data and display the added interface
        let sectionIndex = self.datasource.count - 1
        
        self.tableView.animateUpdates {
            tableView in
            tableView.insertSections(IndexSet(arrayLiteral: sectionIndex), with: .left)
        }
        
    }
    
    
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return datasource.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasource[section].sets.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "set", for: indexPath) as? ExerciseSetTableViewCell
        else
            { fatalError("Cell identifier was wrong or not handled cases remain") }

        
        let setData = datasource[indexPath.section].sets[indexPath.row]
        
        cell.datasource = setData
        cell.indexLabel.text = "Set #\(indexPath.row + 1)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let header = ExerciseHeaderView.createFromNib()
        
        header.delegate = self
        header.datasource = datasource[section]
        header.indexLabel.text = "Exercise #\(section + 1)"
        
        return header
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if cellControl[indexPath.section] {
            return tableView.rowHeight
        }
        
        return 0
    }
    
    
    // TODO: Add minimise logic for header
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//
//        if cellControl[section] {
//            return 75
//        }
//
//        return 50
//
//    }
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
 

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // Delete the row from the data source
            datasource[indexPath.section].sets.remove(at: indexPath.row)
            
            // Main thread refresh of table view content
            self.tableView.animateUpdates {
                tableView in
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
            }
            
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
        
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete", handler: { (action, indexPath) in
            
            self.datasource[indexPath.section].sets.remove(at: indexPath.row)
            
            // Main thread refresh of table view content
            self.tableView.animateUpdates {
                tableView in
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.reloadSections(IndexSet(arrayLiteral: indexPath.section), with: .automatic)
            }
            
        })
        
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit", handler: { (action, indexPath) in
            
            let exercise = self.datasource[indexPath.section]
            
            // Open the row interface and set style and all that things
            self.selectedExercise = exercise
            self.selectedSet = exercise.sets[indexPath.row]
            self.performSegue(withIdentifier: "addNewSet", sender: nil)
            
        })
        
        editAction.backgroundColor = UIColor(red: 33/255, green: 187/255, blue: 215/255, alpha: 1.0)
        
        
        return [deleteAction, editAction]
    }
    
    
    
    
 

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let addSetController = segue.destination as? AddSetViewController {
            addSetController.delegate = self
            addSetController.datasource = selectedSet
        }
        
    }
    

}


// MARK: - exercise header view delegate


extension ExercisesTableViewController : ExerciseHeaderViewDelegate {
    
    func exerciseHeaderView(_ view: ExerciseHeaderView, didInvoke action: UserActions) {
        
        guard let exercise = view.datasource else { return }
      
        switch action {
            
            // ------  ADD  ------
            case .add:
                
                selectedExercise = exercise
                self.performSegue(withIdentifier: "addNewSet", sender: nil)
                
                break
            
            // ------  EDIT  ------
            case .edit:
                
                // Just use default thing
                
                let alert = UIAlertController(title: "Exercise title", message: nil, preferredStyle: .alert)
                alert.addTextField { (textField) in
                    textField.text = exercise.title
                }
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                    if let textField = alert.textFields?.first {
                        exercise.title = textField.text
                        view.titleLabel.text = textField.text
                    }
                }))
                self.present(alert, animated: true, completion: nil)
                
                break
            
            
            // ------  DELETE  ------
            case .delete:
                
                if let section = datasource.firstIndex(where: { $0 === exercise }) {
                    
                    datasource.remove(at: section)
                    cellControl.remove(at: section)
                    
                    // Main thread refresh of table view content
                    self.tableView.animateUpdates {
                        tableView in
                        tableView.deleteSections(IndexSet(arrayLiteral: section), with: .right)
                    }
                    
                }
                break
        
            // ------  VIEW  ------
            case .view:
                
                if let section = datasource.firstIndex(where: { $0 === exercise }) {
                    cellControl[section] = !cellControl[section]
                    
                    // Main thread refresh of table view content
                    self.tableView.animateUpdates {
                        tableView in
                        
                        tableView.reloadSections(IndexSet(arrayLiteral: section), with: .fade)
                    }
                }
                
                break
        }
        
    }
    
}


// MARK: - add set controller delegate

extension ExercisesTableViewController : AddSetViewControllerDelegate {
    
    func addSetViewController(_ controller: AddSetViewController, didAdd set: ExerciseSet) {
        
        guard let exercise = selectedExercise else { return }
        
        let row: Int
        
        if set.type == .warmup {
            
            if let index = exercise.sets.firstIndex(where: { $0.type == .regular }) {
                row =  index
                exercise.sets.insert(set, at: row)
            }
            else {
                row = exercise.sets.count - 1
                exercise.sets.append(set)
            }
            
        }
        else {
            row = exercise.sets.count - 1
            exercise.sets.append(set)
        }
        
        
        
        if let section = datasource.firstIndex(where: { $0 === exercise }) {
            
            cellControl[section] = true
            
            let indexPath = IndexPath(row: row, section: section)
            
            // Main thread refresh of table view content
            self.tableView.animateUpdates {
                tableView in
                tableView.insertRows(at: [indexPath], with: .left)
                tableView.reloadSections(IndexSet(arrayLiteral: section), with: .fade)
            }
            
        }
        
        selectedExercise = nil
        selectedSet = nil
    }
    
    func addSetViewController(_ controller: AddSetViewController, didFinishEditing set: ExerciseSet) {
        
        guard
            let exercise = selectedExercise,
            let set = selectedSet,
            let section = datasource.firstIndex(where: { $0 === exercise }),
            var row = exercise.sets.firstIndex(where: { $0 === set })
        else { return }
        
        
        // Reindex the set if needed
        
        if set.type == .regular,
            let lastWarmupSetIndex = exercise.sets.lastIndex(where: { $0.type == .warmup }),
            row < lastWarmupSetIndex {
            exercise.sets.remove(at: row)   // Move to last
            exercise.sets.append(set)
            row = exercise.sets.count - 1
        }
        else if set.type == .warmup,
            let firstRegularSetIndex = exercise.sets.firstIndex(where: { $0.type == .regular }),
            row > firstRegularSetIndex {
            exercise.sets.remove(at: row)
            exercise.sets.insert(set, at: firstRegularSetIndex)
            row = firstRegularSetIndex
        }
        
        cellControl[section] = true
            
        let indexPath = IndexPath(row: row, section: section)
            
        // Main thread refresh of table view content
        self.tableView.animateUpdates {
            tableView in
            tableView.insertRows(at: [indexPath], with: .left)
            tableView.reloadSections(IndexSet(arrayLiteral: section), with: .fade)
        }
        
        selectedExercise = nil
        selectedSet = nil
    }
    
    func addSetViewControllerDidCancel() {
        selectedExercise = nil
        selectedSet = nil
    }
    
    
}
