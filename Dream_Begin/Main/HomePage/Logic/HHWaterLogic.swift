//
//  HHWaterLogic.swift
//  Dream_Begin
//
//  Created by hanhong on 2018/5/16.
//  Copyright © 2018年 hanhong. All rights reserved.
//

import UIKit

class HHWaterLogic: NSObject {
    var dataArray : NSMutableArray = NSMutableArray()
    var contentArray = NSMutableArray()
    override init() {
        
        contentArray = [
            ["imageUrl":"http://img5.imgtn.bdimg.com/it/u=1244438254,370441081&fm=27&gp=0.jpg", "desc":"不相信自己的人，连努力的价值都没有", "browse":"0", "praise":"0", "userIcon":"http://img0.imgtn.bdimg.com/it/u=3357621393,1093537183&fm=27&gp=0.jpg", "userNikeName":"鸣人"],
            ["imageUrl":"http://img5.imgtn.bdimg.com/it/u=3599709375,3489383628&fm=27&gp=0.jpg", "desc":"有思念你的人在的地方，就是你的归处", "browse":"1", "praise":"2", "userIcon":"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=241598899,1977095343&fm=27&gp=0.jpg", "userNikeName":"迪达拉"],
            ["imageUrl":"http://img2.imgtn.bdimg.com/it/u=1957108464,642042110&fm=27&gp=0.jpg", "desc":"不要为自己的努力道歉，这样太对不起自己的努力了", "browse":"2", "praise":"3", "userIcon":"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=577806146,954089872&fm=27&gp=0.jpg", "userNikeName":"雏田"],
            ["imageUrl":"http://img1.imgtn.bdimg.com/it/u=3575528721,3665604182&fm=27&gp=0.jpg", "desc":"正真重要的东西，就算失去自己珍贵的生命，也要用双手守护到底", "browse":"3", "praise":"4", "userIcon":"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1567919403,304805180&fm=27&gp=0.jpg", "userNikeName":"宇智波鼬"],
            ["imageUrl":"http://img0.imgtn.bdimg.com/it/u=2797981246,1987474134&fm=27&gp=0.jpg", "desc":"事情总是突然的，而理由总是事后面加上去的", "browse":"4", "praise":"5", "userIcon":"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2639321787,3507946142&fm=27&gp=0.jpg", "userNikeName":"宇智波佐助"],
            ["imageUrl":"http://img0.imgtn.bdimg.com/it/u=2817774954,1426635408&fm=27&gp=0.jpg", "desc":"当有人从心底认同你的时候，那个人对你来说就是最重要的人", "browse":"5", "praise":"6", "userIcon":"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=1542482002,1179988339&fm=27&gp=0.jpg", "userNikeName":"宇智波带土"],
            ["imageUrl":"http://img3.imgtn.bdimg.com/it/u=1369849217,4104416672&fm=27&gp=0.jpg", "desc":"人在保护自己最重要的人时就会变得很强", "browse":"6", "praise":"7", "userIcon":"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1223452854,1403165180&fm=27&gp=0.jpg", "userNikeName":"博人"],
            ["imageUrl":"http://img3.imgtn.bdimg.com/it/u=3537667221,3386222632&fm=27&gp=0.jpg", "desc":"无论你有多强，也别想着独自背负所有，因为那样一来，你必然失败", "browse":"7", "praise":"8", "userIcon":"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=4083411190,2113778681&fm=27&gp=0.jpg", "userNikeName":"晓"],
            ["imageUrl":"http://img1.imgtn.bdimg.com/it/u=915089913,2216427118&fm=27&gp=0.jpg", "desc":"木叶飞舞之处，火亦生生不息", "browse":"8", "praise":"9", "userIcon":"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3486185149,3920977773&fm=27&gp=0.jpg", "userNikeName":"木叶黄色闪光"],
            ["imageUrl":"http://img1.imgtn.bdimg.com/it/u=4198918197,60625816&fm=27&gp=0.jpg", "desc":"人生，一半是现实，一半是梦想。一念花开，一念花落", "browse":"9", "praise":"10", "userIcon":"https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=4129880130,1522243344&fm=27&gp=0.jpg", "userNikeName":"纲手"],
            ["imageUrl":"http://img4.imgtn.bdimg.com/it/u=369371576,547834484&fm=27&gp=0.jpg", "desc":"时间再拉长一点，让我有时间收拾一下心情", "browse":"10", "praise":"11", "userIcon":"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1767156855,3538893967&fm=27&gp=0.jpg", "userNikeName":"自来也"],
            ]
    }
    
    func loadData() {
        for i in 0 ..< contentArray.count {
            let model : HHWaterModel = HHWaterModel()
            model.setValuesForKeys(contentArray[i] as! [String : Any])
            dataArray.add(model)
        }
        
    }
}
