//
//  Device.swift
//  iOS-Bugsnatch
//
//  Created by Damjan Dabo on 11/04/2019.
//

import UIKit

open class Device {

    public enum DeviceType: String { // TODO: - add description -
        case iPhone = "iPhone 4"
        case iPad = "iPad4"
        case iPod = "iPod"
        case simulator = "simulator"
        case unknown = "unknown"
    }

    public enum Version: String { // TODO: - add description -
        case iPhone4 = "iPhone 4"
        case iPhone4S = "iPhone 4S"
        case iPhone5 = "iPhone 5"
        case iPhone5C = "iPhone 5C"
        case iPhone5S = "iPhone 5S"
        case iPhone6 = "iPhone 6"
        case iPhone6Plus = "iPhone 6 Plus"
        case iPhone6S = "iPhone 6S"
        case iPhone6SPlus = "iPhone 6S Plus"
        case iPhoneSE = "iPhone SE"
        case iPhone7 = "iPhone 7"
        case iPhone7Plus = "iPhone 7 Plus"
        case iPhone8 = "iPhone 8"
        case iPhone8Plus = "iPhone 8 Plus"
        case iPhoneX = "iPhone X"
        case iPhoneXS = "iPhone XS"
        case iPhoneXS_Max = "iPhone XS Max"
        case iPhoneXR = "iPhone XR"
        case iPad1 = "iPad 1"
        case iPad2 = "iPad 2"
        case iPad3 = "iPad 3"
        case iPad4 = "iPad 4"
        case iPad5 = "iPad 5"
        case iPad6 = "iPad 6"
        case iPadAir = "iPad Air"
        case iPadAir2 = "iPad Air 2"
        case iPadMini = "iPad Mini"
        case iPadMini2 = "iPad Mini 2"
        case iPadMini3 = "iPad Mini 3"
        case iPadMini4 = "iPad Mini 4"
        case iPadPro12_9Inch = "iPad Pro 12.9-inch"
        case iPadPro10_5Inch = "iPad Pro 10.5-inch"
        case iPadPro9_7Inch = "iPad Pro 9.7-inch"
        case iPodTouch1Gen = "iPod Touch 1Gen"
        case iPodTouch2Gen = "iPod Touch 2Gen"
        case iPodTouch3Gen = "iPod Touch 3Gen"
        case iPodTouch4Gen = "iPod Touch 4Gen"
        case iPodTouch5Gen = "iPod Touch 5Gen"
        case iPodTouch6Gen = "iPod Touch 6Gen"
        case simulator = "simulator"
        case unknown = "unknown"
    }

    public enum ScreenSize: String { // TODO: - add description -
        case screen3_5Inch = "3.5 inch"
        case screen4Inch = "4 inch"
        case screen4_7Inch = "4.7 inch"
        case screen5_5Inch = "5.5 inch"
        case screen5_8Inch = "5.8 inch"
        case screen6_1Inch = "6.1 inch"
        case screen6_5Inch = "6.5 inch"
        case screen7_9Inch = "7.9 inch"
        case screen9_7Inch = "9.7 inch"
        case screen10_5Inch = "10.5 inch"
        case screen12_9Inch = "12.9 inch"
        case unknown = "unknown"
    }

    static private var _versionCode: String {
        var systemInfo = utsname()
        uname(&systemInfo)

        let versionCode: String = String(validatingUTF8: NSString(bytes: &systemInfo.machine, length: Int(_SYS_NAMELEN), encoding: String.Encoding.ascii.rawValue)!.utf8String!)!

        return versionCode
    }

