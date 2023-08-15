//
//  GKTooltipTarget.swift
//  MobilliumGenesisKitDemo
//
//  Created by Serkan Erkan on 7.07.2023.
//  Copyright © 2023 Mobillium. All rights reserved.
//

import Foundation
import UIKit

public enum GKTooltipTarget {
    case view(UIView)
    case barButton(UIBarButtonItem)
    case tabBarItem(UITabBarController, Int)
    case point(CGPoint, radius: CGFloat)
    case rect(CGRect)

    var targetView: UIView {
        let target: UIView
        switch self {
        case let .view(view):
            target = view
        case let .barButton(barButtonItem):
            let view = (barButtonItem.value(forKey: "view") as? UIView) ?? UIView()
            target = view.subviews.first ?? view
        case let .tabBarItem(tabBarController, index):
            let tabBarItems = tabBarController.tabBar.subviews.filter { $0.isUserInteractionEnabled }
            guard index > -1, tabBarItems.count > index else { return UIView() }
            let tabBarItemView = tabBarItems[index]
            let frame = CGRect(x: tabBarItemView.frame.midX - 22, y: tabBarController.tabBar.frame.origin.y, width: 44, height: 44)
            target = UIView(frame: frame)
        case let .point(center, radius):
            target = UIView(frame: CGRect(x: 0, y: 0, width: radius * 2, height: radius * 2))
            target.center = center
        case let .rect(frame):
            target = UIView(frame: frame)
        }
        return target
    }
    
    func path(node: GKTooltipNode, translater: UIView) -> UIBezierPath {
        let translatedFrame = targetView.convert(targetView.bounds, to: translater)
        var cornerRadius: CGFloat
        var dx: CGFloat
        var dy: CGFloat
        
        // Add some breathing space for the tooltip
        switch node.frameConfiguration {
        case .`default`:
            dx = 6
            dy = 6
            cornerRadius = 2
        case .custom(let dxValue, let dyValue, let cornerRadiusValue):
            dx = dxValue
            dy = dyValue
            cornerRadius = cornerRadiusValue
        case .none:
            dx = 0
            dy = 0
            cornerRadius = 0
        }
        let gkTooltipFrame = translatedFrame.insetBy(dx: -dy, dy: -dx)
        
        if node.roundedCorners {
            return UIBezierPath(roundedRect: gkTooltipFrame,
                                cornerRadius: gkTooltipFrame.height / 2.0)
        } else {
            return UIBezierPath(roundedRect: gkTooltipFrame,
                                cornerRadius: cornerRadius)
        }
    }
    
    
    func infinitesmalPath(node: GKTooltipNode, translater: UIView) -> UIBezierPath {
        let gkTooltipFrame = targetView.convert(targetView.bounds, to: translater)
        let gkTooltipCenter = CGPoint(x: gkTooltipFrame.midX, y: gkTooltipFrame.midY)
        
        if node.roundedCorners {
            return UIBezierPath(roundedRect: CGRect(origin: gkTooltipCenter, size: CGSize.zero), cornerRadius: 0)
        } else {
            return UIBezierPath(rect: CGRect(origin: gkTooltipCenter, size: CGSize.zero))
        }
    }
}
