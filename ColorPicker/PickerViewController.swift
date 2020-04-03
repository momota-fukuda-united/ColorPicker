//
//  ColorPickerViewController.swift
//  ColorPicker
//
//  Created by 福田 桃太 on 2020/04/03.
//  Copyright © 2020 momota-fukuda. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    private var selections: [String] = []
    var selected :String = ""
    
    @IBOutlet weak private var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        
        let row:Int = selections.firstIndex(of: self.selected) ?? 0
        self.pickerView.selectRow(row, inComponent: 0, animated: false)
    }
    
    func setSelections(selections :[String], selected: String) {
        self.selections = selections
        self.selected = selected
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.selections.count
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.selections[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selected = self.selections[row]
    }
}
