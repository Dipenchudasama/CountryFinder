//
//  CountryDetailViewController.swift
//  TestApp
//
//  Created by Dipen on 3/6/20.
//  Copyright © 2020 Dipen. All rights reserved.
//

import UIKit
import RealmSwift

enum eCountryDetail:String {
    case callingCode = "Calling Code"
    case region = "Region"
    case subRegion = "Sub Region"
    case timeZone = "Time Zone"
    case currencies = "Currencies"
    case languages = "Languages"
}

class CountryDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var tableView:UITableView!
    @IBOutlet weak var imgFlag:UIImageView!
    @IBOutlet weak var lblCountryName:UILabel!
    @IBOutlet weak var lblCountryCapital:UILabel!

    
    let arrayTitles = ["Calling Code","Region","Sub Region","Time Zone","Currencies","Languages"]

    var modelSerachCountry:ModelSearchCountryElement? = nil
    override func viewDidLoad() {
        super.viewDidLoad()

        if let imageURL = modelSerachCountry?.flag{
            let bitmapSize = CGSize(width: 200, height: 200)
            let url =  NSURL(string: imageURL)!
            self.imgFlag.sd_setImage(with: url as URL, placeholderImage: nil, context: [.imageThumbnailPixelSize : bitmapSize])
        }
        
        self.lblCountryName.text = modelSerachCountry?.name ?? countryNameNotFound
        self.lblCountryCapital.text = modelSerachCountry?.capital ?? "None"
        self.title = self.lblCountryName.text
        
        if(isConnectedToNetwork()){
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveTapped(sender:)))
        }
    }

    override func awakeFromNib(){
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    
    @objc func saveTapped(sender:UIButton){
        let realm =  try! Realm()

        try! realm.write{
            let countryRealm = CountryRealmModel()
            storeDataInRealm(countryRealm: countryRealm, modelSerachCountry: modelSerachCountry)
            realm.add(countryRealm, update: .modified)
            
            showAlertWithMsg(viewController: self, msg: countryAddedMsg, completionHandler: { (success) -> Void in
                if success {
                    DispatchQueue.main.async{ self.navigationController?.popToRootViewController(animated: true)
                    }
                }
            })
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayTitles.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
           let cell = tableView.dequeueReusableCell(withIdentifier: countryDetailCellIdentifier, for: indexPath) as! CountryDetailTableViewCell
        
        switch (eCountryDetail)(rawValue: self.arrayTitles[indexPath.row]) {
        case .callingCode:
            cell.titleLable.text = self.arrayTitles[indexPath.row]
            cell.descriptionLable.text = self.modelSerachCountry?.callingCodes?.first ?? ""
        case .currencies:
            cell.titleLable.text = self.arrayTitles[indexPath.row]
            cell.descriptionLable.text = self.modelSerachCountry?.currencies?.first?.code ?? ""
        case .languages:
            cell.titleLable.text = self.arrayTitles[indexPath.row]
            cell.descriptionLable.text = self.modelSerachCountry?.languages?.first?.name ?? ""
        case .region:
            cell.titleLable.text = self.arrayTitles[indexPath.row]
            cell.descriptionLable.text = self.modelSerachCountry?.region ?? ""
        case .subRegion:
            cell.titleLable.text = self.arrayTitles[indexPath.row]
            cell.descriptionLable.text = self.modelSerachCountry?.subregion ?? ""
        case .timeZone:
            cell.titleLable.text = self.arrayTitles[indexPath.row]
            cell.descriptionLable.text = self.modelSerachCountry?.timezones?.first ?? ""
        default:
            cell.titleLable.text = ""
            cell.descriptionLable.text = ""
        }
        
        return cell
       }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64.0
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
