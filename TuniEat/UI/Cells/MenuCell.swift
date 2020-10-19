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
    
    let foodTitle:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
    }()
    
    let foodComponents:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 5
        return label
    }()
    
    let foodPrice:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor(named: "MainColor")
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
        
        containerView.addSubview(foodTitle)
        containerView.addSubview(foodPrice)
        containerView.addSubview(foodComponents)
        self.contentView.addSubview(containerView)
        
        setNeedsUpdateConstraints()
    }
    
    func setupValues(viewModel: Meal){
        foodPrice.text = viewModel.price
        
        var components = ""
        for (index, component) in viewModel.components.enumerated() {
            
            // Setup title
            if index == viewModel.components.startIndex{
                foodTitle.text = component
                continue
            }
            
            // Setup potential components
            components = components + "- " + component
            
            if index != viewModel.components.endIndex - 1 {
                components = components + "\n"
            }
        }
        
        foodComponents.text = components
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupDebugColors(){
        foodPrice.backgroundColor = UIColor.yellow
        foodTitle.backgroundColor = UIColor.green
        foodComponents.backgroundColor = UIColor.systemPink
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        //setupDebugColors()
        
        containerView.autoPinEdge(toSuperviewEdge: ALEdge.left, withInset: 20)
        containerView.autoPinEdge(toSuperviewEdge: ALEdge.top)
        containerView.autoPinEdge(toSuperviewEdge: ALEdge.right)
        containerView.autoPinEdge(toSuperviewEdge: ALEdge.bottom)
        
        foodTitle.autoPinEdge(ALEdge.left, to: ALEdge.left, of: containerView)
        foodTitle.autoPinEdge(ALEdge.top, to:ALEdge.top, of: containerView, withOffset: 3)
        foodTitle.autoPinEdge(ALEdge.right, to:ALEdge.right, of: containerView)
        foodTitle.autoPinEdge(ALEdge.bottom, to: ALEdge.top, of: foodComponents)
        
        foodComponents.autoPinEdge(ALEdge.left, to: ALEdge.left, of: containerView)
        
        foodPrice.autoPinEdge(ALEdge.left, to: ALEdge.left, of: containerView)
        foodPrice.autoPinEdge(ALEdge.top, to: ALEdge.bottom, of: foodComponents, withOffset: 3)
        foodPrice.autoPinEdge(ALEdge.bottom, to:ALEdge.bottom, of: containerView, withOffset: -5)

    }
}
