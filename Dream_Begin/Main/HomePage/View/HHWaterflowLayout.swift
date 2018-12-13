//
//  HHWaterflowLayout.swift
//  Dream_Begin
//
//  Created by hanhong on 2018/5/14.
//  Copyright © 2018年 hanhong. All rights reserved.
//

import UIKit

class HHWaterflowLayout: UICollectionViewLayout {
    //列数(可随意更改)
    let columnCount = 3
    
    //每列之间的距离
    let columnMargin: CGFloat = 10
    
    //每行之间的距离
    let rowMargin: CGFloat = 10
    
    //边缘距离
    let edgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    //存放所有cell的布局属性
    var attributes = [UICollectionViewLayoutAttributes]()
    
    //存放所有列的当前高度
    var columnHeights = [CGFloat]()
    
    //布局初始化
    override func prepare() {
        print("prepare")
        super.prepare()
        
        //清除之前的计算
        attributes.removeAll()
        columnHeights.removeAll()
        
        for _ in 0..<columnCount {
            //append(0) 是在arr数组的尾端追加变量值0到数组中  即数组长度增加1
            columnHeights.append(0)
        }
        
        //创建每一个cell对应的布局属性
        let count = collectionView?.numberOfItems(inSection: 0) ?? 0
        for i in 0..<count {
            // 创建位置
            let indexPath = NSIndexPath(item: i, section: 0)
            // 获取indexPath位置cell对应的布局属性
            let attrs = layoutAttributesForItem(at: indexPath as IndexPath)
            attributes.append(attrs!)
        }
        
    }
    //UICollectionViewLayout 当继承UICollectionViewLayout时，会不停的调用layoutAttributesForElements方法
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        
        return attributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        //布局属性
        let attrs = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        let collectionViewW = collectionView!.frame.width
        
        //设置布局属性的frame
        let w: CGFloat = (collectionViewW - edgeInsets.left - edgeInsets.right - CGFloat(columnCount - 1) * columnMargin) / CGFloat(columnCount)
        let h: CGFloat = CGFloat(50 + arc4random_uniform(100))
        
        //找到最短的那一列
        //最短的列数
        var destColumn = 0
        //最短的高度
        var minHeight = columnHeights[0];
        //遍历数组找出最短的高度
        for i in 1..<columnCount {
            let height = columnHeights[i]
            if minHeight > height {
                minHeight = height
                destColumn = i
            }
        }
        let x: CGFloat = edgeInsets.left + (CGFloat(destColumn) * (w + columnMargin))
        let y = minHeight + columnMargin
        
        attrs.frame = CGRect(x: x, y: y, width: w, height: h)
        //更新columnHeight
        columnHeights[destColumn] = attrs.frame.maxY
        return attrs
    }
    
    //collectionViewContentSize返回collectionView的contentSize
    override var collectionViewContentSize: CGSize {
        //最短的高度
        var minHeight = columnHeights[0];
        //遍历数组找出最短的高度
        for i in 1..<columnCount {
            let height = columnHeights[i]
            if minHeight < height {
                minHeight = height
            }
        }
        return CGSize(width: 0, height: minHeight + columnMargin)
    }
}
