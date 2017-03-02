//
//  APIManager.swift
//  CaliforniaPrototype
//
//  Created by Luis Garcia on 2/28/17.
//  Copyright © 2017 HOTB. All rights reserved.
//

import Foundation

public typealias AnySuccessBlock = (_ response: [String: Any?]) -> Void
public typealias FailureBlock = (_ error: Error?) -> Void
public typealias UserSuccessBlock = (_ response: User?) -> Void

class APIManager {
    
    static let sharedInstance = APIManager()
    
    let usersBaseURL = "http://ec2-54-241-144-61.us-west-1.compute.amazonaws.com/users"
    let locationsBaseURL = "ec2-54-241-144-61.us-west-1.compute.amazonaws.com/locations"
    
    let defaultHeaders = ["Content-Type": "application/json", "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNThhZGJmZjMzNmIxM2Y0ZWRjMzhlZWVlIiwiaWF0IjoxNDg3ODI1ODY4fQ.g1DUIvQk20gLCwwuGueiMUq3o_XSYmXZ0aD_jMs1o1k"]
    
    //MARK: - User related API methods
    func getUserWithPhone(number numberString: String, success: @escaping UserSuccessBlock, failure: @escaping FailureBlock) {
        let url = usersBaseURL + "/phone/\(numberString)"
        
        NetworkOperations().performWebRequest(url: url, httpMethod: "GET", httpBody: nil, httpHeaders: defaultHeaders) { (response, error) in
            if error != nil {
                failure(error)
            } else {
                guard let json = response as? [String : Any] else { return }
                success(User.userFromJson(json))
            }
        }
    }
    
    func getUserWithEmail(email emailString: String, success: @escaping UserSuccessBlock, failure: @escaping FailureBlock) {
        let url = usersBaseURL + "/email/\(emailString)"
        
        NetworkOperations().performWebRequest(url: url, httpMethod: "GET", httpBody: nil, httpHeaders: defaultHeaders) { (response, error) in
            if error != nil {
                failure(error)
            } else {
                guard let json = response as? [String: Any] else { return }
                success(User.userFromJson(json))
            }
        }
    }
    
    func getUserWithId(id idString: String, success: @escaping UserSuccessBlock, failure: @escaping FailureBlock) {
        let url = usersBaseURL + "/\(idString)"
        
        NetworkOperations().performWebRequest(url: url, httpMethod: "GET", httpBody: nil, httpHeaders: defaultHeaders) { (response, error) in
            if error != nil {
                failure(error)
            } else  {
                guard let json = response as? [String: Any] else { return }
                success(User.userFromJson(json))
            }
        }
    }
    
    //MARK: - Register User
    func registerUserWith(email emailString: String?, password: String?, name: String?, phone: String?, address: String?, city: String?, state: String?, zip: String?, success: @escaping UserSuccessBlock, failure: @escaping FailureBlock) {
        let url = usersBaseURL
        let header = ["Content-Type": "application/json"]
        let body = ["email": emailString,
                    "password": password,
                    "name": name,
                    "phone": phone,
                    "address": address,
                    "city": city,
                    "state": state,
                    "zip": zip]
        NetworkOperations().performWebRequest(url: url, httpMethod: "POST", httpBody: body, httpHeaders: header) { (response, error) in
            if error != nil {
                failure(error)
            } else {
                guard let json = response as? [String: Any] else { return }
                success(User.userFromJson(json))
            }
        }
    }
    
    func registerUserWithPhone(number numberString: String, success: @escaping AnySuccessBlock, failure: @escaping FailureBlock) {
        let url = usersBaseURL + "/phoneCode"
        let body = ["phone": numberString]
        NetworkOperations().performWebRequest(url: url, httpMethod: "POST", httpBody: body, httpHeaders: defaultHeaders) { (response, error) in
            if error != nil {
                failure(error)
            } else {
                success(["registered":"success"])
            }
        }
    }
    
    //MARK: - Sign in API methods
    func signInWithEmail(email emailString: String, password pwd: String, success: @escaping AnySuccessBlock, failure: @escaping FailureBlock) {
        let url = usersBaseURL + "/signin"
        let header = ["Content-Type": "application/json"]
        let body = ["email": emailString, "password": pwd]
        
        NetworkOperations().performWebRequest(url: url, httpMethod: "POST", httpBody: body, httpHeaders: header) { (response, error) in
            if error != nil {
                print(error!)
                failure(error)
            } else {
                guard let json = response as? [String: Any] else { return }
                success(json)
            }
        }
    }
    
