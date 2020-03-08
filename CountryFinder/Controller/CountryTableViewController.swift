//
//  CountryTableViewController.swift
//  TestApp
//
//  Created by Dipen on 3/5/20.
//  Copyright © 2020 Dipen. All rights reserved.
//

import UIKit
import SDWebImageSVGCoder
import RealmSwift

class CountryTableViewController: UITableViewController {
        
    private let searchController = UISearchController(searchResultsController: nil)
    private var previousRun = Date()
    private let minInterval = 0.02
    var searchResults: ModelSearchCountry?
    var strOffline:String = ""
    let viewModel = CountryViewModel(dataService: webserviceManager())

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchBar()
        self.title = "Home"
    }
    
    override func awakeFromNib(){
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
       // MARK: - UI Setup
       private func activityIndicatorStart() {
           print("start")
       }
       
       private func activityIndicatorStop() {
           print("stop")
       }


    // MARK: - Table view data source

       private func setupSearchBar() {
           searchController.searchBar.delegate = self
           searchController.hidesNavigationBarDuringPresentation = true
           searchController.searchBar.placeholder = searchPlaceHolder
           definesPresentationContext = true
           tableView.tableHeaderView = searchController.searchBar
            searchController.searchBar.accessibilityLabel = "Search-country"
       }

       override func numberOfSections(in tableView: UITableView) -> Int {
           return 1
       }

       override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(self.searchResults?.count ?? 0 > 0){
            self.tableView.backgroundView = nil
           return searchResults?.count ?? 0
        }else{
            DispatchQueue.main.async {
                ConfigureNoDataFound(tableView: self.tableView, textitem: "\(noItemsToShow)\(self.strOffline)")
            }
        }
        
        return 0
        
       }
       
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: countryCellIdentifier,
                                                    for: indexPath) as! CountryTableViewCell
           
        cell.countryName.text = searchResults?[indexPath.row].name ?? countryNameNotFound
        
        let bitmapSize = CGSize(width: 84, height: 70)
        let url =  NSURL(string: searchResults?[indexPath.row].flag ?? "")!
        
        cell.countryFlag.sd_setImage(with: url as URL, placeholderImage: nil, context: [.imageThumbnailPixelSize : bitmapSize])
        
           return cell
       }
       
       override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           let controller = getControllerFromStoryBoard(identiFier: kSeguecountryDetail) as! CountryDetailViewController
        controller.modelSerachCountry = self.searchResults?[indexPath.row]
        self.navigationController?.pushViewController(controller, animated: true)
       }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }

}

extension CountryTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let textToSearch = searchBar.text, !textToSearch.isEmpty else {
            self.searchResults?.removeAll()
            self.tableView.reloadData()
            return
        }

        if(isConnectedToNetwork()){
            self.strOffline = ""
            if Date().timeIntervalSince(previousRun) > minInterval {
                previousRun = Date()
                apiCallFetchCountry(withname: textToSearch)
            }
        }else{
            self.strOffline = "\n No Internet connection!"
            let resultPredicate = NSPredicate(format: "SELF.name contains[c] %@", textToSearch)
            let realm =  try! Realm()

            let country = realm.objects(CountryRealmModel.self).filter(resultPredicate)
            if(self.searchResults != nil){
                self.searchResults?.removeAll()
            }else{
                 self.searchResults = ModelSearchCountry()
            }
            for result in country{
                let modelElement = self.countryElementFromDB(result: result)
                self.searchResults?.append(modelElement)
            }
            self.tableView.reloadData()

        }
    }
    
    private func countryElementFromDB(result:CountryRealmModel) -> ModelSearchCountryElement{
        let modelelement = ModelSearchCountryElement(name: result.name, topLevelDomain: Array(result.topLevelDomain), alpha2Code: result.alpha2Code, alpha3Code: result.alpha3Code, callingCodes: [(result.callingCodes.first ?? "None")], capital: result.capital, altSpellings: Array(result.altSpellings), region: result.region, subregion: result.subregion, population: result.population, latlng: Array(result.latlng), demonym: result.demonym, area: result.area, gini: result.gini, timezones: [(result.timezones.first ?? "None")], borders: Array(result.borders), nativeName: result.nativeName, numericCode: result.numericCode, currencies: getCurrencyFromRealm(resultRealm: result), languages: getLanguageFromRealm(resultRealm: result), translations: nil, flag: result.flag, regionalBlocs: getRegionalBlocFromRealm(resultRealm: result), cioc: result.cioc)
        
        return modelelement
    }
    
    
     func apiCallFetchCountry(withname name: String) {
             viewModel.fetchCountry(withName: name)
             
             viewModel.updateLoadingStatus = {
                 let _ = self.viewModel.isLoading ? self.activityIndicatorStart() : self.activityIndicatorStop()
             }
             
             viewModel.showAlertClosure = {
                 if let error = self.viewModel.error {
                     print(error.localizedDescription)
                 }
             }
             
             viewModel.didFinishFetch = {
                self.searchResults?.removeAll()
              self.searchResults = self.viewModel.country
              self.tableView.reloadData()
             }
         }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if(self.searchResults != nil){
            self.searchResults?.removeAll()
            self.tableView.reloadData()
        }
        
    }

}

