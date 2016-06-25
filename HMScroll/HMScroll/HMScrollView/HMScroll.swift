//
//  HMScroll.swift
//  HMScroll
//
//  Created by 陈思宇 on 16/6/24.
//  Copyright © 2016年 Human. All rights reserved.
//

import UIKit
let  HMCollectionCellID:String="HMCollectionViewCell"
class HMScroll: UIView {

    
    override init(frame: CGRect) {
       super.init(frame: frame)
        if(frame.size.height==0&&frame.size.width==0){
        return
        }
       setupUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var frame:CGRect{
        didSet{
            setupUI()
        }
    }
    //时间
    var timer:NSTimer?
    
    //数据
    var dataarr:Array<HMScrollModel>?{
        didSet{
            if (dataarr?.count==0)
            {
                return
            }
            pageControl.numberOfPages=(dataarr?.count)!
            pageControl.currentPage=0
            
            
            var newdata=[HMScrollModel]()
            newdata.append((dataarr?.last)!)
            newdata+=dataarr!
            newdata.append((dataarr?.first)!)
            
            dataarr=newdata
            
            collectionView!.reloadData()
            collectionView!.scrollToItemAtIndexPath(NSIndexPath(forRow: 1, inSection: 0), atScrollPosition: UICollectionViewScrollPosition.CenteredHorizontally, animated: false)
        }
    }
    
    //是否自动滚动
    var autoScroll:Bool?
    //每个控件的大小
    var itemSize:CGSize?{
        didSet{
            collectionViewLayout.itemSize=itemSize!
        }
    }
    //控件之间的距离
    var itemSpacing:Float?{
        didSet{
            collectionViewLayout.minimumLineSpacing=CGFloat(itemSpacing!)
        }
    }
    //滚动间隔时间
    var timeInterval:NSTimeInterval = 3{
        didSet{
            startTime()
        }
    }
    // 点击回调
    var didSelected:(model:HMScrollModel)->() = {_ in 
        
    }
    
    //页面标志器
    private lazy var pageControl:UIPageControl = {
        let pageCotrol:UIPageControl = UIPageControl(frame: CGRect(x: self.frame.size.width-100, y: self.frame.size.height-20, width: 100, height: 20))
        pageCotrol.pageIndicatorTintColor=UIColor.greenColor()
        return pageCotrol
    }()
    
    
    private lazy var collectionViewLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    private  var collectionView:UICollectionView?

    
    private func setupUI(){

        
        collectionViewLayout.scrollDirection=UICollectionViewScrollDirection.Horizontal
        
         collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height), collectionViewLayout: collectionViewLayout)
        collectionView!.registerClass(HMCollectionViewCell.self, forCellWithReuseIdentifier: HMCollectionCellID)

        collectionView?.backgroundColor=UIColor.whiteColor()
        collectionView!.decelerationRate = UIScrollViewDecelerationRateFast;
        
        
        
        collectionView!.showsHorizontalScrollIndicator = false;
        collectionView!.showsVerticalScrollIndicator   = false;

        
        collectionView!.dataSource = self
        collectionView!.delegate   = self
        
        self.itemSize=self.frame.size
        self.itemSpacing=0
        self.addSubview(collectionView!)
        
        self.addSubview(pageControl)
    }
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let pageW:CGFloat=CGFloat((itemSize?.width)!) + CGFloat(itemSpacing!)
        let pOffset:CGFloat = CGFloat(pageW) * CGFloat((dataarr?.count)!-2)
        let offX = scrollView.contentOffset.x
        if(offX<0)
        {
            scrollView.contentOffset = CGPoint(x: (pOffset + offX), y: 0)
        }
        else if(offX > (CGFloat(pageW) *  CGFloat((dataarr?.count)!)) - self.frame.size.width )
        {
            scrollView.contentOffset = CGPoint(x: (offX - CGFloat((dataarr?.count)!-2) * CGFloat(pageW)  ), y: 0)
        }
        
        if( itemSize?.width < self.frame.size.width )
        {
        let startOff:CGFloat = pageW - (self.frame.size.width - (itemSize?.width)!)/2
       pageControl.currentPage = Int((scrollView.contentOffset.x - startOff) / pageW)
        }
        else
        {
            let startOff:CGFloat = pageW
            var page = Int((scrollView.contentOffset.x - startOff) / pageW)
            if (page>((dataarr?.count)!-3))
            {
                page = 0
            }
             pageControl.currentPage=page
            print(Int((scrollView.contentOffset.x - startOff) / pageW))

            
        }
        
    }
    private func startTime()
    {
        stopTime()
        if((autoScroll == false))
        {return}
        
        timer = NSTimer(timeInterval: timeInterval, target: self, selector: "scrollAuto", userInfo: nil, repeats: true)
        
        NSRunLoop.mainRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
    }
    
    func scrollAuto()
    {
        let currentOff:CGFloat = collectionView!.contentOffset.x;
        let targetOff:CGFloat  = currentOff + itemSize!.width + CGFloat(itemSpacing!);
        collectionView?.setContentOffset(CGPoint(x: targetOff, y: (collectionView?.contentOffset.y)!), animated: true)

    }
    
    private func stopTime()
    {
        timer?.invalidate()
    }
}




//代理实现
extension HMScroll:UICollectionViewDataSource,UICollectionViewDelegate
{
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return  1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return  dataarr?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:HMCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(HMCollectionCellID, forIndexPath: indexPath) as! HMCollectionViewCell
       cell.model=dataarr![indexPath.row] 
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {

            didSelected(model: dataarr![indexPath.row])
    }

}
