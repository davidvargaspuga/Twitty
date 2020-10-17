//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by David Vargas on 10/9/20.
//  Copyright © 2020 Dan. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var tweetContent: UILabel!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweetButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func favTweet(_ sender: Any) {
        let toBeFaved = !favorited
        if(toBeFaved){
            TwitterAPICaller.client?.favTweet(tweetId: tweetId, success: {
                self.setFavorite(true)
            }, failure: { (error) in
                print("fav did not suceed: \(error)")
            })
        } else{
            TwitterAPICaller.client?.unfavTweet(tweetId: tweetId, success: {
                self.setFavorite(false)
            }, failure: { (error) in
                print("unfav did not suceed: \(error)")
            })
        }
    }
    @IBAction func retweetTweet(_ sender: Any) {
        let toBeRetweeted = !retweeted
        if(toBeRetweeted){
            TwitterAPICaller.client?.retweet(tweetId: tweetId, success: {
                self.setRetweeted(true)
            }, failure: { (error) in
                print("ret did not suceed: \(error)")
            })
        } else{
            TwitterAPICaller.client?.unretweet(tweetId: tweetId, success: {
                self.setRetweeted(false)
            }, failure: { (error) in
                print("unret did not suceed: \(error)")
            })
        }
    }
    
    var favorited:Bool = false
    var retweeted:Bool = false
    var tweetId:Int = -1
    
    
    func setFavorite(_ isFavorited:Bool){
        favorited = isFavorited
        if(favorited){
            favButton.setImage(UIImage(named: "favor-icon-red"), for: UIControl.State.normal)
        } else{
            favButton.setImage(UIImage(named: "favor-icon"), for: UIControl.State.normal)
        }
    }
    
    func setRetweeted(_ isRetweeted: Bool){
        retweeted = isRetweeted
        if(retweeted){
            retweetButton.setImage(UIImage(named: "retweet-icon-green"), for: UIControl.State.normal)
            retweetButton.isEnabled = false
        } else{
            retweetButton.setImage(UIImage(named: "retweet-icon"), for: UIControl.State.normal)
            retweetButton.isEnabled = true
        }
    }
}
