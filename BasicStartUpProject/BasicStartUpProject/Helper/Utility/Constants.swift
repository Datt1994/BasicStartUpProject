//
//  Utility.swift

import UIKit
import Foundation


// MARK: - Colors
extension UIColor {
    class func themeRed() -> UIColor { return UIColor(r: 238, g: 0, b: 18)}
    class func themeBlue() -> UIColor { return UIColor(r: 0, g: 15, b: 81)}
    
    
    class func black() -> UIColor { return UIColor.black }
    class func white() -> UIColor { return UIColor.white }
    class func lightGray() -> UIColor { return UIColor.lightGray }
    class func gray() -> UIColor { return UIColor.gray }
    class func darkGray() -> UIColor { return UIColor.darkGray }
    class func red() -> UIColor { return UIColor.red }
    class func clear() -> UIColor { return UIColor.clear }
}
enum MenuOptiones : String {
    case editProfile = "EDIT PROFILE"

}
// MARK: - Font Name
enum Font {
    static let openSansRegular       = "OpenSans"
    static let openSansBold          = "OpenSans-Bold"
    static let openSansSemibold      = "OpenSans-Semibold"
    static let latoBold              = "Lato-Bold"
}

// MARK: - StoryBoard Identifier's
enum AllStoryBoard {

    static let MyAccountProfileTblCell = "MyAccountProfileTblCell"
    static let MyAccountTblCell = "MyAccountTblCell"
    static let HomeTblCell = "HomeTblCell"
  
}


// MARK: - Titles
enum Title {
    static let home = "HOME"
    static let login = "LOGIN"
  
}


// MARK: - Message's
enum AlertMessage {
    
    static let inProgress = "In Progress"
    
    //Internet Connection Messages
    static let networkConnection = "You are not connected to internet. Please connect and try again"
    
    //Contact Us Messages
    static let contactUs = "Your query has been submitted successfully"
    
    //Camera, Images and ALbums Related Messages
    static let cameraPermission = "Please enable camera access from Privacy Settings"
    static let photoLibraryPermission = "Please enable access for photos from Privacy Settings"
    static let noCamera = "Device Has No Camera"
    

    
}

enum WebServiceURL {
//    static let API_KEY = "ICXE1wOphgKgcyMoHr0hVHbbJ"
    
    static let mainURL = "http://192.168.15.163:4240/"

    static let apiURL = mainURL + "api/"
    
    static let signUpURL = apiURL + "register"
    static let logInURL = apiURL + "login"
    static let getProfile = apiURL + "get-profile"
    static let editprofile = apiURL + "editprofile"
  
}
enum WebServiceParameter {
    static let id = "id"
    static let emailID = "email_id"
    static let password = "password"
    static let deviceToken = "device_id"
    static let lastName = "last_name"
    static let firstName = "first_name"
   
    
}
// MARK: - User Default KeyName
enum UserDefaultKey {
    static let loginData = "LoginData"
   
}

struct Constants {
    // MARK: - Global Utility
    static let appName    = Bundle.main.infoDictionary!["CFBundleName"] as! String
    static let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let pageLimit = 10
    static let keyWindow = UIApplication.shared.connectedScenes
           .filter({$0.activationState == .foregroundActive})
           .map({$0 as? UIWindowScene})
           .compactMap({$0})
           .first?.windows
           .filter({$0.isKeyWindow}).first
    
    //MARK: - device type
    enum UIUserInterfaceIdiom : Int{
        case Unspecified
        case Phone
        case Pad
    }
    
    struct ScreenSize {
        static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
        static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
        static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
        static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    }
    
    struct DateFormat
    {
        static let date = "dd/MM/yy"
        static let time = "hh:mm a"
    }
    

}

