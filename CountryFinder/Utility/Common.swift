//
//  Common.swift
//  TestApp
//
//  Created by Dipen on 3/5/20.
//  Copyright © 2020 Dipen. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration
import Network
let monitor = NWPathMonitor()
typealias CompletionHandler = (_ success:Bool) -> Void

func checkInterwebs() -> Bool {
    var status = false
    monitor.pathUpdateHandler = { path in
        if path.status == .satisfied {
            status = true  // online
        }
    }
    return status
}


func isConnectedToNetwork() -> Bool {
    
    var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    }
    
    var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
    if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
        return false
    }
        
    // Working for Cellular and WIFI
    let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
    let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
    let ret = (isReachable && !needsConnection)
    
    return ret
}

// create the alert
func showAlertWithMsg(viewController:UIViewController, msg:String, completionHandler:@escaping CompletionHandler){
    let alert = UIAlertController(title: "Info", message: msg, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
        completionHandler(true)
    }))
    viewController.present(alert, animated: true, completion: nil)
}

func ConfigureNoDataFound(tableView:UITableView,textitem:String){
    let rect = CGRect(x: 0,
                      y: 0,
                      width: tableView.bounds.size.width,
                      height:tableView.bounds.size.height)
    let noDataLabel: UILabel = UILabel(frame: rect)
    noDataLabel.numberOfLines = 2
    noDataLabel.text = textitem
    noDataLabel.textColor = UIColor.lightGray
    noDataLabel.textAlignment = NSTextAlignment.center
    tableView.backgroundView = noDataLabel
    tableView.separatorStyle = .none
}

func getControllerFromStoryBoard(identiFier:String) -> (UIViewController){
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    let nextViewController = storyBoard.instantiateViewController(withIdentifier: identiFier)
    return nextViewController
}

extension UIView {
    @IBInspectable var makeCornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = frame.size.height / 2
            layer.masksToBounds = newValue > 0
        }
    }

    func parentView<T: UIView>(of type: T.Type) -> T? {
        guard let view = self.superview else {
            return nil
        }
        return (view as? T) ?? view.parentView(of: T.self)
    }


    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius

        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
}

extension UIView {
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }

}
