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
        //label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let foodPrice:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        //label.textColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        //label.backgroundColor =  #colorLiteral(red: 0.2431372549, green: 0.7647058824, blue: 0.8392156863, alpha: 1)
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let containerView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true // this will make sure its children do not go out of the boundary
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
        
        foodName.autoPinEdge(toSuperviewEdge: ALEdge.left, withInset: 20)
        foodName.autoPinEdge(toSuperviewEdge: ALEdge.top)
        foodName.autoPinEdge(toSuperviewEdge: ALEdge.right)
        foodName.autoPinEdge(ALEdge.bottom, to: ALEdge.top, of: foodPrice)
        
        foodPrice.autoPinEdge(toSuperviewEdge: ALEdge.left, withInset: 20)
        foodPrice.autoPinEdge(toSuperviewEdge: ALEdge.bottom, withInset: 6)
        foodPrice.autoPinEdge(ALEdge.top, to: ALEdge.bottom, of: foodName, withOffset: 7)
        
        
    }
}
