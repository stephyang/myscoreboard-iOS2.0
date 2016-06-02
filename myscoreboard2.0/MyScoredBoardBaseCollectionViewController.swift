//
//  MyScoredBoardBaseCollectionViewController.swift
//  myscoreboard2.0
//
//  Created by PiHan Hsu on 6/2/16.
//  Copyright © 2016 PiHan Hsu. All rights reserved.
//

import UIKit

class MyScoredBoardBaseCollectionViewController: UIViewController, UICollectionViewDelegate {
    @IBOutlet var collectionView: UICollectionView?
    
    var index = 0
    var widthSize: CGFloat = 0
    var heightSize: CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.delegate = self
        self.automaticallyAdjustsScrollViewInsets = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        print("set size!!")
        widthSize = UIScreen.mainScreen().bounds.size.width * 0.75
        heightSize = UIScreen.mainScreen().bounds.size.height * 0.7
        return CGSize.init(width: widthSize, height: heightSize)
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               insetForSectionAtIndex section: Int) -> UIEdgeInsets{
        let inset = ((self.collectionView?.frame.size.width)! - widthSize) / 2
        
        return UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat{
        return 2
    }

    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let pageWidth = Float(widthSize + Params.spacing)
        let currentOffset = Float(scrollView.contentOffset.x)
        let targetOffset = Float(targetContentOffset.memory.x)
        var newTargetOffset = Float(0)
        
        let scrollViewWidth = Float(scrollView.contentSize.width)
        
        if (targetOffset > currentOffset){
            newTargetOffset = ceilf(currentOffset / pageWidth) * pageWidth
        }else{
            newTargetOffset = floorf(currentOffset / pageWidth) * pageWidth
        }
        
        if newTargetOffset < 0{
            newTargetOffset = 0
        }else if newTargetOffset > scrollViewWidth{
            newTargetOffset = scrollViewWidth
        }
        
        targetContentOffset.memory = CGPointMake( CGFloat(currentOffset) , 0)
        scrollView.setContentOffset(CGPointMake(CGFloat(newTargetOffset), 0), animated: true)
        
        index = Int(newTargetOffset / pageWidth)
        if index == 0 {
            if let cell = self.collectionView?.cellForItemAtIndexPath(NSIndexPath(forItem: index, inSection: 0)){
                UIView.animateWithDuration(Params.ANIMATION_SPEED) {
                    cell.transform = CGAffineTransformIdentity
                }
            }
            
            if let cell = self.collectionView?.cellForItemAtIndexPath(NSIndexPath(forItem: index + 1, inSection: 0)) {
                
                UIView.animateWithDuration(Params.ANIMATION_SPEED) {
                    cell.transform = Params.TRANSFORM_CELL_VALUE
                }
            }
            
        }else {
            
            if let cell = self.collectionView?.cellForItemAtIndexPath(NSIndexPath(forItem: index , inSection: 0)) {
                
                UIView.animateWithDuration(Params.ANIMATION_SPEED) {
                    cell.transform = CGAffineTransformIdentity
                }
            }
            //left
            if let cell = self.collectionView?.cellForItemAtIndexPath(NSIndexPath(forItem: index - 1, inSection: 0)) {
                
                UIView.animateWithDuration(Params.ANIMATION_SPEED) {
                    cell.transform = Params.TRANSFORM_CELL_VALUE
                }
            }
            //right
            if let cell = self.collectionView?.cellForItemAtIndexPath(NSIndexPath(forItem: index + 1, inSection: 0)) {
                
                UIView.animateWithDuration(Params.ANIMATION_SPEED) {
                    cell.transform = Params.TRANSFORM_CELL_VALUE
                }
            }
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}