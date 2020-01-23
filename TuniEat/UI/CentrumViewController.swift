//
//  CentrumViewController.swift
//  TuniEat
//
//  Created by Valtteri Vuori on 10.12.2019.
//  Copyright © 2019 Valtteri Vuori. All rights reserved.
//

import UIKit

class CentrumViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, MenuDownloaderDelegate{
    
    func didFinishMinervaDownload(sender: MenuDownloader) {
        minervaMeals = menuDownloader.minervaMenu
        reloadData()
    }
    
    func didFinishLinnaDownload(sender: MenuDownloader) {
        linnaMeals = menuDownloader.linnaMenu
        reloadData()
    }
    
    var tableView = UITableView()
    
    let menuDownloader = MenuDownloader()
    
    var linnaMeals: [Meal] = []
    var minervaMeals: [Meal] = []
    
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuCell
        
        if(indexPath.section == 0){
            cell.setupValues(viewModel: linnaMeals[indexPath.row])
        }
        if(indexPath.section == 1){
            cell.setupValues(viewModel: minervaMeals[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Linna"
        case 1:
            return "Minerva"
        default:
            return "Unknown"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return linnaMeals.count
        case 1:
            return minervaMeals.count
        default:
            return 0
        }

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var count = 0
        if (!linnaMeals.isEmpty) {
            count+=1
        }
        if (!minervaMeals.isEmpty) {
            count+=1
        }
        return count
    }
    
    func reloadData(){
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
}
