//
//  ViewController.swift
//  HMScroll
//
//  Created by Human on 16/6/23.
//  Copyright © 2016年 Human. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       let ScrollView:HMScroll = HMScroll(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: itemSize.height))
        ScrollView.autoScroll=true
        ScrollView.timeInterval=3
        ScrollView.itemSize=itemSize
        ScrollView.itemSpacing=itemSpacing
        ScrollView.dataarr=dataarr
        ScrollView.direction=HMDirection.Left
        ScrollView.didSelected = {
            (model:HMScrollModel)->() in
            
            print(model.text!)
            
        }
        view.addSubview(ScrollView)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    private lazy var itemSize = CGSize(width: 250,height: 130)
    
    private lazy var itemSpacing:Float = 5
    
    private lazy var dataarr:[HMScrollModel] = {
        let arr = [
            "http://images.apple.com/cn/itunespromos/itunes-this-week/images/2016/6/0cc2a1ba-c7e5-6860-fa1a-619258727fcd/flowcase_200_98_1x.jpg",
            "http://images.apple.com/cn/itunespromos/itunes-this-week/images/2016/6/2af3e147-6a8a-f934-8da0-fc5b1b8b9643/flowcase_200_98_1x.jpg",
            "http://images.apple.com/cn/itunespromos/itunes-this-week/images/2016/6/bceec353-bb8b-d0e8-0134-b44882dfaafb/flowcase_680_260_1x.jpg",
            "http://images.apple.com/cn/itunespromos/itunes-this-week/images/2016/6/fc636921-72fe-cc25-3e53-39ede9feb58a/flowcase_200_98_1x.jpg"
            ]
    
        let arr1 = [
        "测试1","测试2","测试3","测试4"
        ]
        
        var res:Array<HMScrollModel> = [HMScrollModel]()
        for i in 0...3
        {
            let model:HMScrollModel=HMScrollModel()
            model.text=arr1[i]
            model.imageURL=arr[i]
            res.append(model)
        }
        
        return res
    }()
    
    
    

}

