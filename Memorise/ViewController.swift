//
//  ViewController.swift
//  Memorise
//
//  Created by Oliver Lippold on 01/02/2020.
//  Copyright © 2020 Oliver Lippold. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    let dataSource = MemoryDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = dataSource
        //loadItems()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "MemoryViewController") as? MemoryViewController else {
            fatalError("Unable to instantiate memory view controller.")
        }
        
        let item = dataSource.item(at: indexPath.row)
        vc.memoryItem = item
        
        navigationController?.pushViewController(vc, animated: true)
    }
    


}

