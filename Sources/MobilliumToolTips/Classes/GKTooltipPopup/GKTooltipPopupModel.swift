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
    
    // frame configuration
    var frameConfiguration: GKTooltipPopupModel.FrameConfigurationType
    var borderConfiguration: GKTooltipPopupModel.BorderConfigurationType
    
    // completion handler
    var completionHandler: (() -> ())?

    init(
         tooltipText: String,
         currentPage: Int,
         numberOfCount: Int,
         leftButtonText: String,
         rightButtonText: String,
         leftButtonType: ButtonType,
         rightButtonType: ButtonType,
         leftButtonTintColor: UIColor,
         rightButtonTintColor: UIColor,
         frameConfiguration: GKTooltipPopupModel.FrameConfigurationType = .default,
         borderConfiguration: GKTooltipPopupModel.BorderConfigurationType = .default,
         completionHandler: (() -> ())? = nil) {
        self.tooltipText = tooltipText
        self.currentPage = currentPage
        self.numberOfCount = numberOfCount
        self.leftButtonText = leftButtonText
        self.leftButtonType = leftButtonType
        self.leftButtonTintColor = leftButtonTintColor
        self.rightButtonText = rightButtonText
        self.rightButtonType = rightButtonType
        self.rightButtonTintColor = rightButtonTintColor
        self.frameConfiguration = frameConfiguration
        self.borderConfiguration = borderConfiguration
        self.completionHandler = completionHandler
    }
    
    public enum ButtonType {
        case skip
        case again
        case next
        case close
    }
    
    public enum FrameConfigurationType {
        case `default`
        case custom(dx: CGFloat, dy: CGFloat, cornerRadius: CGFloat)
        case none
     }
    
    public enum BorderConfigurationType {
        case `default`
        case custom(fillColor: UIColor, strokeColor: UIColor, width: CGFloat)
      }
}
