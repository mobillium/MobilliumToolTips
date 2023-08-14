//
//  GKTooltip.swift
//  MobilliumGenesisKitDemo
//
//  Created by Serkan Erkan on 7.07.2023.
//  Copyright © 2023 Mobillium. All rights reserved.
//

import Foundation
import UIKit

public protocol GKTooltipDelegate: AnyObject {
    func didAdvance(to node: Int, of total: Int)
    func didDismiss()
    func skipButtonTapped(to node: Int)
    func nextButtonTapped(to node: Int)
    func closeButtonTapped(to node: Int)
}

public protocol PopupDelegate: AnyObject {
    func didTapLink(index: Int)
}

public final class GKTooltip {
    public static var delay: TimeInterval = 5.0
    public static var animationDuration: TimeInterval = 0.3
    public static var popupAnimationDuration: TimeInterval = 0.8
    public static var alpha: CGFloat = 0.7
    public static var backgroundColor: UIColor = .pureBlack
    
    public weak var delegate: GKTooltipDelegate?
    public weak var popupDelegate: PopupDelegate?
    
    public init() {}
    
    public func startIntro(from controller: UIViewController,
                           presentController: UIViewController,
                           with scrollView: UIScrollView? = nil,
                           withNodes nodes: [GKTooltipNode],
                           isHighlightedWithOneNode: Bool = false) {
        guard !nodes.isEmpty else { return }
        gkTooltipVC.dataSource = GKTooltipDataSource(nodes, isHighlightedWithOneNode: isHighlightedWithOneNode)
        gkTooltipVC.delegate = delegate
        gkTooltipVC.popupDelegate = popupDelegate
        gkTooltipVC.scrollView = scrollView
        presentController.present(gkTooltipVC, animated: true, completion: nil)
        print("startIntro method called with nodes: \(nodes)")
    }

    public func startIntro(childFrom childViewController: UIViewController,
                           with scrollView: UIScrollView? = nil,
                           withNodes nodes: [GKTooltipNode],
                           isHighlightedWithOneNode: Bool = false) {
        guard !nodes.isEmpty else { return }
        gkTooltipVC.dataSource = GKTooltipDataSource(nodes, isHighlightedWithOneNode: isHighlightedWithOneNode)
        gkTooltipVC.delegate = delegate
        gkTooltipVC.popupDelegate = popupDelegate
        gkTooltipVC.scrollView = scrollView
        childViewController.present(gkTooltipVC,
                                    animated: true,
                                    completion: nil)
    }
    
    public func dismissGKTooltip() {
        gkTooltipVC.dismissGKTooltip()
    }

    public func nextGKTooltip() {
        gkTooltipVC.nextGKTooltip()
    }
    
    public func previousGKTooltip() {
        gkTooltipVC.previousGKTooltip()
    }
    
    private let gkTooltipVC = GKTooltipViewController()
}
