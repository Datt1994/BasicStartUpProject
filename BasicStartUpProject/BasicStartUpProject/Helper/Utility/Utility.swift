//
//  Utility.swift


import UIKit
import Photos
import SystemConfiguration



//import MBProgressHUD

let ScreenWidth = UIScreen.main.bounds.width
var hud:MBProgressHUD = MBProgressHUD()

struct Utility {

    /// MARK: - MBProgress Indicator Methods
    func showLoader() {
        DispatchQueue.main.async {
            hud.removeFromSuperview()
//            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            hud = MBProgressHUD.showAdded(to: UIApplication.shared.windows.first!, animated: true)
//            hud.dimBackground = true
//            hud.color = .themeSelectedRed()
//             Constants.keyWindow?.addSubview(hud)
            hud.mode = .indeterminate
        }
    }

    func hideLoader() {
        DispatchQueue.main.async {
//            if UIApplication.shared.isNetworkActivityIndicatorVisible {
//                UIApplication.shared.isNetworkActivityIndicatorVisible = false
//            }
            hud.removeFromSuperview()
        }
    }
//    func setUpSideMenu() {
//        
//        var objSlideMenuVC = UIViewController()
//        SideMenuManager.default.menuShadowOpacity = 0
//        SideMenuManager.default.menuAnimationFadeStrength = 0
//        SideMenuManager.default.menuPushStyle = .popWhenPossible
//        SideMenuManager.default.menuPresentMode = .menuSlideIn
//        SideMenuManager.default.menuWidth = UIScreen.main.bounds.width
//        SideMenuManager.default.menuAlwaysAnimate = true
//        objSlideMenuVC = SidemenuVC.instantiate()
//        let navSlideMenuVC = UISideMenuNavigationController(rootViewController: objSlideMenuVC)
//        navSlideMenuVC.isNavigationBarHidden = true
//        SideMenuManager.default.menuRightNavigationController = navSlideMenuVC as UISideMenuNavigationController?
//        
//    }


    //MARK: - Check Null or Nil Object
    
    func isObjectNotNil(object:AnyObject!) -> Bool
    {
        if let _:AnyObject = object
        {
            return true
        }
        
        return false
    }
    /* Description: This function generate alert dialog for empty message by passing message and
     associated viewcontroller for that function
     - Parameters:
     - message: message that require for  empty alert message
     - tbl: UITableView
     */
    static func tblEmptyMessageWithArr<T>(_ message:String = "No Result Found." , arr : Array<T>, tbl:UITableView , separatorStyle : UITableViewCell.SeparatorStyle = .none) -> Int {
        if arr.count > 0 {
            tbl.backgroundView = nil
            tbl.separatorStyle = separatorStyle
            return 1
        }
        
        let rect = CGRect(x: 0,
                          y: 0,
                          width: tbl.bounds.size.width,
                          height: tbl.bounds.size.height)
        let noDataLabel: UILabel = UILabel(frame: rect)
        
        noDataLabel.text = message
        noDataLabel.textColor = .darkGray
        noDataLabel.textAlignment = NSTextAlignment.center
        tbl.backgroundView = noDataLabel
        tbl.separatorStyle = separatorStyle
        return 0
    }
    static func cvEmptyMessageWithArr<T>(_ message:String = "No Result Found." , arr : Array<T>, cv:UICollectionView ,textAlignment:NSTextAlignment  = .center) -> Int {
        if arr.count > 0 {
            cv.backgroundView = nil
            return 1
        }
        
        let rect = CGRect(x: 0,
                          y: 0,
                          width: cv.bounds.size.width,
                          height: cv.bounds.size.height)
        let noDataLabel: UILabel = UILabel(frame: rect)
        
        noDataLabel.text = message
        noDataLabel.textColor = .white
        noDataLabel.textAlignment = textAlignment
        cv.backgroundView = noDataLabel
        return 0
    }
}

//MARK: - DispatchQueue

func delayWithSeconds(_ seconds: Double, completion: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        completion()
    }
}

