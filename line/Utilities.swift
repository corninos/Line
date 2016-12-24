//
//  Utilities.swift
//  squares
//

import UIKit

// Physics bit masks
struct Bitmask {
  static let none    = UInt32(0)
  static let screen  = UInt32(1 << 1)
  static let squares = UInt32(1 << 2)
  static let finger  = UInt32(1 << 3)
}

// Screen size
struct Screen {
  
  static let size: CGSize = {
    
    guard let type = UIDevice.current.deviceType
      else {
        // Unknown type
        fatalError("Unknown screen")
    }
    
    switch type {
    case .iPhone47:
      return CGSize(width: 375, height: 667)
    case .iPhone55:
      return CGSize(width: 414, height: 736)
    case .iPad:
      return CGSize(width: 768, height: 1024)
    default:
      fatalError("screen not allowed")
    }
    
  }()
  
  static let frame = CGRect(x: 0,
                            y: 0,
                            width: Screen.size.width,
                            height: Screen.size.height)
  
}

// extensions
extension Int {
  
  static func random(_ n: Int) -> Int {
    return Int(arc4random_uniform(UInt32(n)))
  }
  
  static func random(min: Int, max: Int) -> Int {
    assert(min < max)
    return Int(arc4random_uniform(UInt32(max - min + 1))) + min
  }
  
}

extension Double {
  
  static func random(_ n: Double) -> Double {
    return Double(arc4random_uniform(UInt32(n)))
  }
  
  static func random(min: Double, max: Double) -> Double {
    assert(min < max)
    return Double(arc4random_uniform(UInt32(max - min + 1))) + min
  }
  
}

extension CGFloat {
  
  static func random(_ n: CGFloat) -> CGFloat {
    return CGFloat(arc4random_uniform(UInt32(n)))
  }
  
  static func random(min: CGFloat, max: CGFloat) -> CGFloat {
    assert(min < max)
    return CGFloat(arc4random_uniform(UInt32(max - min + 1))) + min
  }
  
}

extension CGPoint {
  
  static func random(pointIn size: CGSize) -> CGPoint {
    return CGPoint(x: Int.random(Int(size.width)),
                   y: Int.random(Int(size.height)))
  }
  
}

extension UIColor {
  
  static func randomColor() -> UIColor {
    
    return UIColor(red: CGFloat.random(256)/255,
                   green: CGFloat.random(256)/255,
                   blue: CGFloat.random(256)/255,
                   alpha: 1.0)
  }
}

extension UIDevice {
  enum DeviceType {
    case iPhone35
    case iPhone40
    case iPhone47
    case iPhone55
    case iPad
    case TV
    case CarPlay
    
    var isPhone: Bool {
      return [ .iPhone35, .iPhone40, .iPhone47, .iPhone55 ].contains(self)
    }
  }
  
  var deviceType: DeviceType? {
    switch UIDevice.current.userInterfaceIdiom {
    case .tv:
      return .TV
      
    case .pad:
      return .iPad
      
    case .carPlay:
      return .CarPlay
      
    case .phone:
      let screenSize = UIScreen.main.bounds.size
      let height = max(screenSize.width, screenSize.height)
      
      switch height {
      case 480:
        return .iPhone35
      case 568:
        return .iPhone40
      case 667:
        return .iPhone47
      case 736:
        return .iPhone55
      default:
        return nil
      }
      
    case .unspecified:
      return nil
    }
  }
}
