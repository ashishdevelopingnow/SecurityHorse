//
//  Jobs.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 06/01/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import ObjectMapper

class Jobs: Mappable {
    /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    public required init?(map: Map) {
        
    }

    var message : String?
    var offset : Int32?
    var jobsArray : [JobsArray]?
    
    func mapping(map: Map) {
        message <- map["status"]
        offset <- map["offset"]
        jobsArray <- map["response.jobs"]
    }
}
class JobsArray : Mappable{
    /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    public required init?(map: Map) {
        
    }

    var companyDetails : CompanyDetails?
    var jobDetails : JobDetails?
    var jobDescription : JobDescription?
    
    func mapping(map: Map) {
        companyDetails <- map["Company"]
        jobDescription <- map["Job"]
        jobDetails <- map["JobDetail"]
        
        
    }
}
class JobDescription : Mappable{
    /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    public required init?(map: Map) {
        
    }

    var job_description : String?
    var job_title : String?
    var created_date_time : String?
    var id : String?// = 0
    var company_id : String?//= 0
    var updated_date_time : String?
    
    var viewed : String?
    var applied : String?
    
    func mapping(map: Map) {
        viewed <- map["viewed"]
        applied <- map["applied"]
        
        job_description <- map["job_description"]
        job_title <- map["job_title"]
        company_id <- map["company_id"]
        
        
        created_date_time <- map["created_date_time"]
        id <- map["id"]
        updated_date_time <- map["updated_date_time"]
        
    }
    
}


class CompanyDetails : Mappable{
    /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    public required init?(map: Map) {
        
    }

    var company_name : String?
    var created_date_time : String?
    var id : Int32 = 0
    var updated_date_time : String?
    var companyImage : String?
    
    func mapping(map: Map) {
        company_name <- map["company_name"]
        
        created_date_time <- map["created_date_time"]
        id <- map["id"]
        updated_date_time <- map["updated_date_time"]
        
        companyImage <- map["CompanyProfile.profile_img"]
        
    }

}
class JobDetails : Mappable{
    /// This function can be used to validate JSON prior to mapping. Return nil to cancel mapping at this point
    
    var job_type : String?
    var hourly_rate , location_name , location_state: String?
    
    
    var max_hourly_rate , min_hourly_rate : String?
//    var id : Int32 = 0
//    var updated_date_time : String?
//    var companyImage : String?
    public required init?(map: Map) {
//        max_hourly_rate = 0
//        min_hourly_rate = 0
    }

    func mapping(map: Map) {

        job_type <- map["job_type"]
        
        hourly_rate <- map["hourly_rate"]
        
        location_name <- map["location_name"]
        location_state <- map["location_state"]
        
//        let abc = map["max_hourly_rate"] as AnyObject?
//        let abcd = map["min_hourly_rate"] as AnyObject?
        max_hourly_rate <- map["max_hourly_rate"]
        min_hourly_rate <- map["min_hourly_rate"]
//        id <- map["id"]
//        updated_date_time <- map["updated_date_time"]
//        
//        companyImage <- map["CompanyProfile.profile_img"]
        
    }
}

