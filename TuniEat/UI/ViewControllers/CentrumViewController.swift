//
//  CentrumViewController.swift
//  TuniEat
//
//  Created by Valtteri Vuori on 10.12.2019.
//  Copyright © 2019 Valtteri Vuori. All rights reserved.
//

import UIKit

class CentrumViewController : BaseTableViewController, CityCentreMenuDownloaderDelegate{

    // Delegate functions
    func didFinishMinervaDownload(sender: CityCentreMenuDownloader) {
        minervaMeals = menuDownloader.minervaMenu
        super.reloadData()
    }
    
    func didFinishLinnaDownload(sender: CityCentreMenuDownloader) {
        linnaMeals = menuDownloader.linnaMenu
        super.reloadData()
    }
    
    func didFinishJuvenesDownload(sender: CityCentreMenuDownloader) {
        juvenesMeals = menuDownloader.juvenesMenu
        super.reloadData()
    }
    
    let menuDownloader = CityCentreMenuDownloader()
    
    // Menus
    var linnaMeals: [Meal] = []
    var minervaMeals: [Meal] = []
    var juvenesMeals: [Meal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuDownloader.delegate = self
        refresher.addTarget(self, action: #selector(downloadMenus(_:)), for: .valueChanged)

        menuDownloader.DownloadCityCentreMenus()
    }
    
    @objc private func downloadMenus(_ sender: Any) {
        menuDownloader.DownloadCityCentreMenus()
        
        self.refresher.endRefreshing()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
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
        return count
    }
}
