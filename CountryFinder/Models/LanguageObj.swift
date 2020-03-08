//
//  Language.swift
//  TestApp
//
//  Created by Dipen on 3/6/20.
//  Copyright © 2020 Dipen. All rights reserved.
//

import Foundation
import RealmSwift

class LanguageObj:Object{
    
    @objc dynamic var iso6391 = ""
    @objc dynamic var iso6392 = ""
    @objc dynamic var name = ""
    @objc dynamic var nativeName = ""
}

