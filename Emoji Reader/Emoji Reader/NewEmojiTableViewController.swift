//
//  NewEmojiTableViewController.swift
//  Emoji Reader
//
//  Created by Nataliia on 17.08.2020.
//  Copyright © 2020 Natalia. All rights reserved.
//

import UIKit

class NewEmojiTableViewController: UITableViewController {

    var emoji = Emoji(emoji: "", name: "", description: "", isFavourite: false)
    
    @IBOutlet weak var emojiTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        updateSaveButtonState()
    }
    
    private func updateSaveButtonState() {
        let emojiText = emojiTextField.text ?? ""
        let nameText = nameTextField.text ?? ""
        let descriptionText = descriptionTextField.text ?? ""
        
        saveButton.isEnabled = !emojiText.isEmpty && !nameText.isEmpty && !descriptionText.isEmpty
    }
    //сохраняем значения которые уже есть на первом экране при их переходе к их изминению
    private func updateUI() {
           emojiTextField.text = emoji.emoji
           nameTextField.text = emoji.name
           descriptionTextField.text = emoji.description
       }
    
    @IBAction func textChanged(_ sender: UITextField) {
     updateSaveButtonState()
    }
    
    //определяем переход со второго экрана обратно на первый
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           super.prepare(for: segue, sender: sender)
           guard segue.identifier == "saveSegue" else { return }
           
        //передаем значения из текстфилдов в параметры
           let emoji = emojiTextField.text ?? ""
           let name = nameTextField.text ?? ""
           let description = descriptionTextField.text ?? ""
           
        //и теперь все эти значения передаем в Emoji
           self.emoji = Emoji(emoji: emoji, name: name, description: description, isFavourite: self.emoji.isFavourite)
           
       }
}
