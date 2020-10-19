//
//  StringExtensions.swift
//  TuniEat
//
//  Created by Valtteri Vuori on 19.10.2020.
//  Copyright © 2020 Valtteri Vuori. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
