//
//  ViewController.swift
//  sqltest
//
//  Created by Godjira on 9/18/18.
//  Copyright © 2018 Godjira. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var preps: [Prep]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        preps = SQLiteManager.shared.getPreps()
        title = "Препараты"
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return preps?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrepTableViewCell", for: indexPath) as! PrepTableViewCell
        guard let model = preps?[indexPath.row] else { return cell }
        
        cell.nameLabel.text = model.name
        cell.aboutLabel.attributedText = model.about
        
        let imageUrl = "http://backoffice.mobimill.com/for_test/\(model.picture ?? "")"
        let url = URL(string: imageUrl)
        cell.prepImage.kf.setImage(with: url, placeholder: UIImage(named: "apriori"))

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = DetailViewController.instance()
        detailVC.prep = preps![indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

