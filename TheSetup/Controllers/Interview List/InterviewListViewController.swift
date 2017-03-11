//
//  InterviewListViewController.swift
//  TheSetup
//
//  Created by Paolo Tagliani on 24/02/2017.
//  Copyright © 2017 Pablosproject. All rights reserved.
//

import UIKit
import APESuperHUD

class InterviewListViewController: UITableViewController {

	private var interviews:[Interview] = []
	private let networkService:NetworkService = ServiceProvider.sharedInstance.networkService
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.tableView.estimatedRowHeight = 400
		self.tableView.rowHeight = UITableViewAutomaticDimension
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		
		//TODO: put the loader only if the loading takes more than 1 sec
		APESuperHUD.showOrUpdateHUD(loadingIndicator: .standard, messages: [], presentingView: self.view)
		
		NetworkService.interviewList { APIInterviews in
			APESuperHUD.removeHUD(animated: true, presentingView: self.view, completion: nil)
			if let interviews = APIInterviews {
				self.interviews = interviews
				self.tableView.reloadData()
			}
		}
    }

	//MARK: UITableViewDataSource methods
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return interviews.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell : InterviewListCell = tableView.dequeueReusableCell(withIdentifier: InterviewListCell.identifier, for: indexPath) as! InterviewListCell
		
		let interview = interviews[indexPath.row]
		cell.setup(interview)
		
		return cell
	}
	
	//MARK: Storyboard management
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "interviewList.to.InterviewDetail" {
			let interviewDetailController = segue.destination as! InterviewDetailController
			if let selectedIndex = self.tableView.indexPathForSelectedRow
			{
				interviewDetailController.setup(interview:interviews[(selectedIndex.row)])
			}
		}
	}
	
}
