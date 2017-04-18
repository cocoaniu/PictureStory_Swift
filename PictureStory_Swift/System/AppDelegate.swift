//
//  AppDelegate.swift
//  PictureStory_Swift
//
//  Created by edz on 2017/3/22.
//  Copyright © 2017年 com.cocoa_niu. All rights reserved.
//

import UIKit

import Alamofire
import SwiftyJSON

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        
        let homeVC = ViewController()
        let homeNVC = UINavigationController.init(rootViewController: homeVC)
        homeVC.title = "美图故事"
        homeNVC.tabBarItem.title = "主页"
        homeNVC.tabBarItem.image = UIImage.init(named: "home")
        

        let albumVC = AlbumViewController()
        let albumNVC = UINavigationController.init(rootViewController: albumVC)
        albumNVC.title = "图集"
        albumNVC.tabBarItem.title = "图集"
        albumNVC.tabBarItem.image = UIImage.init(named: "album")
        

        let rootTBC = UITabBarController()
        
        let bgView = UIImageView.init(frame: rootTBC.tabBar.bounds)
        let image = UIImage.init(named: "bg")
        let newImage = UIImage.init(cgImage: (image?.cgImage)!, scale: (image?.scale)!, orientation: (image?.imageOrientation)!)
        bgView.backgroundColor = UIColor.init(patternImage: newImage)
        rootTBC.tabBar.insertSubview(bgView, at: 0)
        

        rootTBC.viewControllers = [homeNVC,albumNVC];
        
        rootTBC.tabBar.tintColor = UIColor.darkGray;
        
        self.window?.rootViewController = rootTBC;
        
        self.window?.makeKeyAndVisible()
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

