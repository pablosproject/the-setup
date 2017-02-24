//
//  InterviewListCell.swift
//  TheSetup
//
//  Created by Paolo Tagliani on 24/02/2017.
//  Copyright © 2017 Pablosproject. All rights reserved.
//

import UIKit
import SDWebImage

class InterviewListCell: UITableViewCell {
	@IBOutlet weak var interviewImage: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var descriptionLabel: UILabel!
	@IBOutlet weak var dateLabel: UILabel!
	
	public static let identifier : String = "InterviewListCell"
	
    override func awakeFromNib() {
        super.awakeFromNib()
		
		//TODO: setup fonts
    }
	
	func setup(_ interview: Interview) {
		self.titleLabel.text = interview.name
		self.descriptionLabel.text = interview.summary
		
		if let date = interview.date {
			let interviewDate = Date(timeIntervalSince1970: date)
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "MMMM d, yyyy"
			dateLabel.text = "Published \(dateFormatter.string(from: interviewDate))"
		}
		
		if	let slug = interview.slug {
			let imageURL = URL(string:"https://usesthis.com/images/interviews/\(slug)/portrait.jpg")
			interviewImage.sd_setImage(with: imageURL)
		}
	}
}
