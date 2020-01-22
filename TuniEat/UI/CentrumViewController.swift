//
//  CentrumViewController.swift
//  TuniEat
//
//  Created by Valtteri Vuori on 10.12.2019.
//  Copyright © 2019 Valtteri Vuori. All rights reserved.
//

import UIKit

class CentrumViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, MenuDownloaderDelegate{
    
    func didFinishLinnaDownload(sender: MenuDownloader) {
        linnaMeals = menuDownloader.linnaMenu
        reloadData()
    }
    
    var tableView = UITableView()
    
    let menuDownloader = MenuDownloader()
    
    var linnaMeals: [Meal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuDownloader.delegate = self
        
        tableView = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 60
        tableView.allowsSelection = false
        
        tableView.register(MenuCell.self, forCellReuseIdentifier: "menuCell")
        view.addSubview(tableView)
    
        menuDownloader.DownloadMenus()
    }
    
    func calculateNumberofItems() -> Int {
        return linnaMeals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuCell
        cell.setupValues(viewModel: linnaMeals[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return calculateNumberofItems()
    }
    
    func reloadData(){
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
}
