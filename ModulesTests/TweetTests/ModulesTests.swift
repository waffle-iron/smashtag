//
//  ModulesTests.swift
//  ModulesTests
//
//  Created by Stephen O'Kennedy on 16/12/2016.
//  Copyright © 2016 Stephen O'Kennedy. All rights reserved.
//

import XCTest
import Quick
import Nimble
import SwiftyJSON

class ModulesTests: QuickSpec {

    override func spec() {
        describe("TweetTransformer") {
            it("is able to basic arthmatic") {
                expect(2 + 2).to(equal(4))
            }

            it("is able to parse the twitter json response into the Tweet struct") {

                let path = Bundle.main.path(forResource: "trinity_college_dublin_tweets", ofType: "json")
                let data = try? NSData(contentsOfFile: path!, options: NSData.ReadingOptions.mappedIfSafe)
                let twitterStatuses  = JSON(data: data as! Data)["statuses"].arrayValue
                expect(twitterStatuses.count).to(beGreaterThan(1))
                let twitterStatus = twitterStatuses.first!
                let tweet = Tweet(twitterStatus)

                expect(tweet.message).to(equal(twitterStatus["text"].stringValue))
                expect(tweet.hashtags).to(haveCount(twitterStatus["entities","hashtags"].arrayValue.count))
                expect(tweet.hashtags).to(contain(twitterStatus["entities","hashtags"].arrayValue.map {$0["text"].stringValue}))
                expect(tweet.user.name).to(equal(twitterStatus["user","name"].stringValue))
                expect(tweet.user.screenName).to(equal(twitterStatus["user","screen_name"].stringValue))
                expect(tweet.user.location).to(equal(twitterStatus["user","location"].stringValue))
                expect(tweet.user.url).to(equal(NSURL(fileURLWithPath: twitterStatus["user","url"].stringValue)))
                expect(tweet.user.imageURL).to(equal(NSURL(fileURLWithPath: twitterStatus["user","profile_image_url"].stringValue)))
                expect(tweet.media[0].type).to(equal((twitterStatus["media"].arrayValue.first!["type"].stringValue)))
                expect(tweet.media[0].url).to(equal(NSURL(fileURLWithPath: twitterStatus["media"].arrayValue.first!["media_url"].stringValue)))
                expect(tweet.media[0].sizes["large"]?.width).to(equal(twitterStatus["media"].arrayValue.first!["sizes","large","w"].doubleValue))
                expect(tweet.media[0].sizes["large"]?.height).to(equal(twitterStatus["media"].arrayValue.first!["sizes","large","h"].doubleValue))
                expect(tweet.media[0].sizes["large"]?.resize).to(equal(twitterStatus["media"].arrayValue.first!["sizes","large","resize"].stringValue))
                expect(tweet.media[0].sizes["medium"]?.width).to(equal(twitterStatus["media"].arrayValue.first!["sizes","medium","w"].doubleValue))
                expect(tweet.media[0].sizes["medium"]?.height).to(equal(twitterStatus["media"].arrayValue.first!["sizes","medium","h"].doubleValue))
                expect(tweet.media[0].sizes["medium"]?.resize).to(equal(twitterStatus["media"].arrayValue.first!["sizes","medium","resize"].stringValue))
                expect(tweet.media[0].sizes["thumb"]?.width).to(equal(twitterStatus["media"].arrayValue.first!["sizes","thumb","w"].doubleValue))
                expect(tweet.media[0].sizes["thumb"]?.height).to(equal(twitterStatus["media"].arrayValue.first!["sizes","thumb","h"].doubleValue))
                expect(tweet.media[0].sizes["thumb"]?.resize).to(equal(twitterStatus["media"].arrayValue.first!["sizes","thumb","resize"].stringValue))
                expect(tweet.media[0].sizes["small"]?.width).to(equal(twitterStatus["media"].arrayValue.first!["sizes","small","w"].doubleValue))
                expect(tweet.media[0].sizes["small"]?.height).to(equal(twitterStatus["media"].arrayValue.first!["sizes","small","h"].doubleValue))
                expect(tweet.media[0].sizes["small"]?.resize).to(equal(twitterStatus["media"].arrayValue.first!["sizes","small","resize"].stringValue))
            }
        }
    }
}
