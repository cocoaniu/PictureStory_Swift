//
//  BaseViewController.swift
//  PictureStory_Swift
//
//  Created by edz on 2017/3/24.
//  Copyright © 2017年 com.cocoa_niu. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage.init(named: "bg"), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        // 导航栏字体颜色
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.darkGray]

        // 按钮颜色
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        
        UIApplication.shared.statusBarStyle = .lightContent;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let backButtonItem : UIBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "箭头"), style: .plain, target: self, action:#selector(backAction))
        self.navigationItem.leftBarButtonItem = backButtonItem
        
        if (self.navigationController?.viewControllers.count)! <= 1 {
            self.navigationItem.leftBarButtonItem = nil
        }
    }
    
    func backAction() {
        if ((self.navigationController?.viewControllers.count)! > 1) {
            self.navigationController?.popViewController(animated: true)
        } else {
            return
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
