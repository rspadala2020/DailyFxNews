//
//  AppUtils.swift
//  dailyFxNews
//
//  Created by raja padala on 06/11/21.
//

import Foundation
import UIKit

/* Show Progress Indicator */
func showProgressIndicator(view:UIView){
    view.isUserInteractionEnabled = false
    var activityIndicator: UIActivityIndicatorView? = nil
    activityIndicator = UIActivityIndicatorView(style: .large)
    activityIndicator?.tag = 99
    view.addSubview(activityIndicator!)
    view.bringSubviewToFront(activityIndicator!)
}

/* Hide progress Indicator */
func hideProgressIndicator(view:UIView){
    view.isUserInteractionEnabled = true
    if let viewWithTag = view.viewWithTag(99) {
        viewWithTag.removeFromSuperview()
    }
}

extension UIViewController {
    
    func showAlert(title:String,message:String,actionTitle:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
