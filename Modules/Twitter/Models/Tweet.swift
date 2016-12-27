//
//  Tweet.swift
//  Smashtag
//
//  Created by Stephen O'Kennedy on 18/12/2016.
//  Copyright © 2016 Stephen O'Kennedy. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

struct Tweet {
    let message : String
    let user : User
    let hashtags : [String]
    let media : [Media]
    
    init(_ twitterSearchRsp: JSON) {
        message = twitterSearchRsp["text"].stringValue
        hashtags = twitterSearchRsp["entities"]["hashtags"].arrayValue.map {$0["text"].stringValue}
        user = User(twitterSearchRsp["user"])
        media = twitterSearchRsp["media"].arrayValue.map {Media($0)}
    }

}


struct User {
    let name : String
    let screenName : String
    let location : String
    let url : NSURL
    let imageURL : NSURL
    
    init (_ userInfo: JSON){
        name = userInfo["name"].stringValue
        screenName = userInfo["screen_name"].stringValue
        location = userInfo["location"].stringValue
        url = NSURL(fileURLWithPath: userInfo["url"].stringValue)
        imageURL = NSURL(fileURLWithPath: userInfo["profile_image_url"].stringValue)
        
    }
}

struct Media {
    let type : String
    let url : NSURL
    let sizes : Dictionary<String, MediaSize>
    
    init (_ mediaInfo: JSON){
        type = mediaInfo["type"].stringValue
        url = NSURL(fileURLWithPath:mediaInfo["media_url"].stringValue)
        sizes = [
            "large" : MediaSize(mediaInfo["sizes","large"]),
            "medium" : MediaSize(mediaInfo["sizes","medium"]),
            "small" : MediaSize(mediaInfo["sizes","small"]),
            "thumb" : MediaSize(mediaInfo["sizes","thumb"])
            
        ]
    }
}

struct MediaSize{
    
    let width : Double
    let height : Double
    let resize : String
    
    init(_ mediaSizeInfo: JSON){
        width = mediaSizeInfo["w"].doubleValue
        height = mediaSizeInfo["h"].doubleValue
        resize = mediaSizeInfo["resize"].stringValue
    }
}
