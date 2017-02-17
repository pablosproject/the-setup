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
    case categoryList
    case categoryDeatail(slug: String)
    case hardwareList
    case hardwareDetail(slug: String)
    case softwareList
    case softwareDetail(slug: String)
    case generalInfo
    case hardwareInfo
    case softwareInfo

    static let baseURLString = "https://usesthis.com/api/"

    var method: HTTPMethod {
        return .get //!!!: All requests are get
    }

    var path: String {
        switch self {
        case .interviewList:
            return "interviews"
        case .interviewDetail(let slug):
            return "interviews/\(slug)"
        case .categoryList:
            return "categories"
        case .categoryDeatail(let slug):
            return "categories/\(slug)"
        case .hardwareList:
            return "hardware"
        case .hardwareDetail(let slug):
            return "hardware/\(slug)"
        case .softwareList:
            return "software"
        case .softwareDetail(let slug):
            return "software/\(slug)"
        case .generalInfo:
            return "stats"
        case .hardwareInfo:
            return "stats/hardware"
        case .softwareInfo:
            return "stats/software"
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

//TODO: refactor main method for gettin JSON

class NetworkService {

    //TODO: error management
    public class func interviewList(completion: @escaping ([Interview]?) -> Void) {
        Alamofire.request(Router.interviewList).responseJSON { response in
                    var interviews: [Interview]?

                    if let json = response.result.value as? NSDictionary {
                        let interviewJSON = json["interviews"]
                        if let interviewJSON: [[String: Any]] = interviewJSON as! [[String: Any]]? {
                            interviews = Mapper<Interview>().mapArray(JSONArray: interviewJSON)
                        }
                    }

                    completion(interviews)
                }
    }

    //TODO: error management
    public class func interviewDetail(slug: String, completion: @escaping (CompleteInterview?) -> Void) {
        Alamofire.request(Router.interviewDetail(slug: slug)).responseJSON { response in

                    var interview: CompleteInterview?
                    if let json = response.result.value as? NSDictionary {
                        let interviewJSON = json["interview"]
                        if let interviewJSON: [String: Any] = interviewJSON as! [String: Any]? {
                            interview = CompleteInterview(JSON: interviewJSON)
                        }
                    }

                    completion(interview)
                }
    }

    public class func categoriesList(completion: @escaping ([String]?) -> Void) {
        Alamofire.request(Router.categoryList).responseJSON { response in

                    var categories: [String]?
                    if let json = response.result.value as? [String: Any] {
                        categories = json["categories"] as! [String]?
                    }

                    completion(categories)
                }
    }

    public class func categoryDetail(slug: String, completion: @escaping ([Interview]?) -> Void) {
        Alamofire.request(Router.categoryDeatail(slug: slug)).responseJSON { response in

                    var interviews: [Interview]?
                    if let json = response.result.value as? NSDictionary {
                        let interviewJSON = json["interviews"]
                        if let interviewJSON: [[String: Any]] = interviewJSON as! [[String: Any]]? {
                            interviews = Mapper<Interview>().mapArray(JSONArray: interviewJSON)
                        }
                    }

                    completion(interviews)
                }
    }

    public class func gearList(gearType: gearType, completion: @escaping ([Gear]?) -> Void) {
        let request = gearType == .hardware ? Router.hardwareList : Router.softwareList
        Alamofire.request(request).responseJSON { response in

                    var gears: [Gear]?
                    if let json = response.result.value as? NSDictionary {
                        let gearJson = json["gear"]
                        if let gearJson: [[String: Any]] = gearJson as! [[String: Any]]? {
                            gears = Mapper<Gear>().mapArray(JSONArray: gearJson)
                            gears?.forEach({ gear in
                                gear.gearType = gearType
                            })
                        }
                    }

                    completion(gears)
                }
    }

    public class func gearDetail(gearType: gearType, slug: String, completion: @escaping (Gear?) -> Void) {
        let request = gearType == .hardware ? Router.hardwareDetail(slug: slug) : Router.softwareDetail(slug: slug)
        Alamofire.request(request).responseJSON { response in

                    var gear: Gear?
                    if let json = response.result.value as? NSDictionary {
                        let gearJson = json["gear"]
                        if let gearJson: [String: Any] = gearJson as! [String: Any]? {
                            gear = Gear(JSON: gearJson)
                            gear?.gearType = gearType
                        }
                    }

                    completion(gear)
                }
    }

    public class func info(completion: @escaping (_ interview: Int?, _ hardware: Int?, _ software: Int?) -> Void) {
        Alamofire.request(Router.generalInfo).responseJSON { response in
                    var interview: Int?
                    var hardware: Int?
                    var software: Int?
                    if let json = response.result.value as? [String: Int] {
                        interview = json["interviews"]
                        hardware = json["hardware"]
                        software = json["software"]
                    }

                    completion(interview, hardware, software)
                }
    }

    public class func ranking(gearType: gearType, completion: @escaping ([RankingGear]?) -> Void) {
        let request = gearType == .hardware ? Router.hardwareInfo : Router.softwareInfo
        Alamofire.request(request).responseJSON { response in

                    var gears: [RankingGear]?
                    if let json = response.result.value as? NSDictionary {
                        let gearJson = json["gear"]
                        if let gearJson: [[String: Any]] = gearJson as! [[String: Any]]? {
                            gears = Mapper<RankingGear>().mapArray(JSONArray: gearJson)
                        }
                    }

                    completion(gears)
                }
    }
}
