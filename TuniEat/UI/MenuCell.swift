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
        return label
    }()
    
    let foodComponent1:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let foodComponent2:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
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
        
        containerView.addSubview(foodTitle)
        containerView.addSubview(foodPrice)
        self.contentView.addSubview(containerView)
        
        setNeedsUpdateConstraints()
    }
    
    func setupValues(viewModel: Meal){
        foodTitle.text = viewModel.title
        foodPrice.text = viewModel.price
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
        
        setupDebugColors()
        
        containerView.autoPinEdge(toSuperviewEdge: ALEdge.left, withInset: 20)
        containerView.autoPinEdge(toSuperviewEdge: ALEdge.top)
        containerView.autoPinEdge(toSuperviewEdge: ALEdge.right)
        containerView.autoPinEdge(toSuperviewEdge: ALEdge.bottom)
        //containerView.backgroundColor = UIColor.systemPink
        
        foodTitle.autoPinEdge(ALEdge.left, to: ALEdge.left, of: containerView)
        foodTitle.autoPinEdge(ALEdge.top, to:ALEdge.top, of: containerView, withOffset: 0)
        foodTitle.autoPinEdge(ALEdge.right, to:ALEdge.right, of: containerView, withOffset: 0)
        foodTitle.autoPinEdge(ALEdge.bottom, to: ALEdge.top, of: foodPrice, withOffset: 0)
        //foodName.backgroundColor = UIColor.blue
        
        foodPrice.autoPinEdge(ALEdge.left, to: ALEdge.left, of: containerView)
        foodPrice.autoPinEdge(ALEdge.bottom, to:ALEdge.bottom, of: containerView, withOffset: -5)
        foodPrice.autoPinEdge(ALEdge.top, to: ALEdge.bottom, of: foodTitle, withOffset: 0)
        //foodPrice.backgroundColor = UIColor.red

    }
}