func mainThread(_ completion: @escaping () -> ()) {
    DispatchQueue.main.async {
        completion()
    }
}
//userInteractive
//userInitiated
//default
//utility
//background
//unspecified
func backgroundThread(_ qos: DispatchQoS.QoSClass = .background , completion: @escaping () -> ()) {
    DispatchQueue.global(qos:qos).async {
        completion()
    }
}
// MARK: - Platform

struct Platform {
    
    static var isSimulator: Bool {
        return TARGET_OS_SIMULATOR != 0
    }
    
}



// MARK: - Documents Directory Clear

func clearTempFolder() {
    let fileManager = FileManager.default
    let tempFolderPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    
    do {
        let filePaths = try fileManager.contentsOfDirectory(atPath: tempFolderPath)
        for filePath in filePaths {
            try fileManager.removeItem(atPath: tempFolderPath + "/" + filePath)
        }
    } catch {
        print("Could not clear temp folder: \(error)")
    }
}




// MARK: - Trim String

func trimString(string : NSString) -> NSString {
    return string.trimmingCharacters(in: NSCharacterSet.whitespaces) as NSString
}

// MARK: - Alert and Action Sheet Controller

func showAlertView(_ strAlertTitle : String, strAlertMessage : String) -> UIAlertController {
    let alert = UIAlertController(title: strAlertTitle, message: strAlertMessage, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler:{ (ACTION :UIAlertAction!)in
    }))
    return alert
}

// MARK:- Navigation

func viewController(withID ID : String , storyBoard : String) -> UIViewController {
    let mainStoryboard = UIStoryboard(name: storyBoard, bundle: nil)
    let controller = mainStoryboard.instantiateViewController(withIdentifier: ID)
    return controller
}

// MARK:- UIButton Corner Radius

func cornerLeftButton(btn : UIButton) -> UIButton {
    
    let path = UIBezierPath(roundedRect:btn.bounds, byRoundingCorners:[.topLeft, .bottomLeft], cornerRadii: CGSize.init(width: 5, height: 5))
    let maskLayer = CAShapeLayer()
    
    maskLayer.path = path.cgPath
    btn.layer.mask = maskLayer
    
    return btn
}

func cornerRightButton(btn : UIButton) -> UIButton {
    
    let path = UIBezierPath(roundedRect:btn.bounds, byRoundingCorners:[.topRight, .bottomRight], cornerRadii: CGSize.init(width: 5, height: 5))
    let maskLayer = CAShapeLayer()
    
    maskLayer.path = path.cgPath
    btn.layer.mask = maskLayer
    
    return btn
}

// MARK:- UITextField Corner Radius

func cornerLeftTextField(textfield : UITextField) -> UITextField {
    
    let path = UIBezierPath(roundedRect:textfield.bounds, byRoundingCorners:[.topLeft, .bottomLeft], cornerRadii: CGSize.init(width: 2.5, height: 2.5))
    let maskLayer = CAShapeLayer()
    
    maskLayer.path = path.cgPath
    textfield.layer.mask = maskLayer
    
    return textfield
}



// MARK: - Camera Permissions Methods

func checkCameraPermissionsGranted() -> Bool {
    var cameraPermissionStatus : Bool = false
    if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
        // Already Authorized
        cameraPermissionStatus = true
        return true
    } else {
        AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted: Bool) -> Void in
            if granted == true {
                // User granted
                cameraPermissionStatus = granted
                print("Granted access to Camera");
            } else {
                // User rejected
                cameraPermissionStatus = granted
                print("Not granted access to Camera");
            }
        })
        return cameraPermissionStatus
    }
}

// MARK: - Photo Library Permissions Methods

