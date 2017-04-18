//
//  ViewController.swift
//  PictureStory_Swift
//
//  Created by edz on 2017/3/22.
//  Copyright © 2017年 com.cocoa_niu. All rights reserved.
//

import UIKit
import SwiftyJSON
import DGElasticPullToRefresh
import MJRefresh
import pop

class ViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    var tableView : UITableView?
    var pageNum : Int?
    var page_total : Int?
    lazy var dataArray : NSMutableArray = {return NSMutableArray()}()
    
    
    let footer = MJRefreshAutoNormalFooter()

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //loadData
        pageNum = 1
        loadData()
        
        self.title = "美图故事";

        
        //initUI
        initUI()
        
    }
    
    deinit {
        tableView?.dg_removePullToRefresh()
    }
    
    private func initUI() {
        tableView = UITableView.init(frame: self.view.frame, style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.register(UINib.init(nibName: "HomeTableViewCell", bundle: Bundle.main), forCellReuseIdentifier:"test_cell")
        tableView?.rowHeight = UITableViewAutomaticDimension
        tableView?.estimatedRowHeight = 80
        tableView?.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        self.view.addSubview(tableView!)
        
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
        tableView?.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            DispatchQueue.main.async {
                self?.loadData()
                self?.tableView?.mj_footer.resetNoMoreData()
                self?.tableView?.dg_stopLoading()
            }
        }, loadingView: loadingView)
        
        tableView?.dg_setPullToRefreshFillColor(UIColor(red: 57/255.0, green: 67/255.0, blue: 89/255.0, alpha: 1.0))
        tableView?.dg_setPullToRefreshBackgroundColor((tableView?.backgroundColor!)!)
        
        

        // 上拉刷新
        footer.setRefreshingTarget(self, refreshingAction:#selector(footerRefresh))
        self.tableView?.mj_footer = footer

    }

    
    
    func footerRefresh() {
        if self.pageNum! < 1 {
            self.tableView?.mj_footer.endRefreshingWithNoMoreData()
        } else {
            self.p_solveData(Page: self.pageNum!)
            self.tableView?.mj_footer.endRefreshing()
        }
    }
    
    func loadData() {
        NetworkRequest().getRequest(urlString: "http://www.polaxiong.com/collections/get_edition_num", params: [:], success: { (tempDict) in
            self.page_total = JSON(tempDict)["data"]["edition"].int
            self.pageNum = self.page_total
            self.p_solveData(Page: self.pageNum!)
        }) { (error) in
            print(error)
        }
    }
    
    
    func p_solveData(Page page:Int) {
        NetworkRequest().getRequest(urlString: "http://www.polaxiong.com/collections/get_entries_by_collection_id/"+String(page), params: [:], success: { (tempDict) in
            print("第一页内容：\(tempDict)")
            
            
            if self.pageNum == self.page_total {
                self.dataArray.removeAllObjects()
            }
            
            let tempArray : NSArray? = tempDict["data"] as! NSArray?
            
            
            for dic in tempArray! {
                let model = PictureStoryModel.init(dict: (dic as? [String:AnyObject])!)
                self.dataArray.add(model)
            }
            
            self.pageNum! -= 1
            
            self.tableView?.reloadData()
            
        }) { (error) in
            print(error)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : HomeTableViewCell = tableView.dequeueReusableCell(withIdentifier: "test_cell", for: indexPath) as! HomeTableViewCell
        
        let model: PictureStoryModel = (self.dataArray.object(at: indexPath.row) as? PictureStoryModel)!
        
        cell.contentLabel?.text = model.story_detail?.story!
        
        let colorStr = "0x\(model.img_color!)"

        let color = strtoul(colorStr, nil, 16)
        
        cell.picImageView?.backgroundColor = UIColor.rgbColorFromHex(rgb: Int(color));
        
        cell.picImageView.sd_setImage(with: URL.init(string: model.thumb!)!)
        
        cell.avatarImageView.sd_setImage(with: URL.init(string: model.avatar!)!)
        
//        let animation = POPBasicAnimation.init(propertyNamed: kPOPLayerPositionX)
//        animation?.toValue = NSValue(cgPoint: CGPoint(x:100, y:200))
//        animation?.duration = 0.8
//        animation?.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
//        cell.layer.pop_add(animation, forKey: "positionX")
//        
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        let model = self.dataArray[indexPath.row] as! PictureStoryModel
        detailVC.contentStr = (model.story_detail?.story)!
        self.navigationController?.pushViewController(detailVC, animated: true)
    }

    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

/**
 *  扩展部分
 */
extension UIColor {

    class func rgbColorFromHex(rgb:Int) -> UIColor {

        return UIColor.init(red: ((CGFloat)((rgb&0xFF0000) >> 16)) / 255.0,
                       green: ((CGFloat)((rgb&0xFF00) >> 8)) / 255.0,
                       blue: ((CGFloat)(rgb&0xFF)) / 255.0,
                       alpha: 1.0)
    }
}

