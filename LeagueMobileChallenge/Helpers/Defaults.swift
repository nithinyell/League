//
//  Defaults.swift
//  LeagueMobileChallenge
//
//  Created by Nithin 3 on 11/03/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import Foundation

struct Defaults {
    static var apiKey: String? {
        get { return UserDefaults.standard.string(forKey: Constants.APIKEY) }
        set { UserDefaults.standard.set(newValue, forKey: Constants.APIKEY) }
    }
}
