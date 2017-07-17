//
//  BaseViewController.swift
//  Security Horse
//
//  Created by Kuldeep Butola on 25/12/16.
//  Copyright © 2016 Kuldeep Butola. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController , UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    var HUD : MBProgressHUD?

    var pickImage : ((_ image : String?)->Void)?
    
    var pickImg : ((_ image : UIImage?)->Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonTapped(_ sender : UIButton?){
       _ = navigationController?.popViewController(animated: true)
    }
    
    func showHudWithMessage(_ message : String){
        HUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        HUD?.label.text = Utils.check(forEmpty: message) == true ? "Please Wait" : message
    }
    func hideHud () {
        HUD?.hide(animated: true)
    }

    func addRefreshViewInTable(_ tableView : UITableView){
        let refreshController = UIRefreshControl()
//        UIControlEventValueChanged
        refreshController.addTarget(self, action: #selector(BaseViewController.refreshTable(_:)), for: .valueChanged)
        tableView.addSubview(refreshController)
    }
    //MARK: override methods
    func refreshTable(_ sender : UIRefreshControl){
        
    }
    
//    #pragma mark - OverRide Methods

    func pickImageView(_ callback : ((_ imagePicker : String?)->Void)? , _  callbackImage : ((_ imagePicker : UIImage?)->Void)?){
        
        pickImg = callbackImage
        pickImage = callback
        
//        var array = []()
        let alertController = UIAlertController.init(title: "", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let action = UIAlertAction.init(title: "Camera", style: UIAlertActionStyle.default, handler: { (act) in
                self.openCamera()
                
            })
            
            alertController.addAction(action)
        }
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let action = UIAlertAction.init(title: "Gallery", style: UIAlertActionStyle.default, handler: { (act) in
                self.openImageGallery()
            })
            alertController.addAction(action)
        }
    
        let action = UIAlertAction.init(title: "Cancel", style: UIAlertActionStyle.destructive, handler: { (act) in
            
        })
        alertController.addAction(action)
        
        present(alertController, animated: true, completion: nil)
        
    }
    private func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            if UIImagePickerController.isCameraDeviceAvailable(.rear) {
                imagePicker.cameraDevice = .rear
            }
            
            imagePicker.allowsEditing = pickImg != nil ? false : true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    private func openImageGallery(){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = pickImg != nil ? false : true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            if self.pickImage != nil {
                self.requestToUploadProfilePic(image)
            }
            
            picker.dismiss(animated: true, completion: nil)
            //                self.pickImg?(image)
            
        }else if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //                if self.pickImage != nil {
            //                    self.requestToUploadProfilePic(image)
            //                }
            
            
            let viewCnt = self.storyboard?.instantiateViewController(withIdentifier: "CropImageViewController") as? CropImageViewController
            viewCnt?.image = image
            
            viewCnt?.callBack = { (_,objjjj) in
                picker.dismiss(animated: true, completion: {
                    
                    self.pickImg?(objjjj as? UIImage)
                })
                
            }
            
            
            picker.pushViewController((viewCnt)!, animated: true)
            
        }
        
        
        
    }
    
    
    
    func requestToUploadProfilePic(_ image : UIImage){
        if let userId = UserDefault.getUserId() {
        
            RequestClass.uploadProfilePic(userId, image: image, result: { (obj, err, success) in
                if success == true {
                    self.pickImage?(obj as? String)
                }else{
                    
                }
            })
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
