//
//  InterviewDetailController.swift
//  TheSetup
//
//  Created by Paolo Tagliani on 24/02/2017.
//  Copyright © 2017 Pablosproject. All rights reserved.
//

import UIKit
import SDWebImage
import SwiftyMarkdown

class InterviewDetailController: UITableViewController, UITextViewDelegate {

	var interview : Interview?
	var completeInterview : CompleteInterview?
	
	@IBOutlet weak var interviewImage: UIImageView!
	@IBOutlet weak var contentTextView: UITextView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.contentTextView.delegate = self
		self.contentTextView.textContainer.heightTracksTextView = true;
		
		self.tableView.estimatedRowHeight = 70
		self.tableView.rowHeight = UITableViewAutomaticDimension
		
		if let interview = self.interview, let slug = interview.slug {
			interviewImage.sd_setImage(with: URL.interviewURL(slug: slug))
		}
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		if let slug = self.interview?.slug {
			NetworkService.interviewDetail(slug: slug, completion: { APIcompleteInterview in
				self.completeInterview = APIcompleteInterview
				self.updateInterview()
			})
		}
	}
	
	//MARK: Public functions
	public func setup(interview: Interview) {
		self.interview = interview
	}
	
	//MARK: private functions
	private func updateInterview() {
		//Extract markdown string
		if let completeInterview = self.completeInterview, let markdown = completeInterview.contents {
			let md = SwiftyMarkdown(string: markdown)
			let attributedString = md.attributedString()
			
			self.contentTextView.attributedText = attributedString
			self.tableView.reloadData()
		}
	}
	
	//MARK: UITextViewDelegate
	
}
