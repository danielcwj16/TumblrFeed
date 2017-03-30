//
//  PhotoDetailsViewController.swift
//  TumblrFeed
//
//  Created by Weijie Chen on 3/30/17.
//  Copyright © 2017 Weijie Chen. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {

    @IBOutlet weak var photodetail_image: UIImageView!
    var detailImage : UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        photodetail_image.image = detailImage
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
