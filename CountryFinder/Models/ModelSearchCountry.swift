//
//  ModelSearchCountry.swift
//  TestApp
//
//  Created by Dipen on 3/5/20.
//  Copyright © 2020 Dipen. All rights reserved.
//

import Foundation
import Alamofire

// MARK: - ModelSearchCountryElement
struct ModelSearchCountryElement: Codable {
    let name: String?
    let topLevelDomain: [String]?
    let alpha2Code, alpha3Code: String?
    let callingCodes: [String]?
    let capital: String?
    let altSpellings: [String]?
    let region, subregion: String?
    let population: Int?
    let latlng: [Double]?
    let demonym: String?
    let area: Int?
    let gini: Double?
    let timezones, borders: [String]?
    let nativeName, numericCode: String?
    let currencies: [Currency]?
    let languages: [Language]?
    let translations: Translations?
    let flag: String?
    let regionalBlocs: [RegionalBloc]?
    let cioc: String?
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseCurrency { response in
//     if let currency = response.result.value {
//       ...
//     }
//   }

// MARK: - Currency
struct Currency: Codable {
    let code, name, symbol: String?
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseLanguage { response in
//     if let language = response.result.value {
//       ...
//     }
//   }

// MARK: - Language
struct Language: Codable {
    let iso6391, iso6392, name, nativeName: String?

    enum CodingKeys: String, CodingKey {
        case iso6391 = "iso639_1"
        case iso6392 = "iso639_2"
        case name, nativeName
    }
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseRegionalBloc { response in
//     if let regionalBloc = response.result.value {
//       ...
//     }
//   }

// MARK: - RegionalBloc
struct RegionalBloc: Codable {
    let acronym, name: String?
    let otherAcronyms: [AnyCodable]?
    let otherNames: [String]?
}

//
// To parse values from Alamofire responses:
//
//   Alamofire.request(url).responseTranslations { response in
//     if let translations = response.result.value {
//       ...
//     }
//   }

// MARK: - Translations
struct Translations: Codable {
    let de, es, fr, ja: String?
    let it, br, pt, nl: String?
    let hr, fa: String?
}

typealias ModelSearchCountry = [ModelSearchCountryElement]

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - Alamofire response handlers

extension DataRequest {
    fileprivate func decodableResponseSerializer<T: Decodable>() -> DataResponseSerializer<T> {
        return DataResponseSerializer { _, response, data, error in
            guard error == nil else { return .failure(error!) }

            guard let data = data else {
                return .failure(AFError.responseSerializationFailed(reason: .inputDataNil))
            }

            return Result { try newJSONDecoder().decode(T.self, from: data) }
        }
    }

    @discardableResult
    fileprivate func responseDecodable<T: Decodable>(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<T>) -> Void) -> Self {
        return response(queue: queue, responseSerializer: decodableResponseSerializer(), completionHandler: completionHandler)
    }

    @discardableResult
    func responseModelSearchCountry(queue: DispatchQueue? = nil, completionHandler: @escaping (DataResponse<ModelSearchCountry>) -> Void) -> Self {
        return responseDecodable(queue: queue, completionHandler: completionHandler)
    }
}


