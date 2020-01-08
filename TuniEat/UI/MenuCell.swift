//
//  MenuCell.swift
//  TuniEat
//
//  Created by Valtteri Vuori on 20.12.2019.
//  Copyright © 2019 Valtteri Vuori. All rights reserved.
//

import UIKit

class MenuCell : UITableViewCell{
    
    var foodName = UILabel()
    var foodPrice = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        foodName = UILabel(frame: CGRect(x: 15, y: 0, width: 200, height: 30))
        foodPrice = UILabel(frame: CGRect(x: 15, y: 25, width: 200, height: 30))
        
        self.contentView.addSubview(foodName)
        self.contentView.addSubview(foodPrice)
    }
    
    func setupValues(viewModel: Meal){
        foodName.text = viewModel.name
        foodPrice.text = viewModel.price
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}
