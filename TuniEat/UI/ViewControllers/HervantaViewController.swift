//
//  CentrumViewController.swift
//  TuniEat
//
//  Created by Valtteri Vuori on 10.12.2019.
//  Copyright © 2019 Valtteri Vuori. All rights reserved.
//

import UIKit

class HervantaViewController : BaseTableViewController, HervantaMenuDownloaderDelegate{
    func didFinishHertsiDownload(sender: HervantaMenuDownloader) {
        hertsiMeals = menuDownloader.hertsiMenu
        super.reloadData()
    }
    
    func didFinishReaktoriDownload(sender: HervantaMenuDownloader) {
        reaktoriMeals = menuDownloader.reaktoriMenu
        super.reloadData()
    }
    
    func didFinishNewtonDownload(sender: HervantaMenuDownloader) {
        newtonMeals = menuDownloader.newtonMenu
        super.reloadData()
    }
    
    let menuDownloader = HervantaMenuDownloader()
    
    // Menus
    var hertsiMeals: [Meal] = []
    var reaktoriMeals: [Meal] = []
    var newtonMeals: [Meal] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuDownloader.delegate = self
        refresher.addTarget(self, action: #selector(downloadMenus(_:)), for: .valueChanged)

        menuDownloader.DownloadHervantaMenus()
    }
    
    @objc private func downloadMenus(_ sender: Any) {
        menuDownloader.DownloadHervantaMenus()
        
        self.refresher.endRefreshing()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuCell
        
        if(indexPath.section == 0){
            cell.setupValues(viewModel: hertsiMeals[indexPath.row])
        }
        
        if(indexPath.section == 1){
            cell.setupValues(viewModel: reaktoriMeals[indexPath.row])
        }
        
        if(indexPath.section == 2){
            cell.setupValues(viewModel: newtonMeals[indexPath.row])
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Hertsi"
        case 1:
            return "Reaktori"
        case 2:
            return "Newton"
        default:
            return "Unknown"
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch section {
        case 0:
            return hertsiMeals.count
        case 1:
            return reaktoriMeals.count
        case 2:
            return newtonMeals.count
        default:
            return 0
        }

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        var count = 0
        
        if (!hertsiMeals.isEmpty) {
            count+=1
        }
        if (!reaktoriMeals.isEmpty) {
            count+=1
        }
        if (!newtonMeals.isEmpty) {
            count+=1
        }
        return count
    }
}
