//
//  Constants.swift
//  GameFramework
//
//  Created by apple on 1/16/15.
//  Copyright (c) 2015 apple. All rights reserved.
//

import Foundation

struct GlobalVariables {


    static let globalUserDefaults = NSUserDefaults.standardUserDefaults()

    static let blue_color = "#4AB3EF"
    static let green_color = "#349840"
    static let yellow_color = "#DF9100"

    //User defuals keys
    static let user_defaults_app_iteration_number_key = "app_iteration_number"
    static let user_defaults_app_purchased_flag_key = "is_app_purchased"
    static let user_defaults_level_objects_array_key = "level_objects_array"
    static let user_defaults_current_level_key = "current_level"
    static let user_defaults_category_id_key = "category_id"
    static let user_defaults_budget_id_key = "budget_id"
    static let user_defaults_match_id_key = "match_id"
    static let user_defaults_tournment_id_key = "tournment_id"
    static let user_defaults_location_id_key = "location_id"
    static let user_defaults_remember_me_key = "remember_me"
    static let user_defaults_signed_in_key = "signedin"
    static let user_defaults_username_key = "username"
    static let user_defaults_password_key = "password"
    static let user_defaults_from_month_key = "fromMonth"
    static let user_defaults_to_month_key = "toMonth"
    static let user_defaults_from_year_key = "fromYear"
    static let user_defaults_to_year_key = "toYear"
    static let user_defaults_session_id_key = "session_id"
   
    
    
    //Service calls values
    static let request_url = "https://api.parse.com/1/functions/"

    static let x_parse_application_id_key = "X-Parse-Application-Id"
    static let x_parse_application_id_value = "ORY7BYT28z07dlH1rdlZoJyL2PUOiszHBItyMVSb"
    
    static let x_parse_rest_api_key = "X-Parse-REST-API-Key"
    static let x_parse_rest_api_value = "ZvJyc70WKYorqXsJ4DYE649JwPKJ5YEL6TilZfn5"

    static let request_content_type_key = "Content-Type"
    static let request_content_type_value = "application/json"
    
    static let request_content_length_key = "Content-Length"

    static let request_type_value = "POST"
    
   
    enum RequestAPIMethods : NSString{
        
        case Login = "Login"
        case RegisterDevice = "RegisterDevice"
        case ForgotPassword = "ForgotPassword"
        case Logout = "Logout"
        case ChangePassword = "ChangePassword"
        case GetProfile = "GetProfile"
        case GetWebsiteVisits = "GetWebsiteVisits"
        case GetRevenue = "GetRevenue"
        case GetActiveProjects = "GetActiveProjects"

    }
  
}

