//
//  Currency.swift
//  TestApp
//
//  Created by Dipen on 3/6/20.
//  Copyright © 2020 Dipen. All rights reserved.
//

import Foundation
import RealmSwift

class CurrencyObj:Object{
    @objc dynamic var code = ""
    @objc dynamic var name = ""
    @objc dynamic var symbol = ""

}
