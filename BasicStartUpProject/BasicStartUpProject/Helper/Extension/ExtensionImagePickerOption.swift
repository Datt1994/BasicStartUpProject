//
//  ExtensionImagePickerOption.swift

import UIKit
import SystemConfiguration
import MobileCoreServices
import Photos

protocol ChoosePicture {
    func takeAndChoosePhoto(_ allowsEditing : Bool,removeCompletion: ((UIAlertAction) -> Void)?)
    func takeAndChooseVideo(_ allowsEditing : Bool,removeCompletion: ((UIAlertAction) -> Void)?)
    func takePhoto(_ allowsEditing : Bool)
    func takeVideo(_ allowsEditing : Bool)
    func choosePhotoAndVideo(_ allowsEditing : Bool ,isPhoto : Bool,isVideo : Bool)
}

extension ChoosePicture where Self: UIViewController ,Self: UIImagePickerControllerDelegate , Self : UINavigationControllerDelegate {
    func alertPromptToAllowPhotoAccessViaSetting() {
        
        let alert = UIAlertController(title: nil, message: AlertMessage.photoLibraryPermission, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default))
        alert.addAction(UIAlertAction(title: "Settings", style: .cancel) { (alert) -> Void in
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
                UIApplication.shared.openURL(URL(string:UIApplication.openSettingsURLString)!)
            }
        })
        present(alert, animated: true)
    }
    func alertPromptToAllowCameraAccessViaSetting() {
        let alert = UIAlertController(title: nil, message: AlertMessage.cameraPermission, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .default))
        alert.addAction(UIAlertAction(title: "Settings", style: .cancel) { (alert) -> Void in
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
                DispatchQueue.main.async {
                    _ = self.navigationController?.popViewController(animated: true)
                }
            }
            else {
                // Fallback on earlier versions
                UIApplication.shared.openURL(URL(string:UIApplication.openSettingsURLString)!)
                DispatchQueue.main.async {
                    _ = self.navigationController?.popViewController(animated: true)
                }
            }
        })
        present(alert, animated: true)
    }
    
    func takeAndChoosePhoto(_ allowsEditing : Bool = false , removeCompletion: ((UIAlertAction) -> Void)? = nil){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let btnCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {(action: UIAlertAction) -> Void in
            //  UIAlertController will automatically dismiss the view
        })
        let btnTakePhoto = UIAlertAction(title: "Take Photo", style: .default, handler: {(action: UIAlertAction) -> Void in
            self.takePhoto(allowsEditing)
        })
        let btnChooseExisting = UIAlertAction(title: "Choose Photo", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            self.choosePhotoAndVideo(allowsEditing ,isPhoto: true, isVideo: false)
          
        })
        
        
        alert.addAction(btnCancel)
        alert.addAction(btnTakePhoto)
        alert.addAction(btnChooseExisting)
        if (removeCompletion != nil) {
            let btnRemove = UIAlertAction(title: "Remove", style: .default, handler: removeCompletion)
             alert.addAction(btnRemove)
        }
        //alert.view.tintColor = UIColor.black
        present(alert, animated: true)
        //present(alert, animated: true, completion: nil)
    }
    func takeAndChooseVideo(_ allowsEditing : Bool = false, removeCompletion: ((UIAlertAction) -> Void)? = nil){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let btnCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {(action: UIAlertAction) -> Void in
            //  UIAlertController will automatically dismiss the view
        })
        let btnTakePhoto = UIAlertAction(title: "Take Video", style: .default, handler: {(action: UIAlertAction) -> Void in
            self.takeVideo()
        })
        let btnChooseExisting = UIAlertAction(title: "Choose Video", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            
            self.choosePhotoAndVideo(isPhoto: false, isVideo: true)
        })
        
        
        alert.addAction(btnCancel)
        alert.addAction(btnTakePhoto)
        alert.addAction(btnChooseExisting)
        if (removeCompletion != nil) {
            let btnRemove = UIAlertAction(title: "Remove", style: .default, handler: removeCompletion)
            alert.addAction(btnRemove)
        }
        //alert.view.tintColor = UIColor.black
        present(alert, animated: true)
        //present(alert, animated: true, completion: nil)
    }
    func takePhoto(_ allowsEditing : Bool = false) {
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.view.makeToast(AlertMessage.noCamera)
            
        }
        else {
            let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
            switch authStatus {
            case .authorized: let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .camera
            imagePickerController.allowsEditing = allowsEditing
            imagePickerController.delegate = self
            self.present(imagePickerController, animated: true, completion: {() -> Void in
            })
            case .denied: self.alertPromptToAllowCameraAccessViaSetting()
                
            default:
                let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .camera
                imagePickerController.delegate = self
                self.present(imagePickerController, animated: true, completion: {() -> Void in
                })
            }
        }
    }
    func takeVideo(_ allowsEditing : Bool = false) {
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.view.makeToast(AlertMessage.noCamera)
            
        }
        else {
            let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
            switch authStatus {
            case .authorized: let imagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .camera
            imagePickerController.allowsEditing = allowsEditing
            imagePickerController.delegate = self
            self.present(imagePickerController, animated: true, completion: {() -> Void in
            })
            case .denied: self.alertPromptToAllowCameraAccessViaSetting()
                
            default:
                let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .camera
                imagePickerController.mediaTypes = ["public.movie"]
                imagePickerController.delegate = self
                self.present(imagePickerController, animated: true, completion: {() -> Void in
                })
            }
        }
    }
    
    func choosePhotoAndVideo(_ allowsEditing : Bool = false , isPhoto : Bool,isVideo : Bool)  {
        func openImagePickerController() {
            DispatchQueue.main.async {
                let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .photoLibrary
                if isPhoto && isVideo {
                    imagePickerController.mediaTypes = ["public.image","public.movie"]
                } else if isVideo {
                    imagePickerController.mediaTypes = ["public.movie"]
                }
                imagePickerController.delegate = self
                imagePickerController.allowsEditing = allowsEditing
                
                self.present(imagePickerController, animated: true, completion: {() -> Void in
                })
            }
        }
        //  The user tapped on "Choose existing"
        let status = PHPhotoLibrary.authorizationStatus()
        
        if (status == PHAuthorizationStatus.authorized) {
            // Access has been granted.
            openImagePickerController()
        }
        else if (status == PHAuthorizationStatus.denied) {
            self.alertPromptToAllowPhotoAccessViaSetting()
        }
        else if (status == PHAuthorizationStatus.notDetermined) {
            // Access has not been determined.
            PHPhotoLibrary.requestAuthorization({ (newStatus) in
                
                if (newStatus == PHAuthorizationStatus.authorized) {
                    openImagePickerController()
                }
                else {
                    DispatchQueue.main.async {
                        _ = self.navigationController?.popViewController(animated: true)
                    }
                }
            })
        }
        else if (status == PHAuthorizationStatus.restricted) {
            // Restricted access - normally won't happen.
        }
    }
    
}
