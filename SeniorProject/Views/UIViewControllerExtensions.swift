//
//  UIViewControllerExtensions.swift
//  SeniorProject
//
//  Created by Patrick Cook on 5/10/18.
//  Copyright © 2018 Patrick Cook. All rights reserved.
//
import UIKit
import Foundation

extension UIViewController {
    
    func showLoadingAlert(uiView: UIView) {
        let container: UIView = UIView()
        container.frame = uiView.frame
        container.center = uiView.center
        container.tag = -1
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = CGPoint(x: container.frame.size.width / 2,
                                     y: container.frame.size.height / 3);
        loadingView.backgroundColor = UIColor(red:0.27, green:0.27, blue:0.27, alpha:0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10

        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        actInd.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.whiteLarge
        actInd.center = CGPoint(x: loadingView.frame.size.width / 2,
                                y: loadingView.frame.size.height / 2);
        
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        actInd.startAnimating()
    }
    
    func dismissLoadingAlert(uiView: UIView) {
        for view in uiView.subviews {
            if (view.tag == -1) {
                view.removeFromSuperview()
            }
        }
    }
    
    func showErrorAlert(error: Error) {
        if error._code == NSURLErrorTimedOut {
            let alertController = UIAlertController(title: "Connection Timeout", message: "Sorry about that, someone must have spilled coffee on our servers..", preferredStyle: .alert)
            let actionOk = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alertController.addAction(actionOk)
            self.present(alertController, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Oops, something happened", message: "Sorry about that, someone must have spilled coffee on our servers.. (wasn't a 401)", preferredStyle: .alert)
            let actionOk = UIAlertAction(title: "OK", style: .default, handler: nil)
            
            alertController.addAction(actionOk)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
