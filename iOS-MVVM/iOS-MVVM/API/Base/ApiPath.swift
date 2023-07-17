//
//  ApiPath.swift
//  iOS-MVVM
//
//  Created by Dat Nguyen on 20/4/21.
//  Copyright © 2021 PanU. All rights reserved.
//

import UIKit

/// All Api path
enum ApiPath: String {
    var path: String {
        return self.rawValue
    }
    
    //API Path
    case login = "/api/login"
}
