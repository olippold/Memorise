//
//  MemoryViewController.swift
//  Memorise
//
//  Created by Oliver Lippold on 01/02/2020.
//  Copyright © 2020 Oliver Lippold. All rights reserved.
//

import UIKit

class MemoryViewController: UIViewController {
    var memoryItem: MemoryItem!
    var blankCounter = 0
    
    let visibleText: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "Georgia", size: 28)!,
        .foregroundColor: UIColor.black,
    ]
    
    let invisibleText: [NSAttributedString.Key: Any] = [
        .font: UIFont(name: "Georgia", size: 28)!,
        .foregroundColor: UIColor.clear,
        .strikethroughStyle: 1,
        .strikethroughColor: UIColor.black
    ]

    @IBOutlet var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        assert(memoryItem != nil, "You must provide an item before trying to show this view controller.")
        
        let tapRecogniser = UITapGestureRecognizer(target: self, action: #selector(wordsTapped))
        textView.addGestureRecognizer(tapRecogniser)
        textView.attributedText = showText(for: memoryItem)
    }
    
    func showText(for memoryItem: MemoryItem) -> NSAttributedString {
        let words = memoryItem.text.components(separatedBy: " ")
        let output = NSMutableAttributedString()
        
        // a reusable attributed string to handle spaces correctly
        let space = NSAttributedString(string: " ", attributes: visibleText)
        
        for (index, word) in words.enumerated() {
            if index < blankCounter {
                // this word should be visible
                let attributedWord = NSAttributedString(string: "\(word)", attributes: visibleText)
                output.append(attributedWord)
            } else {
                // this word should be invisible
                // take a copy of our word so we can strip punctuation from it
                var strippedWord = word
                
                // if we find any punctuation, we'll store it here
                var punctuation: String?
                
                // if the last letter of this word is period or comma, remove it and
                // place it into 'punctuation'
                if ".,".contains(word.last!) {
                    punctuation = String(strippedWord.removeLast())
                }
                
                // add the invisible string as normal
                let attributedWord = NSAttributedString(string: "\(word)", attributes: invisibleText)
                output.append(attributedWord)
                
                // if we found any punctuation, add it using the visible attributes
                if let symbol = punctuation {
                    let attributedPunctuation = NSAttributedString(string: symbol, attributes: visibleText)
                    output.append(attributedPunctuation)
                }
            }
            output.append(space)
        }
        return output
    }
    
    @objc func wordsTapped() {
        blankCounter += 1
        textView.attributedText = showText(for: memoryItem)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
