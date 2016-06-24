//
//  HMCollectionViewCell.swift
//  HMScroll
//
//  Created by 陈思宇 on 16/6/24.
//  Copyright © 2016年 Human. All rights reserved.
//

import UIKit

class HMCollectionViewCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var model:HMScrollModel?{
        didSet{
            label.text=model?.text
            let URL = NSURL(string: (model?.imageURL)!)!
            imageView.setImageWithURL(URL)
        }
    }
    
   lazy var imageView:UIImageView = UIImageView()
    
     lazy var label:UILabel = UILabel()
    
    
    private func setupUI(){
        imageView.frame=CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        imageView.clipsToBounds = true
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
//        imageView.backgroundColor=randomColor()
        
        contentView.addSubview(imageView)
        
        label.frame=CGRect(x: 0, y: self.frame.height-20, width: self.frame.width, height: 20)
        label.numberOfLines=0
        label.textAlignment=NSTextAlignment.Center
        label.textColor=UIColor.whiteColor()
        label.font = UIFont.systemFontOfSize(16)
        
        contentView .addSubview(label)
        
    }
}
