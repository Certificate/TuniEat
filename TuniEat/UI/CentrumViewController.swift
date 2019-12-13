//
//  CentrumViewController.swift
//  TuniEat
//
//  Created by Valtteri Vuori on 10.12.2019.
//  Copyright © 2019 Valtteri Vuori. All rights reserved.
//

import UIKit

class CentrumViewController : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var tableView = UITableView()
    
    var numberOfItems = 0
    
    var meals: [Meal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = UIColor.white
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "menuCell")
        view.addSubview(tableView)
        
        let menudl = MenuDownloader()
        menudl.DownloadMenus()
    }
    
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath)
        cell.textLabel?.text =  "asd"
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func reloadNumber(){
        self.tableView.reloadData()
    }
}
