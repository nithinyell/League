//
//  Extensions.swift
//  LeagueMobileChallenge
//
//  Created by Nithin 3 on 11/03/22.
//  Copyright © 2022 Kelvin Lau. All rights reserved.
//

import Foundation
import UIKit
import Combine

let imageCache = NSCache<AnyObject, AnyObject>()

extension String {
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    func asURL() -> URL? {
        return URL(string: self) ?? nil
    }
}

extension URL {
    
    func fetchImageFromURL(onSuccess: @escaping (UIImage?) -> Void) {
        
        if let image = imageCache.object(forKey: self as AnyObject) as? UIImage {
            onSuccess(image)
            print("Using Cache to Retrive User Avatar")
        } else {
            
            DispatchQueue.global(qos: .background).async {
                do {
                    let imageData = try Data(contentsOf: self)
                    if let image = UIImage(data: imageData) {
                        imageCache.setObject(image, forKey: self as AnyObject)
                        onSuccess(image)
                    }
                } catch {
                    onSuccess(nil)
                }
            }
        }
    }
}

extension UIImageView {
  
    func makeRoundImageView(image: UIImage) {
        self.contentMode = .scaleAspectFill
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true
        self.image = image
  }
}
