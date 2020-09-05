//
//  EmojiTableVC.swift
//  Emoji Reader
//
//  Created by Nataliia on 16.08.2020.
//  Copyright © 2020 Natalia. All rights reserved.
//

import UIKit

class EmojiTableVC: UITableViewController {
    
    var objects = [
        Emoji(emoji: "💖" ,name: "Love " ,description: "Let's love each other ",isFavourite: false),
        Emoji(emoji: "⚽" ,name: "Football " ,description: "Let's play football ",isFavourite: false),
        Emoji(emoji: "🐈" ,name: "Cat" ,description: "Cat's are cutest animals ",isFavourite: false),
        Emoji(emoji: "🐕" ,name: "Dog " ,description: "Dog's are most friendly animals ",isFavourite: false),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Emoji Reader"
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
        @IBAction func unwindSegue(segue: UIStoryboardSegue) {
            // определяем переход с помоью индетификаотра
            guard segue.identifier == "saveSegue" else { return }
            //передаем массив из вторго экрана на первый
                   let sourceVC = segue.source as! NewEmojiTableViewController
                   let emoji = sourceVC.emoji
            //для того чтобы измененная ячейка сохранялась в прошлую а не создавалась новая
                   if let selectedIndexPath = tableView.indexPathForSelectedRow {
                       objects[selectedIndexPath.row] = emoji
                       tableView.reloadRows(at: [selectedIndexPath], with: .fade)
                   } else {
                       let newIndexPath = IndexPath(row: objects.count, section: 0)
                       objects.append(emoji)
                       tableView.insertRows(at: [newIndexPath], with: .fade)
                   }
    }
       override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            super.prepare(for: segue, sender: sender)
            guard segue.identifier == "editEmoji" else { return }
            let indexPath = tableView.indexPathForSelectedRow!
            let emoji = objects[indexPath.row]
            let navigaionVC = segue.destination as! UINavigationController
            let newEmojiVC = navigaionVC.topViewController as! NewEmojiTableViewController
            newEmojiVC.emoji = emoji
            newEmojiVC.title = "Edit"
        }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return objects.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emojiCell", for: indexPath) as! EmojiTableViewCell
        let object = objects[indexPath.row]
        cell.set(object: object)
        return cell
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at:indexPath.row)
             tableView.deleteRows(at: [indexPath], with: .fade)
      }
    }
            override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
                let movedEmoji = objects.remove(at: sourceIndexPath.row)
                objects.insert(movedEmoji, at: destinationIndexPath.row)
                tableView.reloadData()
            }
   //пишем код для свайпнутых слева кнопок удалить и лайк
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
           let done = doneAction(at: indexPath)
           let favourite = favouriteAction(at: indexPath)
           return UISwipeActionsConfiguration(actions: [done, favourite])
       }
       
       func doneAction(at indexPath: IndexPath) -> UIContextualAction {
           let action = UIContextualAction(style: .destructive, title: "Done") { (action, view, completion) in
               self.objects.remove(at: indexPath.row)
               self.tableView.deleteRows(at: [indexPath], with: .automatic)
               completion(true)
           }
           action.backgroundColor = .systemGreen
           action.image = UIImage(systemName: "checkmark.circle")
           return action
       }
       
       func favouriteAction(at indexPath: IndexPath) -> UIContextualAction {
           var object = objects[indexPath.row]
           let action = UIContextualAction(style: .normal, title: "Favourite") { (action, view, completion) in
               object.isFavourite = !object.isFavourite
               self.objects[indexPath.row] = object
               completion(true)
           }
           action.backgroundColor = object.isFavourite ? .systemPurple : .systemGray
           action.image = UIImage(systemName: "heart")
           return action
       }
}

