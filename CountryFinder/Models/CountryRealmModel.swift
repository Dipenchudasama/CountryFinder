//
//  CountryRealmModel.swift
//  TestApp
//
//  Created by Dipen on 3/6/20.
//  Copyright © 2020 Dipen. All rights reserved.
//

import Foundation
import RealmSwift


class CountryRealmModel:Object{
    @objc dynamic var name = ""
    var topLevelDomain = List<String>()
    @objc dynamic var alpha2Code = ""
    @objc dynamic var alpha3Code = ""
    var callingCodes = List<String>()
    @objc dynamic var capital = ""
    var altSpellings = List<String>()
    @objc dynamic var region = ""
    @objc dynamic var subregion = ""
    @objc dynamic var population = 0
    var latlng = List<Double>()
    @objc dynamic var demonym = ""
    @objc dynamic var area = 0
    @objc dynamic var gini = 0.0
    var timezones  = List<String>()
    var borders = List<String>()
    @objc dynamic var nativeName =  ""
    @objc dynamic var numericCode = ""
    var currencies = List<CurrencyObj>()
    var languages =  List<LanguageObj>()
    @objc dynamic var translations: TranslationsObj?
    @objc dynamic var flag = ""
    var regionalBlocs = List<RegionalBlocObj>()
    @objc dynamic var cioc = ""
    
    override static func primaryKey() -> String? {
       return "name"
    }

}
