//
//  ViewController.swift
//  TumblrFeed
//
//  Created by Weijie Chen on 3/29/17.
//  Copyright © 2017 Weijie Chen. All rights reserved.
//

import UIKit
import AFNetworking


class PhotosViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate{

    var posts:[NSDictionary] = []
    let refreshcontrol = UIRefreshControl()
    @IBOutlet weak var table: UITableView!

    override func viewDidLoad() {
        
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        table.rowHeight = 240
        
        initializeFeed()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadTumblrFeed(){
        let url = URL(string:"https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")
        let request = URLRequest(url: url!)
        let session = URLSession(
            configuration: URLSessionConfiguration.default,
            delegate:nil,
            delegateQueue:OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(
            with: request as URLRequest,
            completionHandler: { (data, response, error) in
                if let data = data {
                    if let responseDictionary = try! JSONSerialization.jsonObject(
                        with: data, options:[]) as? NSDictionary {
                        //print("responseDictionary: \(responseDictionary)")
                        
                        // Recall there are two fields in the response dictionary, 'meta' and 'response'.
                        // This is how we get the 'response' field
                        let responseFieldDictionary = responseDictionary["response"] as! NSDictionary
                        self.posts.append(contentsOf: responseFieldDictionary["posts"] as! [NSDictionary])
                        self.refreshcontrol.endRefreshing()
                        
                        // This is where you will store the returned array of posts in your posts property
                        // self.feeds = responseFieldDictionary["posts"] as! [NSDictionary]
                        self.table.reloadData()
                    }
                }
        });
        
        task.resume()
    }
    
    func refreshTumblrFeed(){
        table.reloadData()
        loadTumblrFeed()
    }
    
    func initializeFeed(){
        
        refreshcontrol.addTarget(self, action: #selector(refreshTumblrFeed), for: UIControlEvents.valueChanged)
        table.insertSubview(refreshcontrol, at: 0)
        loadTumblrFeed()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell") as! PhotoCellControllerTableViewCell
        
        cell.cell_image.frame = CGRect(x: 0, y: 0, width: table.frame.width, height: table.rowHeight)

        let post = posts[indexPath.row]
        let timestamp = post["timestamp"] as? String
        
        if let photos = post.value(forKeyPath: "photos") as? [NSDictionary]{
            let imageUrlString = photos[0].value(forKeyPath: "original_size.url") as? String
            
            if let imageUrl = URL(string: imageUrlString!) {
                
                cell.cell_image.setImageWith(imageUrl)
                // URL(string: imageUrlString!) is NOT nil, go ahead and unwrap it and assign it to imageUrl and run the code in the curly braces
            } else {
                // URL(string: imageUrlString!) is nil. Good thing we didn't try to unwrap it!
            }
        }else{
            
        }
        
        cell.textLabel?.text = "This is row \(indexPath.row)"
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationViewController = segue.destination as! PhotoDetailsViewController
        
//        let indexPath = table.indexPath(for: sender as! ANy)
//        
//        let selectedcell = table.cellForRow(at: indexPath!) as! PhotoCellControllerTableViewCell
        
        destinationViewController.detailImage = (sender! as! PhotoCellControllerTableViewCell).cell_image.image
    }
}

