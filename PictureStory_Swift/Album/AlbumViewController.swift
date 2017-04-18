//
//  AlbumViewController.swift
//  PictureStory_Swift
//
//  Created by edz on 2017/3/24.
//  Copyright © 2017年 com.cocoa_niu. All rights reserved.
//

import UIKit
import DGElasticPullToRefresh
import SwiftyJSON

class AlbumViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    var tableView : UITableView!
    var page_total : Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUI()
        loadData()
        // Do any additional setup after loading the view.
    }

    func loadUI() {
        tableView = UITableView.init(frame: self.view.frame, style: .plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "test_cell")
        self.view.addSubview(tableView!)
        
        if tableView.responds(to:#selector(setter: UITableViewCell.separatorInset)) {
            tableView.separatorInset = UIEdgeInsets.zero
        }
        if tableView.responds(to:#selector(setter: UIView.layoutMargins)) {
            tableView.layoutMargins = UIEdgeInsets.zero
        }
        
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
        tableView?.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            DispatchQueue.main.async {
                self?.loadData()
                self?.tableView?.dg_stopLoading()
            }
            }, loadingView: loadingView)
        
        tableView?.dg_setPullToRefreshFillColor(UIColor(red: 57/255.0, green: 67/255.0, blue: 89/255.0, alpha: 1.0))
        tableView?.dg_setPullToRefreshBackgroundColor((tableView?.backgroundColor!)!)
    }
    
    func loadData() {
        NetworkRequest().getRequest(urlString: "http://www.polaxiong.com/collections/get_edition_num", params: [:], success: { (tempDict) in
            self.page_total = JSON(tempDict)["data"]["edition"].int!
            self.tableView.reloadData()
        }) { (error) in
            print(error)
        }
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.page_total
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "test_cell", for: indexPath) as UITableViewCell
        
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.textLabel?.textColor = UIColor.init(red: 153 / 255.0, green: 153 / 255.0, blue: 153 / 255.0, alpha: 1)
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.text = "- 第\(self.page_total - indexPath.row)期图集 -"
        
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let listVC = ViewController()
        listVC.title = "- 第\(self.page_total - indexPath.row)期图集 -"
        listVC.isAlbum = true
        listVC.albumNum = self.page_total - indexPath.row
        self.navigationController?.pushViewController(listVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell.responds(to:#selector(setter: UIView.layoutMargins)) {
            cell.layoutMargins = UIEdgeInsets.zero
        }
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = UIEdgeInsets.zero
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
