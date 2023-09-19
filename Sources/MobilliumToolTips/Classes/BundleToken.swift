//
//  BundleToken.swift
//  MobilliumGenesisKit
//
//  Created by Mehmet Salih Aslan on 10.03.2023.
//  Copyright © 2023 Mobillium. All rights reserved.
//

import Foundation

final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
