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
        label.numberOfLines = 4
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
        containerView.addSubview(foodComponent1)
        containerView.addSubview(foodComponent2)
        containerView.addSubview(foodComponent3)
        self.contentView.addSubview(containerView)
        
        setNeedsUpdateConstraints()
    }
    
    func setupValues(viewModel: Meal){
        foodTitle.text = viewModel.title
        foodPrice.text = viewModel.price
        
        if !viewModel.component1.isEmpty  {
            foodComponent1.text = viewModel.component1
        }
        if !viewModel.component2.isEmpty  {
            foodComponent2.text = viewModel.component2
        }
        if !viewModel.component3.isEmpty  {
            foodComponent3.text = viewModel.component2
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupDebugColors(){
        foodPrice.backgroundColor = UIColor.red
        foodTitle.backgroundColor = UIColor.green
        foodComponent1.backgroundColor = UIColor.systemPink
        foodComponent2.backgroundColor = UIColor.yellow
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        //setupDebugColors()
        
        containerView.autoPinEdge(toSuperviewEdge: ALEdge.left, withInset: 20)
        containerView.autoPinEdge(toSuperviewEdge: ALEdge.top)
        containerView.autoPinEdge(toSuperviewEdge: ALEdge.right)
        containerView.autoPinEdge(toSuperviewEdge: ALEdge.bottom)
        
        foodTitle.autoPinEdge(ALEdge.left, to: ALEdge.left, of: containerView)
        foodTitle.autoPinEdge(ALEdge.top, to:ALEdge.top, of: containerView, withOffset: 0)
        foodTitle.autoPinEdge(ALEdge.right, to:ALEdge.right, of: containerView, withOffset: 0)
        foodTitle.autoPinEdge(ALEdge.bottom, to: ALEdge.top, of: foodComponent1, withOffset: 0)
        
        foodPrice.autoPinEdge(ALEdge.left, to: ALEdge.left, of: containerView)
        foodPrice.autoPinEdge(ALEdge.bottom, to:ALEdge.bottom, of: containerView, withOffset: -5)
        foodPrice.autoPinEdge(ALEdge.top, to: ALEdge.bottom, of: foodComponent3, withOffset: 0)
        
        foodComponent1.autoPinEdge(ALEdge.left, to: ALEdge.left, of: containerView)
        foodComponent1.autoPinEdge(ALEdge.bottom, to:ALEdge.top, of: foodComponent2)
        foodComponent1.autoPinEdge(ALEdge.top, to:ALEdge.bottom, of: foodTitle)
        
        foodComponent2.autoPinEdge(ALEdge.left, to: ALEdge.left, of: containerView)
        foodComponent2.autoPinEdge(ALEdge.bottom, to:ALEdge.top, of: foodComponent3)
        foodComponent2.autoPinEdge(ALEdge.top, to:ALEdge.bottom, of: foodComponent1)
        
        foodComponent3.autoPinEdge(ALEdge.left, to: ALEdge.left, of: containerView)
        foodComponent3.autoPinEdge(ALEdge.bottom, to:ALEdge.top, of: foodPrice)
        foodComponent3.autoPinEdge(ALEdge.top, to:ALEdge.bottom, of: foodComponent2)

    }
}
