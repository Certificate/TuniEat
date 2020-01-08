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
    
    var numberOfItems = 5
    
    var meals: [Meal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 60
        
        tableView.register(MenuCell.self, forCellReuseIdentifier: "menuCell")
        view.addSubview(tableView)
        
        let menudl = MenuDownloader()
        menudl.DownloadMenus()
    }
    
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuCell
        cell.setupValues(viewModel: Meal("Example Meal \(indexPath)", "2.60€"))
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func reloadNumber(){
        self.tableView.reloadData()
    }
}
