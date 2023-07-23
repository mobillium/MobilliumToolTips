//
//  GKTooltipPopupModel.swift
//  MobilliumGenesisKitDemo
//
//  Created by Serkan Erkan on 20.07.2023.
//  Copyright © 2023 Mobillium. All rights reserved.
//

import UIKit

public struct GKTooltipPopupModel {
    var currentPage: Int
    var numberOfCount: Int

    // text+icon
    var tooltipText: String
    var isIconViewHidden: Bool = false

    // buttons
    var leftButtonText: String
    var leftButtonType: ButtonType
    var leftButtonTintColor: UIColor
    var isLeftButtonHidden: Bool = false
    
    var rightButtonText: String
    var rightButtonType: ButtonType
    var rightButtonTintColor: UIColor
    var isRightButtonHidden: Bool = false

    init(
         tooltipText: String,
         currentPage: Int,
         numberOfCount: Int,
         leftButtonText: String,
         rightButtonText: String,
         leftButtonType: ButtonType,
         rightButtonType: ButtonType,
         leftButtonTintColor: UIColor,
         rightButtonTintColor: UIColor) {
        self.tooltipText = tooltipText
        self.currentPage = currentPage
        self.numberOfCount = numberOfCount
        self.leftButtonText = leftButtonText
        self.leftButtonType = leftButtonType
        self.leftButtonTintColor = leftButtonTintColor
        self.rightButtonText = rightButtonText
        self.rightButtonType = rightButtonType
        self.rightButtonTintColor = rightButtonTintColor
    }
    
    public enum ButtonType {
        case skip
        case again
        case next
        case close
    }
}
