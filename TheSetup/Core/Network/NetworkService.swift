//
//  NetworkService.swift
//  TheSetup
//
//  Created by Paolo Tagliani on 17/02/2017.
//  Copyright © 2017 Pablosproject. All rights reserved.
//

import Alamofire
import ObjectMapper

enum Router: URLRequestConvertible {
	case interviewList
	case interviewDetail(slug: String)
	
	static let baseURLString = "https://usesthis.com/api/"
	
	var method : HTTPMethod {
		return .get //!!!: All requests are get
	}
	
	var path : String {
		switch self {
		case .interviewList:
			return "interviews"
		case .interviewDetail(let slug):
			return "interviews/\(slug)"
		}
	}
	
	//MARK: URLRequestConvertible
	func asURLRequest() throws -> URLRequest {
		let URL = try Router.baseURLString.asURL()
		
		var urlRequest = URLRequest(url: URL.appendingPathComponent(path))
		urlRequest.httpMethod = method.rawValue
		
		return urlRequest
	}
}

class NetworkService {
	
	//TODO: error management
	public class func interviewList (completion: @escaping ([Interview]?) -> Void) -> Void {
		Alamofire.request(Router.interviewList).responseJSON { response in
			
			var interviews : [Interview]?
			if let json = response.result.value as? NSDictionary {
				let interviewJSON = json["interviews"]  //TODO: typechecking here
				interviews = Mapper<Interview>().mapArray(JSONArray: interviewJSON as! [[String : Any]])
			}
			
			completion(interviews)
		}
	}
	
}
