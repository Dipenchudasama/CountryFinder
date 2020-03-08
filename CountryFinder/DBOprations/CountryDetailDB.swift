//
//  CountryDetailDB.swift
//  TestApp
//
//  Created by DGV on 07/03/20.
//  Copyright © 2020 Dipen. All rights reserved.
//

import Foundation

private func getCurrency(modelSerachCountry:ModelSearchCountryElement?)->CurrencyObj{
       let currencyRealm = CurrencyObj()
       currencyRealm.code = modelSerachCountry?.currencies?.first?.code ?? ""
       currencyRealm.name = modelSerachCountry?.currencies?.first?.name ?? ""
       currencyRealm.symbol = modelSerachCountry?.currencies?.first?.symbol ?? ""
       return currencyRealm
   }
   
   private func getLanguage(modelSerachCountry:ModelSearchCountryElement?)->LanguageObj{
       let languageRealm = LanguageObj()
       languageRealm.iso6391 = modelSerachCountry?.languages?.first?.iso6391 ?? ""
       languageRealm.iso6392 = modelSerachCountry?.languages?.first?.iso6392 ?? ""
       languageRealm.name = modelSerachCountry?.languages?.first?.name ?? ""
       languageRealm.nativeName = modelSerachCountry?.languages?.first?.nativeName ?? ""

       return languageRealm
   }



   private func getTranslation(modelSerachCountry:ModelSearchCountryElement?)->TranslationsObj{
       let translationRealm = TranslationsObj()
       translationRealm.br = modelSerachCountry?.translations?.br ?? ""
       translationRealm.de = modelSerachCountry?.translations?.de ?? ""
       translationRealm.es = modelSerachCountry?.translations?.es ?? ""
       translationRealm.fa = modelSerachCountry?.translations?.fa ?? ""
       translationRealm.fr = modelSerachCountry?.translations?.fr ?? ""
       translationRealm.hr = modelSerachCountry?.translations?.hr ?? ""
       translationRealm.it = modelSerachCountry?.translations?.it ?? ""
       translationRealm.ja = modelSerachCountry?.translations?.ja ?? ""
       return translationRealm
   }

   private func getRegionalBloc(modelSerachCountry:ModelSearchCountryElement?)->RegionalBlocObj{
       let regionalBlocObjRealm = RegionalBlocObj()
       regionalBlocObjRealm.acronym = modelSerachCountry?.regionalBlocs?.first?.acronym ?? ""
       regionalBlocObjRealm.name = modelSerachCountry?.regionalBlocs?.first?.name ?? ""
       regionalBlocObjRealm.otherNames = modelSerachCountry?.regionalBlocs?.first?.otherNames?.first ?? ""
       regionalBlocObjRealm.otherAcronyms = ""
       return regionalBlocObjRealm
   }

 func storeDataInRealm(countryRealm:CountryRealmModel,modelSerachCountry:ModelSearchCountryElement?){
    countryRealm.name = modelSerachCountry?.name ?? ""
    countryRealm.alpha2Code = modelSerachCountry?.alpha2Code ?? ""
    countryRealm.capital = modelSerachCountry?.capital ?? ""
    countryRealm.region = modelSerachCountry?.region ?? ""
    countryRealm.subregion = modelSerachCountry?.subregion ?? ""
    countryRealm.population = modelSerachCountry?.population ?? 0
    countryRealm.demonym = modelSerachCountry?.demonym ?? ""
    countryRealm.area = modelSerachCountry?.area ?? 0
    countryRealm.gini = modelSerachCountry?.gini ?? 0.0
    countryRealm.nativeName = modelSerachCountry?.nativeName ?? ""
    countryRealm.flag = modelSerachCountry?.flag ?? ""
    countryRealm.cioc = modelSerachCountry?.cioc ?? ""
    countryRealm.timezones.append(modelSerachCountry?.timezones?.first ?? "None")
    countryRealm.currencies.append(getCurrency(modelSerachCountry: modelSerachCountry))
    countryRealm.languages.append(getLanguage(modelSerachCountry: modelSerachCountry))
    countryRealm.translations = getTranslation(modelSerachCountry: modelSerachCountry)
    countryRealm.regionalBlocs.append(getRegionalBloc(modelSerachCountry: modelSerachCountry))
    countryRealm.callingCodes.append(modelSerachCountry?.callingCodes?.first ?? "None")
    
}

func getLanguageFromRealm(resultRealm:CountryRealmModel) -> [Language]{
    var languages = [Language]()
    for result in resultRealm.languages{
        let language = Language(iso6391: result.iso6391, iso6392: result.iso6392, name: result.name, nativeName: result.nativeName)
        languages.append(language)
    }
    return languages
}


func getCurrencyFromRealm(resultRealm:CountryRealmModel) -> [Currency]{
    var currencies = [Currency]()
    for result in resultRealm.currencies{
        let currency = Currency(code: result.code, name: result.name, symbol: result.symbol)
        currencies.append(currency)
    }
    return currencies
}

func getRegionalBlocFromRealm(resultRealm:CountryRealmModel) -> [RegionalBloc]{
    var regionalBlocs = [RegionalBloc]()
    for result in resultRealm.regionalBlocs{
        let regionalBloc = RegionalBloc(acronym: result.acronym, name: result.name, otherAcronyms:[AnyCodable(result.otherAcronyms)], otherNames: [result.otherNames])
        
        regionalBlocs.append(regionalBloc)
    }
    return regionalBlocs
}

