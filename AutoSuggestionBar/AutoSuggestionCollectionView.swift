//
//  AutoSuggestionCollectionView.swift
//  AutoSuggestionBar
//
//  Created by Ilker Baltaci on 03.07.18.
//  Copyright © 2018 Ilker Baltaci. All rights reserved.
//

import UIKit

protocol AutoSuggestionCollectionViewDelegate: class {
    func autoSuggestionCollectionViewDidSelect(word: String, sender: AutoSuggestionCollectionView)
}

class AutoSuggestionCollectionView: UICollectionView {

    private var suggestionWords: [String]  = []
    private var filteredWords: [String]?
    
    weak var selectionDelegate: AutoSuggestionCollectionViewDelegate?
    
    var needsToBevisible: Bool {
        return (filteredWords == nil || filteredWords?.isEmpty == false)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate = self
        self.dataSource = self
        setupLayout()
    }
    
    func resetFiltering() {
        self.filteredWords = nil
        reloadData()
    }
    
    func filterWordsWith(text: String) {
        let newList = suggestionWords.filter { $0.lowercased().contains(text.lowercased()) }
        self.filteredWords = newList
        reloadData()
    }
    
    func setupWithWords(words: [String]){
        self.suggestionWords = words
        self.reloadData()
    }
    
    private func setupLayout(){
        let layout  = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.minimumInteritemSpacing = 15
        layout.minimumLineSpacing = 15
        layout.estimatedItemSize = CGSize(width: 50, height: 50)
        self.setCollectionViewLayout(layout, animated: false)
    }

}

extension AutoSuggestionCollectionView : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredWords != nil ? filteredWords!.count :  suggestionWords.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "autoSuggestionCell", for: indexPath) as! AutoSuggestionCell
        let word = filteredWords != nil ? filteredWords![indexPath.row] :  suggestionWords[indexPath.row]
        cell.label.text = word
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let word = filteredWords != nil ? filteredWords![indexPath.row] :  suggestionWords[indexPath.row]
        selectionDelegate?.autoSuggestionCollectionViewDidSelect(word: word, sender: self)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! AutoSuggestionCell
        cell.setHighlighted(highlighted: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! AutoSuggestionCell
        cell.setHighlighted(highlighted: false)
    }
    
    
}
