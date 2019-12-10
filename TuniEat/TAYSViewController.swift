//
//  CentrumViewController.swift
//  TuniEat
//
//  Created by Valtteri Vuori on 10.12.2019.
//  Copyright © 2019 Valtteri Vuori. All rights reserved.
//

import UIKit

class TAYSViewController : UIViewController{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        
        label.center = view.center
        label.textAlignment = .center
        label.text = "TAYS"
        label.textColor = UIColor.white
        self.view.addSubview(label)
        
        view.backgroundColor = UIColor.black
    }
}
