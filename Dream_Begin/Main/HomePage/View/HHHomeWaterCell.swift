//
//  HHHomeWaterCell.swift
//  Dream_Begin
//
//  Created by hanhong on 2018/5/15.
//  Copyright © 2018年 hanhong. All rights reserved.
//

import UIKit
import SnapKit

class HHHomeWaterCell: UICollectionViewCell {
    
    //主图展示
    var imageView : UIImageView?
    //描述
    var descLable : UILabel?
    //浏览
    var browseImageView : UIImageView?
    var browseLable : UILabel?
    //点赞
    var praiseImageView : UIImageView?
    var praiseLabel : UILabel?
    //用户
    var userIcon : UIImageView?
    var userNikeName : UILabel?
    
    var _model : HHWaterModel?
    var model : HHWaterModel? {
        get {
            return _model
        }
        set {
            imageView?.sd_setImage(with: NSURL(string: (newValue?.imageUrl)!)! as URL, placeholderImage: UIImage(named: ""))
            descLable?.text = newValue?.desc
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let cellWidth : CGFloat = self.frame.size.width
        let cellHeight : CGFloat = self.frame.size.height
        
        self.imageView = UIImageView()
        self.imageView?.layer.cornerRadius = 5
        self.imageView?.layer.masksToBounds = true
        self.addSubview(self.imageView!)
        self.imageView?.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(self).offset(10)
            make.width.equalTo(cellWidth / 2)
            make.height.equalTo(cellHeight / 2)
        }
        
        self.descLable = UILabel()
        self.descLable?.textColor = UIColor.black
        self.descLable?.font = UIFont.systemFont(ofSize: 16.0)
        self.addSubview(self.descLable!)
        self.descLable?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.imageView?.snp.bottom)!).offset(5)
            make.left.equalTo(self)
            make.right.equalTo(self)
            make.centerX.equalTo(self.imageView!)
        })
        
        self.browseImageView = UIImageView()
        self.addSubview(self.browseImageView!)
        self.browseImageView?.snp.makeConstraints({ (make) in
            make.left.equalTo(self.descLable!)
            make.top.equalTo((self.descLable?.snp.bottom)!).offset(5)
            make.width.equalTo(6)
            make.height.equalTo(6)
        })
        
        self.browseLable = UILabel()
        self.browseLable?.textColor = UIColor.lightGray
        self.browseLable?.font = UIFont.systemFont(ofSize: 10.0)
        self.addSubview(self.browseLable!)
        self.browseLable?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.browseImageView!)
            make.left.equalTo((self.browseImageView?.snp.right)!).offset(5)
            make.width.equalTo(50)
            make.height.equalTo(14)
        })
        
        self.praiseImageView = UIImageView()
        self.addSubview(self.praiseImageView!)
        self.praiseImageView?.snp.makeConstraints({ (make) in
            make.left.equalTo((self.browseLable?.snp.right)!).offset(10)
            make.top.equalTo((self.descLable?.snp.bottom)!).offset(5)
            make.width.equalTo(6)
            make.height.equalTo(6)
        })
        
        self.praiseLabel = UILabel()
        self.praiseLabel?.textColor = UIColor.lightGray
        self.praiseLabel?.font = UIFont.systemFont(ofSize: 10.0)
        self.addSubview(self.praiseLabel!)
        self.praiseLabel?.snp.makeConstraints({ (make) in
            make.top.equalTo(self.browseImageView!)
            make.left.equalTo((self.praiseImageView?.snp.right)!).offset(5)
            make.width.equalTo(50)
            make.height.equalTo(14)
        })
        
        self.userIcon = UIImageView()
        self.userIcon?.layer.cornerRadius = 15
        self.userIcon?.layer.masksToBounds = true
        self.addSubview(self.userIcon!)
        self.userIcon?.snp.makeConstraints({ (make) in
            make.top.equalTo((self.browseImageView?.snp.bottom)!).offset(5)
            make.left.equalTo(self.browseImageView!)
            make.width.equalTo(30)
            make.height.equalTo(30)
        })
        
        self.userNikeName = UILabel()
        self.userNikeName?.textColor = UIColor.colorWithHexString(hex: "#372f84")
        self.userNikeName?.font = UIFont.systemFont(ofSize: 16.0)
        self.addSubview(self.userNikeName!)
        self.userNikeName?.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.userIcon!)
            make.left.equalTo((self.userIcon?.snp.right)!).offset(5)
            make.height.equalTo(18)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
