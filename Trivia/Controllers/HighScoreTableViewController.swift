//
//  HighScoreTableViewController.swift
//  Trivia
//
//  Created by doortje on 14/12/2018.
//  Copyright © 2018 Doortje. All rights reserved.
//

import UIKit

class HighScoreTableViewController: UITableViewController {
    
    var highscoreItems = [HighScoreItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        uploadOrder()
    }

    // Aantal cellen naar het aantal highscore Items
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return highscoreItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:
            "scoreCellIdentifier", for: indexPath)
        configure(cell, forItemAt: indexPath)
        return cell
    }
    
    
    func configure(_ cell: UITableViewCell, forItemAt indexPath:
        IndexPath) {
        
        // Naam van de categorie in het texlabel.
        cell.textLabel?.text = highscoreItems[indexPath.row].user
        cell.detailTextLabel?.text = highscoreItems[indexPath.row].score
    }
    
    // Upload de score en naam naar submitScore.
    func uploadOrder() {
        // Roept submitScore uit de MenuController aan.
        MenuController.shared.submitScore(forHighScore: highscoreItems[0]) {
// Haalt de highsc
            MenuController.shared.fetchHighscore { (highscoreitems) in
                if let highscore = highscoreitems {
                    DispatchQueue.main.async {
                        self.highscoreItems = highscore
                        self.tableView.reloadData()
                    }
                }
            }
        }
        
    }
}
