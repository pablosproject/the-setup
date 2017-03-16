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
		
		self.titleLabel.font = TextStyle.interviewListTitle.font()
		self.descriptionLabel.font = TextStyle.interviewListDetail.font()
		self.dateLabel.font = TextStyle.interviewListDate.font()

		self.titleLabel.textColor = TextStyle.interviewListTitle.color()
		self.descriptionLabel.textColor = TextStyle.interviewListDetail.color()
		self.dateLabel.textColor = TextStyle.interviewListDate.color()
    }
	
	override func prepareForReuse() {
		interviewImage.sd_cancelCurrentImageLoad()
	}
	
	func setup(_ interview: Interview) {
		self.titleLabel.text = interview.name
		self.descriptionLabel.text = interview.summary
		
		if let date = interview.date {
			let interviewDate = Date(timeIntervalSince1970: date)
			let dateFormatter = Date.ts_dateFormatter()
			dateLabel.text = "Published \(dateFormatter.string(from: interviewDate))"
		}
		
		if	let slug = interview.slug {
			let imageURL = URL.interviewURL(slug: slug)
			interviewImage.sd_setImage(with: imageURL)
		}
	}
}
