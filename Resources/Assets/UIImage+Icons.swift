//
//  UIImage+Icons.swift
//  MobilliumGenesisKit
//
//  Created by Mehmet Salih Aslan on 11.05.2023.
//  Copyright © 2023 Mobillium. All rights reserved.
//

import UIKit

public extension UIImage {
        
    static var icInfo: UIImage {
        return UIImage(named: "ic_info", in: BundleToken.bundle, compatibleWith: nil)!
    }
}
