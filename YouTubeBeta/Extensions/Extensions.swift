//
//  Extensions.swift
//  YouTubeBeta
//
//  Created by NEKA on 8/23/19.
//  Copyright © 2019 NEKA. All rights reserved.
//

import UIKit

extension UIColor {
    class func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        let color = UIColor.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
        return color
    }
}

