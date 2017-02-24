//
//  ServiceProvider.swift
//  TheSetup
//
//  Created by Paolo Tagliani on 24/02/2017.
//  Copyright © 2017 Pablosproject. All rights reserved.
//

import Foundation

//TODO: remove if there's no need for instance type
class ServiceProvider {
	static let sharedInstance = ServiceProvider()
	
	public let networkService = NetworkService()
	
	//Override private init to avoid other call it
	private init () {}
}

