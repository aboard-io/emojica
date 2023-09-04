//
//  ------------------------------------------------------------------------
//
//  Copyright 2017 Dan Lindholm
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//  ------------------------------------------------------------------------
//
//  ViewController.swift
//

import UIKit
import Emojica

class ViewController: UIViewController, UITextViewDelegate {
    
    // MARK: - Initialization
    let emojica = Emojica()
    
    // MARK: - Modifiable values
    lazy var font = UIFont.systemFont(ofSize: 28, weight: UIFont.Weight.thin)
    
    // MARK: - Usage of convert
    func convert() {
        textView.attributedText = emojica.convert(string: textView.emojicaText)
    }
    
    // MARK: - Usage of revert
    func revert() {
        textView.text = emojica.revert(attributedString: textView.emojicaText)
    }
    
    // MARK: - Usage of textViewDidChange(_:)
    func textViewDidChange(_ textView: UITextView) {
        guard state.isOn else { return }
        emojica.textViewDidChange(textView)
    }
    
    // MARK: - Ignore
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var bottom: NSLayoutConstraint!
    
    @IBOutlet weak var state: UISwitch!
    @IBAction func stateChanged(_ sender: UISwitch) {
        state.isOn ? convert() : revert()
    }
    
    
}

// MARK: - Ignore
extension ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    func setup() {
        navigationItem.titleView = UIImageView(image: UIImage(named: "logo"))
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillChangeFrame(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        textView.delegate = self
        textView.text = "V14 emoji 🫠🫢🫣🫡🫥🫤🥹🫱🏿🫱🫲🫲🏽🫳🫴🫰🫰🏽🫵🏾🫵🏾🫶🫦🫅🫄🫃🧌🪸🪷🪹🪺🫘🫙🫗🛝🛞🛟🪬🪩🪫🩼🩻🫧🪪🟰"
        textView.font = font
        emojica.font = font
        emojica.revertible = true
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        if let info = notification.userInfo {
            let animationTime = info[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
            bottom.constant = 0
            UIView.animate(withDuration: animationTime, animations: { self.view.layoutIfNeeded() })
        }
    }
    
    @objc func keyboardWillChangeFrame(_ notification: NSNotification) {
        if let info = notification.userInfo {
            let animationTime = info[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
            let endFrame = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            bottom.constant = endFrame.height
            UIView.animate(withDuration: animationTime, animations: { self.view.layoutIfNeeded() })
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textView.resignFirstResponder()
    }
}
