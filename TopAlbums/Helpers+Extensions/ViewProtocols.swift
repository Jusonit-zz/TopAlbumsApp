//
//  ViewProtocols.swift
//  TopAlbums
//
//  Created by Rave Bizz on 5/2/21.
//

import Foundation
import UIKit

protocol ViewExtensionProtocol {
    
    func anchor(top: NSLayoutYAxisAnchor?,
                paddingTop:CGFloat,
                bottom: NSLayoutYAxisAnchor?,
                paddingBottom:CGFloat,
                left: NSLayoutXAxisAnchor?,
                paddingLeft:CGFloat,
                right: NSLayoutXAxisAnchor?,
                paddingRight:CGFloat,
                width:CGFloat,
                height:CGFloat)
    
    func anchorWith(top: NSLayoutYAxisAnchor?,
                paddingTop:CGFloat,
                bottom: NSLayoutYAxisAnchor?,
                paddingBottom:CGFloat,
                left: NSLayoutXAxisAnchor?,
                paddingLeft:CGFloat,
                right: NSLayoutXAxisAnchor?,
                paddingRight:CGFloat,
                width:CGFloat,
                greaterHeight:CGFloat
    )
}
