//
//  HomeTableViewCell.swift
//  PictureStory_Swift
//
//  Created by edz on 2017/3/23.
//  Copyright © 2017年 com.cocoa_niu. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var picImageView: UIImageView!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
