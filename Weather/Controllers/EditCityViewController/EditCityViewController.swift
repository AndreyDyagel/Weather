//
//  EditCityViewController.swift
//  Weather
//
//  Created by Андрей on 25.02.2021.
//

import UIKit

class EditCityViewController: UIViewController {

    @IBOutlet weak var exitButtonOutlet: UIButton!

    var editCityArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        editCityArray = cityArray
        exitButtonOutlet.layer.cornerRadius = exitButtonOutlet.frame.width/2
    }
    
    @IBAction func exitButtonAction(_ sender: UIButton) {
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            cityArray = self.editCityArray
            UserDefaults.standard.setValue(cityArray, forKey: "city")
        }
    }
}

extension EditCityViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return editCityArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = editCityArray[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            editCityArray.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
}
