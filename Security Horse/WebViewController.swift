//
//  WebViewController.swift
//  LISignIn
//
//  Created by Gabriel Theodoropoulos on 21/12/15.
//  Copyright © 2015 Appcoda. All rights reserved.
//

import UIKit

class WebViewController: UIViewController, UIWebViewDelegate {

    // MARK: IBOutlet Properties
    
    @IBOutlet weak var webView: UIWebView!
    
    var completion : (([String : AnyObject]) -> Void)?
    // MARK: Constants
    
    let linkedInKey = "77bgidx28t0o3p"
    
    let linkedInSecret = "upzjl4EfIS4iLu3j"
    
    let authorizationEndPoint = "https://www.linkedin.com/uas/oauth2/authorization"
    
    let accessTokenEndPoint = "https://www.linkedin.com/uas/oauth2/accessToken"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        webView.delegate = self
        
        
//        if (UserDefaults.standard.object(forKey: "LIAccessToken") != nil) {
//            getProfileInfo()
//        }else{
            startAuthorization()
//        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    // MARK: IBAction Function
    
    
    @IBAction func dismiss(sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
 
    
    // MARK: Custom Functions
    
    func startAuthorization() {
        // Specify the response type which should always be "code".
        let responseType = "code"
        
        // Set the redirect URL. Adding the percent escape characthers is necessary.
        let redirectURL = "https://com.securityhorse.linkedin.oauth/oauth".addingPercentEncoding(withAllowedCharacters: (NSCharacterSet.alphanumerics))
        
        // Create a random string based on the time intervale (it will be in the form linkedin12345679).
        let state = "linkedin\(Int(NSDate().timeIntervalSince1970))"
        
        // Set preferred scope.
        let scope = "r_basicprofile"
        
        
        // Create the authorization URL string.
        var authorizationURL = "\(authorizationEndPoint)?"
        authorizationURL += "response_type=\(responseType)&"
        authorizationURL += "client_id=\(linkedInKey)&"
        authorizationURL += "redirect_uri=\(redirectURL!)&"
        authorizationURL += "state=\(state)&"
        authorizationURL += "scope=\(scope)"
        
        print(authorizationURL)
        
        
        // Create a URL request and load it in the web view.
        let request = NSURLRequest(url: (NSURL(string: authorizationURL) as? URL)!)
        webView.loadRequest(request as URLRequest)
    }
    
    
    func requestForAccessToken(authorizationCode: String) {
        let grantType = "authorization_code"
        
        let redirectURL = "https://com.securityhorse.linkedin.oauth/oauth".addingPercentEncoding(withAllowedCharacters: (NSCharacterSet.alphanumerics))
        
        
        // Set the POST parameters.
        var postParams = "grant_type=\(grantType)&"
        postParams += "code=\(authorizationCode)&"
        postParams += "redirect_uri=\(redirectURL!)&"
        postParams += "client_id=\(linkedInKey)&"
        postParams += "client_secret=\(linkedInSecret)"
        
        // Convert the POST parameters into a NSData object.
        let postData = postParams.data(using: String.Encoding.utf8)
        
        
        // Initialize a mutable URL request object using the access token endpoint URL string.
        let request = NSMutableURLRequest(url: NSURL(string: accessTokenEndPoint)! as URL)
        
        // Indicate that we're about to make a POST request.
        request.httpMethod = "POST"
        
        // Set the HTTP body using the postData object created above.
        request.httpBody = postData
        
        // Add the required HTTP header field.
        request.addValue("application/x-www-form-urlencoded;", forHTTPHeaderField: "Content-Type")
        
        
        // Initialize a NSURLSession object.
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        // Make the request.
        let task: URLSessionDataTask = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            // Get the HTTP status code of the request.
            let statusCode = (response as! HTTPURLResponse).statusCode
            
            if statusCode == 200 {
                // Convert the received JSON data into a dictionary.
                do {
                    if let dataDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : AnyObject]{
                        print(dataDictionary)
                        let accessToken = dataDictionary["access_token"] as? String
                        
                        UserDefaults.standard.set(accessToken, forKey: "LIAccessToken")
                        UserDefaults.standard.synchronize()
                        
                        self.getProfileInfo()
                    }
                    
                }
                catch {
                    print("Could not convert JSON data into a dictionary.")
                }
            }
        }
        
        task.resume()
    }
    
    
    // MARK: UIWebViewDelegate Functions
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        let url = request.url!
        print(url)
        
        if url.host == "com.securityhorse.linkedin.oauth" {
            if url.absoluteString.range(of: "code") != nil {
                // Extract the authorization code.
                let urlParts = url.absoluteString.components(separatedBy: "?")
                let code = urlParts[1].components(separatedBy: "=")[1]
                requestForAccessToken(authorizationCode: code)
            }
            
           
        }
        
        return true
    }
    
    func getProfileInfo() {
//        if let dataDictionary = UserDefaults.standard.object(forKey: "LIAccessToken") as? [String : AnyObject] , let accessToken = dataDictionary["access_token"] as? String{
            if let accessToken = UserDefaults.standard.object(forKey: "LIAccessToken") as? String{
            
            
            
            // Specify the URL string that we'll get the profile info from.
//            let targetURLString = "https://api.linkedin.com/v1/people/~:(public-profile-url)?format=json"
            let targetURLString =
//            "https://api.linkedin.com/v1/people/~?format=json"
            
                 "https://api.linkedin.com/v1/people/~:(id,num-connections,picture-url,industry,positions:(id,title,summary,start-date,end-date,location,is-current,company:(id,name,type,size,industry,ticker)))?format=json"
                
//                "https://api.linkedin.com/v1/people/~:(id,num-connections,picture-url,industry,positions:(id,title,summary,start-date,end-date,is-current,company:(id,name,type,size,industry,ticker)))?format=json"
            
//            "https://api.linkedin.com/v1/people-search:(people:(id,first-name,last-name,headline,picture-url,industry,positions:(id,title,summary,start-date,end-date,is-current,company:(id,name,type,size,industry,ticker)),educations:(id,school-name,field-of-study,start-date,end-date,degree,activities,notes)),num-results)?first-name=parameter&last-name=parameter"
            
            
            // Initialize a mutable URL request object.
            let request = NSMutableURLRequest(url: NSURL(string: targetURLString)! as URL)
            
            // Indicate that this is a GET request.
            request.httpMethod = "GET"
            
            // Add the access token as an HTTP header field.
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            
            
            // Initialize a NSURLSession object.
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            // Make the request.
            let task: URLSessionDataTask = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
                // Get the HTTP status code of the request.
                let statusCode = (response as! HTTPURLResponse).statusCode
                
                if statusCode == 200 {
                    // Convert the received JSON data into a dictionary.
                    do {
                        if let dataDictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String : AnyObject]{
                            let profileURLString = dataDictionary["publicProfileUrl"] as? String
                            print("\(dataDictionary)...... \(profileURLString)")
                            self.completion?(dataDictionary)
                            DispatchQueue.main.async(execute: { () -> Void in
                                self.dismiss(animated: true, completion: nil)
                            })
//                            DispatchQueue.main.async(execute: { () -> Void in
////                                self.btnOpenProfile.setTitle(profileURLString, forState: UIControlState.Normal)
////                                self.btnOpenProfile.hidden = false
//                                
//                            })
                            
                        }
                        
                        
                    }
                    catch {
                        print("Could not convert JSON data into a dictionary.")
                    }
                }
            }
            
            task.resume()
        }
    }
    
}
