//
//  BusinessCell.swift
//  Yelp
//
//  Created by Meenakshi Muthuraman on 7/23/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit
import AFNetworking

class BusinessCell: UITableViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var ratingsImageView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var categoriesLabel: UILabel!
    
    var business: Business!{
        didSet{
            nameLabel.text      = business.name as String!
            distanceLabel.text  = business.distance as String!
            reviewLabel.text    = "\(business.reviewCount!) Reviews"
            addressLabel.text   = business.address as String!
            categoriesLabel.text = business.categories as String!
            ratingsImageView.setImageWithURL(business.ratingImageURL!)
            thumbImageView.setImageWithURL(business.imageURL!)
            
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        thumbImageView.layer.cornerRadius   = 3
        thumbImageView.clipsToBounds        = true
        nameLabel.preferredMaxLayoutWidth   = nameLabel.frame.size.width
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    }

}
