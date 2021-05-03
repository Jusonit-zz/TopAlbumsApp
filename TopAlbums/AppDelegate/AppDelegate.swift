//
//  AppDelegate.swift
//  TopAlbums
//
//  Created by Rave Bizz on 5/1/21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let albumService = AlbumService()
        let albumListTVC = AlbumsListTableVC(albumService: albumService)
        let mainNav = UINavigationController(rootViewController: albumListTVC)
        mainNav.navigationBar.prefersLargeTitles = true
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = mainNav
        window?.makeKeyAndVisible()
        mainNav.viewControllers = [albumListTVC]
        
        return true
    }

}


