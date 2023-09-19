//
//  GKTooltipPopupViewConstant.swift
//  MobilliumGenesisKitDemo
//
//  Created by Serkan Erkan on 7.07.2023.
//  Copyright © 2023 Mobillium. All rights reserved.
//

import UIKit

protocol GKTooltipPopupViewConstant {}

extension GKTooltipPopupViewConstant {
    var topConstant: CGFloat {
        16 + bubleV
    }
    
    var bottomConstant: CGFloat {
        8 + bubleV
    }
    
    var leadingConstant: CGFloat {
        10 + bubleH
    }
    
    var trailingConstant: CGFloat {
        10 + bubleH
    }
    
    var bubleH: CGFloat {
        8
    }
    
    var bubleV: CGFloat {
        10
    }
    
    var arrowHeight: CGFloat {
        10
    }
    
    var labelWidth: CGFloat {
        maximumWidth - (leadingConstant - bubleV) - (trailingConstant - bubleV)
    }
    
    var maximumWidth: CGFloat {
        return 310
    }
    
    var maximumHeight: CGFloat {
        return 675
    }
    
    var maximumSize: CGSize {
        CGSize(width: labelWidth, height: maximumHeight)
    }
    
    var buttonSpacing: CGFloat {
        6
    }
    
    var stackViewHeight: CGFloat {
        30.0
    }
}
