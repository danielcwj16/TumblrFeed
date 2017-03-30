//
//  PhotoCellControllerTableViewCell.swift
//  TumblrFeed
//
//  Created by Weijie Chen on 3/29/17.
//  Copyright © 2017 Weijie Chen. All rights reserved.
//

import UIKit

class PhotoCellControllerTableViewCell: UITableViewCell {
    @IBOutlet weak var cell_image: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell") as! PhotoCellControllerTableViewCell
        
        // Configure YourCustomCell using the outlets that you've defined.
        
        return cell
    }

}
