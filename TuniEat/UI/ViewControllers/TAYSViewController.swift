//
//  CentrumViewController.swift
//  TuniEat
//
//  Created by Valtteri Vuori on 10.12.2019.
//  Copyright © 2019 Valtteri Vuori. All rights reserved.
//


import UIKit

class TAYSViewController : BaseTableViewController, TAYSMenuDownloaderDelegate{
    
    func didFinishArvoDownload(sender: TAYSMenuDownloader) {
        arvoMeals = menuDownloader.arvoMenu
        super.reloadData()
    }
    
    func didFinishFinnMediDownload(sender: TAYSMenuDownloader) {
        finnMediMeals = menuDownloader.finnMediMenu
        super.reloadData()
    }
    

    let menuDownloader = TAYSMenuDownloader()
    
    // Menus
    var arvoMeals: [Meal] = []
    var finnMediMeals: [Meal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuDownloader.delegate = self
        refresher.addTarget(self, action: #selector(downloadMenus(_:)), for: .valueChanged)

        menuDownloader.DownloadTAYSMenus()
    }
    
    @objc private func downloadMenus(_ sender: Any) {
        menuDownloader.DownloadTAYSMenus()
        
        self.refresher.endRefreshing()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuCell
        
        if(indexPath.section == 0){
            cell.setupValues(viewModel: arvoMeals[indexPath.row])
        }
        
        if(indexPath.section == 1){
            cell.setupValues(viewModel: finnMediMeals[indexPath.row])
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Arvo"
        case 1:
            return "Finn-Medi"
        default:
            return "Unknown"
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch section {
        case 0:
            return arvoMeals.count
        case 1:
            return finnMediMeals.count
        default:
            return 0
        }

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        var count = 0
        
        if (!arvoMeals.isEmpty) {
            count+=1
        }
        if (!finnMediMeals.isEmpty) {
            count+=1
        }
        return count
    }
}
