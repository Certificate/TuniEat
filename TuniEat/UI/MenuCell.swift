//
//  MenuCell.swift
//  TuniEat
//
//  Created by Valtteri Vuori on 20.12.2019.
//  Copyright © 2019 Valtteri Vuori. All rights reserved.
//

import PureLayout
import UIKit

class MenuCell : UITableViewCell{
    
    let foodName:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let foodPrice:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        containerView.addSubview(foodName)
        containerView.addSubview(foodPrice)
        self.contentView.addSubview(containerView)
        
        setNeedsUpdateConstraints()
    }
    
    func setupValues(viewModel: Meal){
        foodName.text = viewModel.name
        foodPrice.text = viewModel.price
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        containerView.autoPinEdge(toSuperviewEdge: ALEdge.left)
        containerView.autoPinEdge(toSuperviewEdge: ALEdge.top)
        containerView.autoPinEdge(toSuperviewEdge: ALEdge.right)
        containerView.autoPinEdge(toSuperviewEdge: ALEdge.bottom)
        
        foodName.autoPinEdge(ALEdge.left, to: ALEdge.left, of: containerView, withOffset: 20)
        foodName.autoPinEdge(ALEdge.top, to:ALEdge.top, of: containerView, withOffset: 0)
        foodName.autoPinEdge(ALEdge.right, to:ALEdge.right, of: containerView, withOffset: 0)
        foodName.autoPinEdge(ALEdge.bottom, to: ALEdge.top, of: foodPrice)
        
        foodPrice.autoPinEdge(ALEdge.left, to: ALEdge.left, of: containerView, withOffset: 20)
        foodPrice.autoPinEdge(ALEdge.bottom, to:ALEdge.bottom, of: containerView, withOffset: 0)
        foodPrice.autoPinEdge(ALEdge.top, to: ALEdge.bottom, of: foodName, withOffset: 0)

    }
}
