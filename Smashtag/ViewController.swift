//
//  ViewController.swift
//  Smashtag
//
//  Created by Stephen O'Kennedy on 11/12/2016.
//  Copyright © 2016 Stephen O'Kennedy. All rights reserved.
//

import UIKit
import Alamofire

class TweetTableViewController: UITableViewController {

    //    var tweets = [Array<Tweet>](){
    //        didSet {
    //            tableView.reloadData()
    //        }
    //    }

    var searchText:String?{
        didSet{
            //            tweets.removeAll()
            searchForTweets()
            title = searchText
        }
    }

    fileprivate func searchForTweets(){

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        searchText = "#Trinity"

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

}
