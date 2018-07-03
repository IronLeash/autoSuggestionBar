//
//  ViewController.swift
//  AutoSuggestionBar
//
//  Created by Ilker Baltaci on 03.07.18.
//  Copyright © 2018 Ilker Baltaci. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet fileprivate var textfield: UITextField!
    @IBOutlet fileprivate var collectionView: AutoSuggestionCollectionView!
    
    private var words = ["Swift", "Kotlin", "Java", "Objective-C", "PHP", "Go", "Node.js", "Phyton", "Scala", "Pearl", "C++", "C#", "C"];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.setupWithWords(words: words)
        collectionView.selectionDelegate = self
        textfield.inputAccessoryView = self.collectionView
    }
    
    @IBAction func didChangeText(_ sender: UITextView) {
        if sender.text.count > 0 {
            collectionView.filterWordsWith(text: sender.text)
        }
        
        if sender.text == nil ||  sender.text.count == 0 {
            collectionView.resetFiltering()
        }
        
        textfield.inputAccessoryView = self.collectionView.needsToBevisible ?  self.collectionView : nil
        textfield.reloadInputViews()
    }
}

extension ViewController: AutoSuggestionCollectionViewDelegate {
    
    func autoSuggestionCollectionViewDidSelect(word: String, sender: AutoSuggestionCollectionView) {
        textfield.text = word
        textfield.resignFirstResponder()
        collectionView.resetFiltering()
    }
}



