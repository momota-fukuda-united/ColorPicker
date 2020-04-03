//
//  ViewController.swift
//  ColorPicker
//
//  Created by 福田 桃太 on 2020/04/03.
//  Copyright © 2020 momota-fukuda. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let defaultColorKey = "Blue"
    let colorDic = ["Red": UIColor(red: 1, green: 0, blue: 0, alpha: 1), "Blue": UIColor(red: 0, green: 0, blue: 1, alpha: 1), "Green": UIColor(red: 0, green: 1, blue: 0, alpha: 1)]
    let cellSpace :Float = 1;
    let cellCountOfRow = 3

    @IBOutlet private weak var colorCollectionView: UICollectionView!
    
    private var selectedIndex: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.colorCollectionView.delegate = self
        self.colorCollectionView.dataSource = self
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let colorPickerViewController = segue.destination as? PickerViewController
        if colorPickerViewController == nil {
            return
        }
        
        colorPickerViewController?.setSelections(selections: [String](self.colorDic.keys), selected: self.defaultColorKey)
    }
    
    @IBAction func unwind(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source as? PickerViewController
        // Use data from the view controller which initiated the unwind segue
        if sourceViewController == nil {
            return
        }
        
        if self.selectedIndex == nil {
            return
        }
        
        let targetCell = self.colorCollectionView.cellForItem(at: self.selectedIndex!)
        targetCell?.backgroundColor = self.colorDic[sourceViewController!.selected]
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.colorCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = self.colorDic[self.defaultColorKey]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.selectedIndex = indexPath
        
        self.performSegue(withIdentifier: "colorPicker", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: self.cellSpace.f, left: self.cellSpace.f, bottom: self.cellSpace.f, right: self.cellSpace.f)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellAreaWidth = self.colorCollectionView.frame.width - self.cellSpace.f * (self.cellCountOfRow + 1).f
        let cellSize = cellAreaWidth / self.cellCountOfRow.f
        return CGSize(width: cellSize, height: cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(self.cellSpace)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(self.cellSpace)
    }
}

