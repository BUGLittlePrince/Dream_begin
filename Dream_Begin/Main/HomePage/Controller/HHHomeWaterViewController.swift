//
//  HHHomeWaterViewController.swift
//  Dream_Begin
//
//  Created by hanhong on 2018/5/15.
//  Copyright © 2018年 hanhong. All rights reserved.
//

import UIKit

class HHHomeWaterViewController: UIViewController {
    let hh_ScreenHeight = UIScreen.main.bounds.size.height
    let hh_ScreenWidth = UIScreen.main.bounds.size.width
    var dataArray : NSMutableArray = NSMutableArray()
    //适配iPhoneX
    let hh_StatusBarHeight = UIApplication.shared.statusBarFrame.size.height
    func getTBH(height : CGFloat) -> CGFloat {
        if height > 20 {
            return 83
        } else {
            return 49
        }
    }
    
    //颜色宏
    func RGBA(r:CGFloat,_ g:CGFloat,_ b:CGFloat) -> UIColor {
        return UIColor(red: (r) / 255.0, green: (g) / 255.0, blue: (r) / 255.0, alpha: 1.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 1.0)
        setupCollectionView()
        setupLogic()
    }
    
    func setupLogic() {
        let logic : HHWaterLogic = HHWaterLogic()
        logic.loadData()
        dataArray = logic.dataArray
    }
    
    func setupCollectionView(){
        //创建布局方式
        let layout = HHWaterflowLayout()
        
        let height = getTBH(height: UIApplication.shared.statusBarFrame.height)
        
        //UICollectionView
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 32, width: hh_ScreenWidth, height: hh_ScreenHeight - hh_StatusBarHeight - 44 - height), collectionViewLayout: layout)
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.backgroundColor = RGBA(r: 0, 0, 0)
        //设置垂直滚动是否滚到item的最底部
        collectionView.alwaysBounceVertical = true
        //设置单元格点击
        collectionView.allowsSelection = true
        //设置collectionView单元格多选
        collectionView.allowsMultipleSelection = false
        //开启UICollectionView的分页显示效果
        collectionView.isPagingEnabled = true
        
        //注册UICollectionViewCell
        collectionView.register(HHHomeWaterCell.self, forCellWithReuseIdentifier: "cell")
        //注册UICollectionView分组头部
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "reusable")
        
        self.view.addSubview(collectionView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

extension HHHomeWaterViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("cell被点击了！！！")
    }
}

extension HHHomeWaterViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : HHHomeWaterCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HHHomeWaterCell
        cell.backgroundColor = UIColor.red
        cell.model = dataArray[indexPath.item] as? HHWaterModel
        return cell
    }
    
    //分区头部高度
    
    func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout:UICollectionViewLayout, referenceSizeForHeaderInSection section:Int) -> CGSize {
        
        return CGSize.init(width: hh_ScreenWidth, height:200)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headView : UIView = UIView()
        headView.frame = CGRect(x: 0, y: 0, width: hh_ScreenWidth, height: 200)
        headView.backgroundColor = UIColor.cyan
        
        var reusableView : UICollectionReusableView!
        if kind == UICollectionElementKindSectionHeader {
            reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "reusable", for: indexPath)
            reusableView.addSubview(headView)
        }
        return reusableView
    }
}
