//
//  MovieDetailsViewController.swift
//  RottenTomatoes
//
//  Created by Xuefan Zhang on 9/20/15.
//  Copyright © 2015 Xuefan Zhang. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var synopsisLabel: UILabel!
    
    var movie: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var urlString = movie.valueForKeyPath("posters.thumbnail") as! String
        let url = NSURL(string: urlString)!
        
        var lowResImageView: UIImageView = UIImageView()
        lowResImageView.setImageWithURL(url)
        
        var range = urlString.rangeOfString(".*cloudfront.net/", options: .RegularExpressionSearch)
        if let range = range {
            urlString = urlString.stringByReplacingCharactersInRange(range, withString: "https://content6.flixster.com/")
        }
        
        imageView.setImageWithURL(NSURL(string: urlString)!, placeholderImage: lowResImageView.image)
        
        //imageView.setImageWithURL(url)
        
        titleLabel.text = movie["title"] as? String
        synopsisLabel.text = movie["synopsis"] as? String
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
