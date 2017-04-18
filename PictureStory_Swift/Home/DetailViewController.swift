//
//  DetailViewController.swift
//  PictureStory_Swift
//
//  Created by edz on 2017/4/7.
//  Copyright © 2017年 com.cocoa_niu. All rights reserved.
//

import UIKit
import YYText

class DetailViewController: BaseViewController {
    
    var contentStr: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.automaticallyAdjustsScrollViewInsets = false
        self.navigationController?.automaticallyAdjustsScrollViewInsets = false
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.initUI()
        // Do any additional setup after loading the view.
    }
    
    
    func initUI() {
        let contentLabel : YYTextView = YYTextView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height - 64))
        
        contentLabel.isVerticalForm = true
        
        contentLabel.font = UIFont.init(name:"FZLONGZFW--GB1-0", size: 20.0)
        
        contentLabel.isEditable = false
        
        self.view.addSubview(contentLabel)
        
        contentLabel.text = contentStr
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
