//
//  webserviceManager.swift
//  TTNFleet
//
//  Created by Dipen on 5/4/18.
//  Copyright © 2018 Shyama Nirmal. All rights reserved.
//

import UIKit
import Alamofire

extension Request {
    public func debugLog() -> Self {
        #if DEBUG
        debugPrint(self)
        #endif
        return self
    }
}



struct webserviceManager {

       static let shared = webserviceManager()
    
    // MARK: - URL
    
    // MARK: - Services
    func requestFetchCountry(with name: String, completion: @escaping (ModelSearchCountry?, Error?) -> ()) {
        let url = SEARCH_COUNTRY + name
        
        Alamofire.request(url).responseModelSearchCountry { response in
            if let error = response.error {
                completion(nil, error)
                return
            }
            if let photo = response.result.value {
                completion(photo, nil)
                return
            }
        }
    }

    
    
  
}
