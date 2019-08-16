//
//  ViewController.swift
//  iOS-Localize
//
//  Created by Denis Svichkarev on 16/08/2019.
//  Copyright © 2019 Denis Svichkarev. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet var textView1: NSTextView!
    @IBOutlet var textView2: NSTextView!
    
    var localizedStrings = [LocalizedString]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - IB Actions
    
    @IBAction func onShowRightValuesButtonPressed(_ sender: Any) {
        
        localizedStrings = [LocalizedString]()
        
        let text = textView1.string.replacingOccurrences(of: "\n\n", with: "\n \n", options: NSString.CompareOptions.literal, range: nil)
        
        let lines = text.split(separator: "\n")
        //print(lines)
        
        for string in lines {
            if localizedStrings.count < 100 {
                localizedStrings.append(LocalizedString(original: String(string)))
            }
        }
        
        textView1.string = ""
        var rightValuesString: String = ""
        
        for string in localizedStrings {
            if string.isCorrectString {
                rightValuesString.append(string.rightValue + "\n")
            }
        }
        
        textView1.string = rightValuesString
    }
    
    @IBAction func onShowFinalStringsButtonPressed(_ sender: Any) {
        let text = textView2.string
        let lines = text.split(separator: "\n")
        
        var lastIndex = 0
        
        for i in 0..<lines.count {
            let j = lastIndex
            
            for k in j..<localizedStrings.count {
                if localizedStrings[k].isCorrectString {
                    localizedStrings[k].rightValue = String(lines[i])
                    lastIndex = k + 1
                    break
                }
            }
        }
        
        textView2.string = ""
        var finalString: String = ""
        
        for string in localizedStrings {
            finalString.append(string.getFinalString() + "\n")
        }
        
        textView2.string = finalString
    }
    
    @IBAction func onCopyButtonPressed(_ sender: Any) {
        let pasteboard = NSPasteboard.general
        pasteboard.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
        pasteboard.setString(textView2.string, forType: NSPasteboard.PasteboardType.string)
    }
    
    @IBAction func onCopyRightValuesButtonPressed(_ sender: Any) {
        let pasteboard = NSPasteboard.general
        pasteboard.declareTypes([NSPasteboard.PasteboardType.string], owner: nil)
        pasteboard.setString(textView1.string, forType: NSPasteboard.PasteboardType.string)
    }
    
    @IBAction func onLeftClearButtonPressed(_ sender: Any) {
        textView1.string = ""
    }
    
    @IBAction func onRightClearButtonPressed(_ sender: Any) {
        textView2.string = ""
    }
}

