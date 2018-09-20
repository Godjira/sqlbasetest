//
//  DetailViewController.swift
//  sqltest
//
//  Created by Godjira on 9/19/18.
//  Copyright © 2018 Godjira. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var prepImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    
    var prep: Prep?
    var prepInfo: [PrepInfo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = prep?.name
        
        let imageUrl = "http://backoffice.mobimill.com/for_test/\(prep?.picture ?? "")"
        let url = URL(string: imageUrl)
        prepImageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "apriori"), options: nil, progressBlock: nil, completionHandler: nil)
        
        guard let prep = prep else { return }
        prepInfo = SQLiteManager.shared.getInfo(prep: prep)
        
    }
    
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let prepInfo = prepInfo else { return 0 }
        return prepInfo.count * 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let model = prepInfo?[indexPath.row / 2] else { return UITableViewCell() }
    
        if indexPath.row % 2 == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "Property", for: indexPath)  as? TextViewCell else {
                return UITableViewCell()
            }
            cell.descriptionLabel?.text = model.name
            cell.backgroundColor = UIColor.yellow
            return cell
        } else {
            guard let textViewCell = tableView.dequeueReusableCell(withIdentifier: "TextViewCell", for: indexPath) as? TextViewCell else {
                return UITableViewCell()
            }
            textViewCell.descriptionLabel.attributedText = model.text?.htmlToAttributedString
            return textViewCell
        }
        
    }
}
