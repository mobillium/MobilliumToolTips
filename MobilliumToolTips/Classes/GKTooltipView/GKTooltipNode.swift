//
//  GKTooltipNode.swift
//  MobilliumGenesisKitDemo
//
//  Created by Serkan Erkan on 20.07.2023.
//  Copyright © 2023 Mobillium. All rights reserved.
//

import UIKit

public struct GKTooltipNode {
    var text: String
    var target: GKTooltipTarget
    var roundedCorners: Bool
    var isLeftButtonHidden: Bool = false
    var isRightButtonHidden: Bool = false
    var isIconViewHidden: Bool = false

    var leftButtonText: String
    var leftButtonType: GKTooltipPopupModel.ButtonType
    var leftButtonTintColor: UIColor
    var rightButtonText: String
    var rightButtonType: GKTooltipPopupModel.ButtonType
    var rightButtonTintColor: UIColor
    
    var frameConfiguration: GKTooltipPopupModel.FrameConfigurationType
    var borderConfiguration: GKTooltipPopupModel.BorderConfigurationType

    public init(
         text: String,
         target: GKTooltipTarget,
         roundedCorners: Bool = true,
         isLeftButtonHidden: Bool = true,
         isRightButtonHidden: Bool = true,
         isIconViewHidden: Bool = true,
         leftButtonText: String,
         leftButtonType: GKTooltipPopupModel.ButtonType,
         leftButtonTintColor: UIColor,
         rightButtonText: String,
         rightButtonType: GKTooltipPopupModel.ButtonType,
         rightButtonTintColor: UIColor,
         frameConfiguration: GKTooltipPopupModel.FrameConfigurationType = .default,
         borderConfiguration: GKTooltipPopupModel.BorderConfigurationType = .default)
    {
        self.text = text
        self.target = target
        self.roundedCorners = roundedCorners
        self.isLeftButtonHidden = isLeftButtonHidden
        self.isRightButtonHidden = isRightButtonHidden
        self.isIconViewHidden = isIconViewHidden
        self.leftButtonText = leftButtonText
        self.leftButtonType = leftButtonType
        self.leftButtonTintColor = leftButtonTintColor
        self.rightButtonText = rightButtonText
        self.rightButtonType = rightButtonType
        self.rightButtonTintColor = rightButtonTintColor
        self.frameConfiguration = frameConfiguration
        self.borderConfiguration = borderConfiguration
    }
}
