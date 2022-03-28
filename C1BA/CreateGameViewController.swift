//
//  CreateGameViewController.swift
//  C1BA
//
//  Created by Swabhan Katkoori on 3/12/22.
//

import UIKit

class CreateGameViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var timePicker: UIPickerView!
    var pickerData: [[String]] = [["12", "11", "10", "09", "08", "07", "06", "05", "04", "03", "02", "01"],["00", "01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59"]
    ]
    
    var minutes = 12
    var seconds = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.timePicker.delegate = self
        self.timePicker.dataSource = self
    }
    

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData[component].count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[component][row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            print(pickerData[component][row])
        if(component == 0){
            minutes = Int(pickerData[component][row])!
        } else {
            seconds = Int(pickerData[component][row])!
        }
    }
    
    @IBAction func startGame(_ sender: Any) {
        performSegue(withIdentifier: "scoreboardSegue", sender: (Any).self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "scoreboardSegue"{
            let destinationVC = segue.destination as! ViewController
            
            destinationVC.minutes = minutes
            destinationVC.seconds = seconds
            
            
            
            
        }
    }
}
