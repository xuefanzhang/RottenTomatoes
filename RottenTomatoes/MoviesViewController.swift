//
//  MoviesViewController.swift
//  RottenTomatoes
//
//  Created by Xuefan Zhang on 9/20/15.
//  Copyright © 2015 Xuefan Zhang. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var movies: [NSDictionary]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = NSURL(string: "https://gist.githubusercontent.com/timothy1ee/d1778ca5b944ed974db0/raw/489d812c7ceeec0ac15ab77bf7c47849f2d1eb2b/gistfile1.json")!
        
        
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(
            
            NSURLRequest(URL: url),
            
            completionHandler: {
                
                (data, response, error) -> Void in
                
                if let data = data {
                    
                    // Sending the results back to main queue to update UI using the fetched data
                    
                    dispatch_async(dispatch_get_main_queue()) {
                        
                        do {
                            
                            if let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0)) as? NSDictionary {
                                
                                // extract movies from JSON here and assign it to class variable
                                
                                self.movies = json["movies"] as? [NSDictionary]
                                
                                self.tableView.reloadData()
                                
                            }
                            
                            
                            
                        } catch {
                            
                            print("Could not unwrap JSON. DOH!")
                            
                        }
                        
                    }
                    
                    
                    
                } else if let error = error {
                    
                    print(error.description)
                    
                }
                
        })
        
        task.resume()
        tableView.dataSource = self
        tableView.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let movies = movies {
            
            return movies.count
            
        } else {
            
            return 0
            
        }
        
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell

        let movie = movies![indexPath.row]
        
        cell.titleLabel.text = movie["title"] as? String
        
        cell.synopsisLabel.text = movie["synopsis"] as? String
        
        let url = NSURL(string: movie.valueForKeyPath("posters.thumbnail") as! String)!
        cell.posterView.setImageWithURL(url)
        
        return cell
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
