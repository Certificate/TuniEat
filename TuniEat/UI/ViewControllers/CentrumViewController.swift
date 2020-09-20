//
//  CentrumViewController.swift
//  TuniEat
//
//  Created by Valtteri Vuori on 10.12.2019.
//  Copyright © 2019 Valtteri Vuori. All rights reserved.
//

import UIKit

class CentrumViewController : UIViewController, UITableViewDelegate, UITableViewDataSource, MenuDownloaderDelegate{

    // Delegate functions
    func didFinishMinervaDownload(sender: MenuDownloader) {
        minervaMeals = menuDownloader.minervaMenu
        reloadData()
    }
    
    func didFinishLinnaDownload(sender: MenuDownloader) {
        linnaMeals = menuDownloader.linnaMenu
        reloadData()
    }
    
    func didFinishJuvenesDownload(sender: MenuDownloader) {
        juvenesMeals = menuDownloader.juvenesMenu
        reloadData()
    }
    
    private let refreshControl = UIRefreshControl()

    var tableView = UITableView()
    let menuDownloader = MenuDownloader()
    
    // Menus
    var linnaMeals: [Meal] = []
    var minervaMeals: [Meal] = []
    var juvenesMeals: [Meal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuDownloader.delegate = self
        
        setupTableView()
        setupRefreshControl()

        menuDownloader.DownloadMenus()
    }
    
    private func setupTableView(){
        tableView = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        
        tableView.register(MenuCell.self, forCellReuseIdentifier: "menuCell")
        view.addSubview(tableView)
    }
    
    private func setupRefreshControl(){
        // Add Refresh Control to Table View.
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(downloadMenus(_:)), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Päivitän ruokalistaa...", attributes:[ NSAttributedString.Key.foregroundColor: UIColor.black ])
    }
    
    @objc private func downloadMenus(_ sender: Any) {
        menuDownloader.DownloadMenus()
        
        self.refreshControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuCell
        
        if(indexPath.section == 0){
            cell.setupValues(viewModel: linnaMeals[indexPath.row])
        }
        
        if(indexPath.section == 1){
            cell.setupValues(viewModel: minervaMeals[indexPath.row])
        }
        
        if(indexPath.section == 2){
            cell.setupValues(viewModel: juvenesMeals[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Linna"
        case 1:
            return "Minerva"
        case 2:
            return "Yliopiston Ravintola"
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
        case 2:
            return juvenesMeals.count
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
        if (!juvenesMeals.isEmpty) {
            count+=1
        }
        print("Count is: \(count)")
        return count
    }
    
    func reloadData(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
