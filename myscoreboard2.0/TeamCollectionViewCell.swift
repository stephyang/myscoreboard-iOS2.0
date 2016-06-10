//
//  TeamCollectionViewCell.swift
//  myscoreboard2.0
//
//  Created by PiHan Hsu on 6/9/16.
//  Copyright © 2016 PiHan Hsu. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftyJSON

class TeamCollectionViewCell: MyScoreBoardBaseCollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var teamPlayersCollectionView: UICollectionView?
    
    var team:Team?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        teamPlayersCollectionView?.registerNib(UINib(nibName: "PlayerCardCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PlayerCardCollectionViewCell")
        // Initialization code
        teamPlayersCollectionView?.delegate = self
        teamPlayersCollectionView?.dataSource = self
        startGameButton.layer.cornerRadius = startGameButton.frame.size.height / 2
        startGameButton.clipsToBounds = true
    }

    func collectionView(collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let size = (self.teamPlayersCollectionView!.frame.size.width)/3 - 10-10
        return CGSize.init(width: size, height: size*1.25)
        
    }
    
    //計算 minimumInteritemSpacing 的間隔是多少
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    //計算 LineSpacing 的間隔是多少
    func collectionView(collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }

    
    // MARK: CollectionView Data Source
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if team != nil {
            return team!.players.count + 1
        }else{
            return 0
        }
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PlayerCardCollectionViewCell", forIndexPath: indexPath) as! PlayerCardCollectionViewCell
        
        if indexPath.item == 0 {
            cell.playerName.text = "新增成員"
            cell.playerImage.image = UIImage(named: "ico_member_add_3x")
            
        }else{
            
            let player = team!.players[indexPath.row-1]
            cell.playerName.text = player.playerName
            
            if let imageUrl = player.playerImageUrl {
                if imageUrl != "" {
                    cell.playerImage.sd_setImageWithURL(NSURL(string: imageUrl)!)
                }
            }else{
                cell.playerImage.image = UIImage()
            }
        }

        return cell
    }


}
