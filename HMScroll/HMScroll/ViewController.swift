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
            "http://a4.mzstatic.com/us/r30/Features49/v4/77/73/3b/77733b19-2fb6-be1a-6a5e-8e01c30d2c94/flowcase_1060_520_2x.jpeg",
            "http://a3.mzstatic.com/us/r30/Features49/v4/93/31/d4/9331d426-4596-51f4-8acd-5b0aba8c1692/flowcase_1060_520_2x.jpeg"
            ]
    
        let arr1 = [
        "测试1","测试2"
        ]
        
        var res:Array<HMScrollModel> = [HMScrollModel]()
        for i in 0...1
        {
            let model:HMScrollModel=HMScrollModel()
            model.text=arr1[i]
            model.imageURL=arr[i]
            res.append(model)
        }
        
        return res
    }()
    
    
    

}

