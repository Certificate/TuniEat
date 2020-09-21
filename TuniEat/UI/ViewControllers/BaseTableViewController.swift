//
//  BaseTableViewController.swift
//  TuniEat
//
//  Created by Valtteri Vuori on 20.9.2020.
//  Copyright © 2020 Valtteri Vuori. All rights reserved.
//

import UIKit

class BaseTableViewController : UITableViewController{
    
    let refresher = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsSelection = false
        tableView.register(MenuCell.self, forCellReuseIdentifier: "menuCell")
        
        // Add Refresh Control to thenTable View.
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refresher
        } else {
            tableView.addSubview(refresher)
        }
        
        refresher.attributedTitle = NSAttributedString(string: "Päivitän ruokalistaa...", attributes:[ NSAttributedString.Key.foregroundColor: UIColor(named: "RefreshControlColor") ?? UIColor.lightGray ])
    }
    
    func reloadData(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

