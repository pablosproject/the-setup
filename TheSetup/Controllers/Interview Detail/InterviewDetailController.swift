//
//  InterviewDetailController.swift
//  TheSetup
//
//  Created by Paolo Tagliani on 24/02/2017.
//  Copyright © 2017 Pablosproject. All rights reserved.
//

import UIKit
import SDWebImage
import MarkdownKit

class InterviewDetailController: UITableViewController, UITextViewDelegate {

    var interview: Interview?
    var completeInterview: CompleteInterview?
    let calculationView: UITextView = UITextView()

    @IBOutlet weak var interviewImage: UIImageView!
    @IBOutlet weak var interviewTitle: UILabel!
    @IBOutlet weak var interviewDescription: UILabel!
    @IBOutlet weak var interviewDate: UILabel!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    @IBOutlet weak var contentTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.tableFooterView = UIView()

        self.contentTextView.delegate = self
        self.contentTextView.alpha = 0

        self.tableView.estimatedRowHeight = 70
        self.tableView.rowHeight = UITableViewAutomaticDimension

        if let interview = self.interview, let slug = interview.slug {
            interviewImage.sd_setImage(with: URL.interviewURL(slug: slug))
            interviewTitle.text = self.interview?.name
            interviewDescription.text = self.interview?.summary
            let formatter = Date.ts_dateFormatter()
            interviewDate.text = formatter.string(from: Date(timeIntervalSince1970: interview.date!))
        }
    }

    //MARK: View lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.activityView.startAnimating()

        if let slug = self.interview?.slug {
            NetworkService.interviewDetail(slug: slug, completion: { APIcompleteInterview in
                self.completeInterview = APIcompleteInterview
                self.activityView.stopAnimating()
                self.updateInterview()
            })
        }
    }

    //MARK: UITableViewDelegate
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 1) {
            calculationView.attributedText = contentTextView.attributedText
            let size = calculationView.sizeThatFits(CGSize(width: contentTextView.frame.width, height: CGFloat(FLT_MAX)))
            return size.height
        }
        return UITableViewAutomaticDimension
    }

    //MARK: Public functions
    public func setup(interview: Interview) {
        self.interview = interview
    }

    //MARK: private functions
    private func updateInterview() {
        //Extract markdown string
        if let completeInterview = self.completeInterview, let markdown = completeInterview.contents {
			let markdownParser = MarkdownParser(font: TextStyle.interviewBody.font())
			

//			md.body.fontName = TextStyle.interviewBody.font().fontName
//			md.body.color = TextStyle.interviewBody.color()
//			
//			md.h4.fontName = TextStyle.interviewH4.font().fontName
//			md.h4.color = TextStyle.interviewH4.color()
			
            let attributedString = markdownParser.parse(markdown)

            self.contentTextView.attributedText = attributedString
            self.tableView.reloadData()
            //Animate appearence of content text view
            UIView.animate(withDuration: 0.25, animations: {
                self.contentTextView.alpha = 1
            })

        }
    }

}
