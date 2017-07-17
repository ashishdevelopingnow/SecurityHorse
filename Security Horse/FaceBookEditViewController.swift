//
//  FaceBookEditViewController.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 29/01/17.
//  Copyright © 2017 Kuldeep Butola. All rights reserved.
//

import UIKit

class FaceBookEditViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tableView : UITableView!
    
    var profileModel =  Profile.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        profileModel.initWithLinkedIn(false)
        let fbActive = profileModel.fillWithProfile((UserDefault.getUserInfo()), isLinkedIn: false) 
        profileModel.isFacebookActivated = fbActive
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0         
        let nib = UINib(nibName: "ProfileEditFacebook2TableViewCell", bundle: nil)
        
        
        tableView.register(nib, forCellReuseIdentifier: "facebookEdit2")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func backButtonTapped(_ sender: UIButton?) {
        if sender?.tag == 1 {
            super.backButtonTapped(sender)
            return
        }
        self.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - UiTableView methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 490
//            return UITableViewAutomaticDimension
//        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let identifier = "facebookEdit2"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as! BaseMyProfileTableViewCell
        cell.selectionStyle = .none
        //        let data = ratingTableData[indexPath.row]
        cell.setData(object: profileModel) { (value , object) in
            if value == .UPLOAD_PHOTO {
                self.pickImageView({ (image) in
                    self.profileModel.facebookProfile.profilePic = image
                    self.tableView.reloadData()
                } , nil)
            }else if value == .FB_TAPPED {
                //                if UserDefault.getUserEmailId() == nil {
                //                    self.performSegue(withIdentifier: "signIn", sender: nil)
                //                }else{
                self.fillWithFaceBook()
                
                //                }
            }
//            else if value == .CONNECT_LINKEDIN {
//                
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
//                self.present(vc, animated: true, completion: {
//                    
//                })
//                vc.completion = { (datstss) in
//                    self.profileModel.fillWithLinkedInArray(data: datstss)
//                    self.tableView.reloadData()
//                }
//                
//                
//                
//            }
//            else if value == .DISCONNECTED_LINKEDIN {
//                
//                
//                self.profileModel.removeFillInWithLinkedIn()
//                self.tableView.reloadData()
//                
//            }
//            else if value == .LINKED_IN_ADD {
//                self.view.endEditing(true)
//                let prof = LinkedInProfile.init()
//                prof.isFromLinkedIn = false
//                self.profileModel.linkedInArray.append(prof)
//                self.tableView.reloadData()
//            }
//            else
//                if value == .UPLOAD_IMAGE_LICENCE {
//                self.pickImageView(nil, { (img) in
//                    
//                    self.showImageCroppingScreen(img)
//                    
//                    
//                    
//                })
//            }
            
            
            
            
        }
    
    
        return cell
    }
    func fillWithFaceBook(){
        FacebookModel.getDataFromFB(self, completed: { (data) in
            self.profileModel.facebookProfile.fillWithFacebook(data)
            self.profileModel.isFacebookActivated = true
            self.tableView.reloadData()
        })
        
    }
    @IBAction func doneBttnTapped (_ sender : UIButton){
        self.view.endEditing(true)
        self.showHudWithMessage("")
        RequestClass.editProfile(userId: UserDefault.getUserId()!, jobprofile: profileModel) { (an, ee, vv) in
            self.hideHud()
            if vv {
//                self.performSegue(withIdentifier: "linkedIn", sender: nil)
            }
        }
    }
    
    @IBAction func finishBttnTapped (_ sender : UIButton) {
        self.view.endEditing(true)
         self.performSegue(withIdentifier: "linkedIn", sender: nil)
//        self.showHudWithMessage("")
//        RequestClass.editProfile(userId: UserDefault.getUserId()!, jobprofile: profileModel) { (an, ee, vv) in
//            self.hideHud()
//            if vv {
//                self.performSegue(withIdentifier: "linkedIn", sender: nil)
//            }
//        }
    }

  
}