func checkPhotoLibraryPermissionsGranted() -> Bool {
    var photoLibraryPermissionStatus : Bool = false
    let status = PHPhotoLibrary.authorizationStatus()
    if (status == PHAuthorizationStatus.authorized) {
        // Access has been granted.
        photoLibraryPermissionStatus = true
    }
    else if (status == PHAuthorizationStatus.denied) {
        // Access has been denied.
        photoLibraryPermissionStatus = false
    }
    else if (status == PHAuthorizationStatus.notDetermined) {
        // Access has not been determined.
        PHPhotoLibrary.requestAuthorization({ (newStatus) in
            if (newStatus == PHAuthorizationStatus.authorized) {
                photoLibraryPermissionStatus = true
            }
            else {
                photoLibraryPermissionStatus = false
            }
        })
    }
    else if (status == PHAuthorizationStatus.restricted) {
        // Restricted access - normally won't happen.
        photoLibraryPermissionStatus = false
    }
    return photoLibraryPermissionStatus
}

// MARK: - Set NavigationBar Methods

func setNavigationBar(viewController : UIViewController, strTitleName : String) {
    let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.white]
    viewController.navigationController?.navigationBar.titleTextAttributes = (titleDict as! [NSAttributedString.Key : Any])
    
    viewController.navigationController?.navigationBar.tintColor = .white()
    
    viewController.navigationItem.title = strTitleName
    viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title:"", style:.plain, target:nil, action:nil)

    viewController.navigationController?.navigationBar.backgroundColor = UIColor.blue
}


func setNavigation() {
//    UINavigationBar.appearance().barTintColor = .themeMainGray()
    UINavigationBar.appearance().tintColor = .white()
    //    UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor:Constants.RGBColorCodes.cNavigationBarColor]
    UINavigationBar.appearance().isTranslucent = false
    //    UIApplication.shared.statusBarView?.backgroundColor = Constants.RGBColorCodes.defaultBlueColor
    UINavigationBar.appearance().titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.white,
         NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
}



// MARK:- Navigation
func navigateVC(identifierId : String) -> UIViewController {
    
    let controller = Constants.mainStoryboard.instantiateViewController(withIdentifier: identifierId)
    return controller
}


func saveImage(data: Data) -> URL? {
    //        guard let data = UIImageJPEGRepresentation(image, 1) ?? UIImagePNGRepresentation(image) else {
    //            return false
    //        }
    let tempDirectoryURL = NSURL.fileURL(withPath: NSTemporaryDirectory(), isDirectory: true)
    do {
        let targetURL = tempDirectoryURL.appendingPathComponent("Image.png")
        try data.write(to: targetURL)
        return targetURL
    } catch {
        print(error.localizedDescription)
        return nil
    }
}

func convertVideo(to outputFileType: AVFileType, withInputURL inputURL: URL?, outputURL: URL?, handler: @escaping (_ exportSession: AVAssetExportSession?) -> Void) {
    do {
        if let outputURL = outputURL {
            try FileManager.default.removeItem(at: outputURL)
        }
    } catch {
    }
    var asset: AVURLAsset? = nil
    if let inputURL = inputURL {
        asset = AVURLAsset(url: inputURL, options: nil)
    }
    var exportSession: AVAssetExportSession? = nil
    if let asset = asset {
        exportSession = AVAssetExportSession(asset: asset, presetName: AVAssetExportPresetMediumQuality)
    }
    exportSession?.outputURL = outputURL
    exportSession?.outputFileType = outputFileType
    exportSession?.exportAsynchronously(completionHandler: {
        DispatchQueue.main.async(execute: {
            //Your main thread code goes in here
            handler(exportSession)
            
        })
        //         [exportSession release];
    })
}
func getThumbnailFrom(path: URL , handler: @escaping (_ img: UIImage?) -> Void) {
    backgroundThread(.utility) {
        do {
            
            let asset = AVURLAsset(url: path , options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(value: 0, timescale: 1), actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)
            mainThread {
                handler(thumbnail)
            }
            
        } catch let error {
            
            print("*** Error generating thumbnail: \(error.localizedDescription)")
            //            return nil
            mainThread {
                handler(nil)
            }
        }
    }
}

public class ConnectionCheck {
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
}