    func signInWithPhone(number numberString: String, password pwd: String, success: @escaping AnySuccessBlock, failure: @escaping FailureBlock) {
        let url = usersBaseURL + "/phoneSignin"
        let header = ["Content-Type": "application/json"]
        let body = ["phone": numberString, "password": pwd]
        
        NetworkOperations().performWebRequest(url: url, httpMethod: "POST", httpBody: body, httpHeaders: header) { (response, error) in
            if error != nil {
                print(error!)
                failure(error)
            } else  {
                guard let json = response as? [String: Any] else { return }
                success(json)
            }
        }
    }
    
    func phoneVerification(_ phoneNumber: String, success: @escaping AnySuccessBlock, failure: @escaping FailureBlock) {
        let url = usersBaseURL + "/phoneCode"
        let body = ["phone": phoneNumber]
        
        NetworkOperations().performWebRequest(url: url, httpMethod: "POST", httpBody: body, httpHeaders: defaultHeaders) { (response, error) in
            if error != nil {
                failure(error)
            } else {
                //guard let json = response as? [String: Any] else { return }
                success([:])
            }
        }
    }
    
    //MARK: - Edit user
    func updateUser(name nameString: String?, email emailString: String?, phone phoneString: String?, success: @escaping AnySuccessBlock, failure: @escaping FailureBlock) {
        let url = usersBaseURL + "/58b4db4ddf1d2c0015734b42"
        let body = ["name": nameString, "email": emailString, "phone": phoneString]
        
        NetworkOperations().performWebRequest(url: url, httpMethod: "PUT", httpBody: body, httpHeaders: defaultHeaders) { (response, error) in
            if error != nil {
                failure(error)
            } else {
                guard let json = response as? [String: Any] else { return }
                success(json)
            }
        }
    }
    
    func resetPassword(email emailString: String, password pwdString: String, success: @escaping AnySuccessBlock, failure: @escaping FailureBlock) {
        let url = usersBaseURL + "/resetPassword"
        let body = ["email": emailString, "password": pwdString]
        
        NetworkOperations().performWebRequest(url: url, httpMethod: "POST", httpBody: body, httpHeaders: defaultHeaders) { (response, error) in
            if error != nil {
                failure(error)
            } else {
                guard let json = response as? [String: Any] else { return }
                success(json)
            }
        }
    }
    
    func changePassword(id idString: String, password: String, success: @escaping AnySuccessBlock, failure: @escaping FailureBlock) {
        let url = usersBaseURL + "/changePassword"
        let body = ["id": idString, "password": password]
        
        NetworkOperations().performWebRequest(url: url, httpMethod: "POST", httpBody: body, httpHeaders: defaultHeaders) { (response, error) in
            if error != nil {
                failure(error)
            } else {
                guard let json = response as? [String: Any] else { return }
                success(json)
            }
        }
    }
    
    //MARK: - Location related methods
    func addLocation(displayName name: String, coordinates: [String: Double], alertRadius: String, enablePushNotifications: Bool, enableSMS: Bool, enableEmail: Bool, success: @escaping AnySuccessBlock, failure: @escaping FailureBlock) {
        let userId = Keychain.get(key: "id") as! String
        let url = usersBaseURL + "/\(userId)" + "/locations"
        let lat = coordinates["lat"]! as Double
        let lng = coordinates["lng"]! as Double
        let coords : [String: Double] = ["lat": lat, "lng": lng]
        let body : [String: Any] = ["displayName": name,
                    "coordinates": coords,
                    "alertRadius": alertRadius,
                    "enablePushNotifications": enablePushNotifications,
                    "enableSMS": enableSMS,
                    "enableEmail": enableEmail]
        
        NetworkOperations().performWebRequest(url: url, httpMethod: "PUT", httpBody: body, httpHeaders: defaultHeaders) { (response, error) in
            if error != nil {
                failure(error)
            } else {
                guard let json = response as? [String: Any] else { return }
                success(json)
            }
        }
    }
    
    func updateLocation(displayName name: String, coordinates: [String: Double], alertRadius: String, enablePushNotifications: Bool, enableSMS: Bool, enableEmail: Bool, locationId: String, success: @escaping AnySuccessBlock, failure: @escaping FailureBlock) {
        let url = usersBaseURL + "/58b4db4ddf1d2c0015734b42" + "/locations" + "/\(locationId)"
        let lat = coordinates["lat"]! as Double
        let lng = coordinates["lng"]! as Double
        let coords : [String: Double] = ["lat": lat, "lng": lng]
        let body : [String: Any] = ["displayName": name,
                                    "coordinates": coords,
                                    "alertRadius": alertRadius,
                                    "enablePushNotifications": enablePushNotifications,
                                    "enableSMS": enableSMS,
                                    "enableEmail": enableEmail]
        
        NetworkOperations().performWebRequest(url: url, httpMethod: "PUT", httpBody: body, httpHeaders: defaultHeaders) { (response, error) in
            if error != nil {
                failure(error)
            } else {
                guard let json = response as? [String: Any] else { return }
                success(json)
            }
        }
    }
    
}