    /// Returns the device version on which the application is running.
    static public var version: Version {
        switch _versionCode {
            /*** iPhone ***/
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return .iPhone4
        case "iPhone4,1", "iPhone4,2", "iPhone4,3":     return .iPhone4S
        case "iPhone5,1", "iPhone5,2":                 return .iPhone5
        case "iPhone5,3", "iPhone5,4":                 return .iPhone5C
        case "iPhone6,1", "iPhone6,2":                 return .iPhone5S
        case "iPhone7,2":                            return .iPhone6
        case "iPhone7,1":                            return .iPhone6Plus
        case "iPhone8,1":                            return .iPhone6S
        case "iPhone8,2":                            return .iPhone6SPlus
        case "iPhone8,3", "iPhone8,4":                 return .iPhoneSE
        case "iPhone9,1", "iPhone9,3":                 return .iPhone7
        case "iPhone9,2", "iPhone9,4":                 return .iPhone7Plus
        case "iPhone10,1", "iPhone10,4":               return .iPhone8
        case "iPhone10,2", "iPhone10,5":               return .iPhone8Plus
        case "iPhone10,3", "iPhone10,6":               return .iPhoneX
        case "iPhone11,2":                           return .iPhoneXS
        case "iPhone11,4", "iPhone11,6":               return .iPhoneXS_Max
        case "iPhone11,8":                           return .iPhoneXR


            /*** iPad ***/
        case "iPad1,1", "iPad1,2":                    return .iPad1
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4": return .iPad2
        case "iPad3,1", "iPad3,2", "iPad3,3":           return .iPad3
        case "iPad3,4", "iPad3,5", "iPad3,6":           return .iPad4
        case "iPad6,11", "iPad6,12":                   return .iPad5
        case "iPad7,5", "iPad 7,6":                    return .iPad6
        case "iPad4,1", "iPad4,2", "iPad4,3":           return .iPadAir
        case "iPad5,3", "iPad5,4":                     return .iPadAir2
        case "iPad2,5", "iPad2,6", "iPad2,7":           return .iPadMini
        case "iPad4,4", "iPad4,5", "iPad4,6":           return .iPadMini2
        case "iPad4,7", "iPad4,8", "iPad4,9":           return .iPadMini3
        case "iPad5,1", "iPad5,2":                     return .iPadMini4
        case "iPad6,7", "iPad6,8", "iPad7,1", "iPad7,2":  return .iPadPro12_9Inch
        case "iPad7,3", "iPad7,4":                       return .iPadPro10_5Inch
        case "iPad6,3", "iPad6,4":                       return .iPadPro9_7Inch

            /*** iPod ***/
        case "iPod1,1":                                  return .iPodTouch1Gen
        case "iPod2,1":                                  return .iPodTouch2Gen
        case "iPod3,1":                                  return .iPodTouch3Gen
        case "iPod4,1":                                  return .iPodTouch4Gen
        case "iPod5,1":                                  return .iPodTouch5Gen
        case "iPod7,1":                                  return .iPodTouch6Gen

            /*** Simulator ***/
        case "i386", "x86_64":                           return .simulator

        default:                                         return .unknown
        }
    }

    /// Returns the device type on which the application is running.
    static public var deviceType: DeviceType {
        let versionCode = _versionCode

        if versionCode.contains("iPhone") {
            return .iPhone
        } else if versionCode.contains("iPad") {
            return .iPad
        } else if versionCode.contains("iPod") {
            return .iPod
        } else if versionCode == "i386" || versionCode == "x86_64" {
            return .simulator
        } else {
            return .unknown
        }
    }

    /// Returns the screen size of the device on which the application is running.
    static public var size: ScreenSize {
        let w: Double = Double(UIScreen.main.bounds.width)
        let h: Double = Double(UIScreen.main.bounds.height)
        let screenHeight: Double = max(w, h)

        switch screenHeight {
        case 480:
            return .screen3_5Inch
        case 568:
            return .screen4Inch
        case 667:
            return UIScreen.main.scale == 3.0 ? .screen5_5Inch : .screen4_7Inch
        case 736:
            return .screen5_5Inch
        case 812:
            return .screen5_8Inch
        case 896:
            switch version {
            case .iPhoneXS_Max:
                return .screen6_5Inch
            default:
                return .screen6_1Inch
            }
        case 1024:
            switch version {
            case .iPadMini,.iPadMini2,.iPadMini3,.iPadMini4:
                return .screen7_9Inch
            case .iPadPro10_5Inch:
                return .screen10_5Inch
            default:
                return .screen9_7Inch
            }
        case 1112:
            return .screen10_5Inch
        case 1366:
            return .screen12_9Inch
        default:
            return .unknown
        }
    }
}
