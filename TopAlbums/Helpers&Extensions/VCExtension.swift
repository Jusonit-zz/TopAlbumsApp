//
//  VCExtension.swift
//  TopAlbums
//
//  Created by Rave Bizz on 5/2/21.
//

import UIKit

extension UIViewController {
    
    func showNoActionAlert(titleStr:String, messageStr:String, style: UIAlertAction.Style) {
        let alert = UIAlertController(title: titleStr, message: messageStr, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
