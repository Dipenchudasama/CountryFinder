//
//  CountryViewModel.swift
//  TestApp
//
//  Created by Dipen on 3/5/20.
//  Copyright © 2020 Dipen. All rights reserved.
//

import Foundation


//
//  PhotoViewModel.swift
//  MVVM Alamofire
//
//  Created by Arifin Firdaus on 7/12/18.
//  Copyright © 2018 Arifin Firdaus. All rights reserved.
//

import Foundation

class CountryViewModel {
    
    // MARK: - Properties
    var country: ModelSearchCountry? {
        didSet {
            self.didFinishFetch?()
        }
    }
    var error: Error? {
        didSet { self.showAlertClosure?() }
    }
    var isLoading: Bool = false {
        didSet { self.updateLoadingStatus?() }
    }
    
    var titleString: String?
    var albumIdString: String?
    var photoUrl: URL?
    
    private var dataService: webserviceManager?
    
    // MARK: - Closures for callback, since we are not using the ViewModel to the View.
    var showAlertClosure: (() -> ())?
    var updateLoadingStatus: (() -> ())?
    var didFinishFetch: (() -> ())?
    
    // MARK: - Constructor
    init(dataService: webserviceManager) {
        self.dataService = dataService
    }
    
    // MARK: - Network call
    func fetchCountry(withName name: String) {
        self.dataService?.requestFetchCountry(with: name, completion: { (country, error) in
            if let error = error {
                self.error = error
                self.isLoading = false
                return
            }
            self.error = nil
            self.isLoading = false
            self.country = country
        })
    }
}
