//
//  GKTooltipViewController.swift
//  MobilliumGenesisKitDemo
//
//  Created by Serkan Erkan on 7.07.2023.
//  Copyright © 2023 Mobillium. All rights reserved.
//

import Foundation
import UIKit

final class GKTooltipViewController: UIViewController {
    var dataSource: GKTooltipDataSource = GKTooltipDataSource()
    var scrollView: UIScrollView?
    weak var delegate: GKTooltipDelegate?
    weak var popupDelegate: PopupDelegate?
    weak var tipView: EasyTipView?
    var gkTooltipPopup = GKTooltipPopupView(frame: .zero)
    let gkTooltipView = GKTooltipView()
    var currentNodeIndex: Int = -1
    fileprivate var timer = Timer()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGKTooltipView()
        setupTapGestureRecognizer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        nextGKTooltip()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        gkTooltipView.isHidden = true
        timer.invalidate()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        // Re-draw tooltip for the new dimension
        gkTooltipView.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        showGKTooltip()
    }
}

// MARK: - Actions -
extension GKTooltipViewController: GKTooltipPopupDelegate {
    func didTapLink(index: Int) {
        popupDelegate?.didTapLink(index: index)
    }
    
    func closeTapped() {
        dismissGKTooltip()
    }
    
    func buttonTapped(buttonType: GKTooltipPopupModel.ButtonType) {
        timer.invalidate()
        switch buttonType {
        case .again:
            currentNodeIndex = -1
            nextGKTooltip()
        case .close:
            delegate?.closeButtonTapped(to: currentNodeIndex)
            dismissGKTooltip()
        case .next:
            delegate?.nextButtonTapped(to: currentNodeIndex)
            nextGKTooltip()
        case .skip:
            delegate?.skipButtonTapped(to: currentNodeIndex)
            dismissGKTooltip()
        }
    }
    
    @objc func viewTapped(_: UITapGestureRecognizer) {
        timer.invalidate()
        executeGKTooltipCompletionHandler()
        nextGKTooltip()
    }
    
    @objc func nextGKTooltip() {
        if currentNodeIndex == dataSource.gkTooltipNodes.count - 1 {
            dismissGKTooltip()
            return
        }
        currentNodeIndex += 1
        showGKTooltip()
    }
    
    func previousGKTooltip() {
        if currentNodeIndex == 0 {
            dismissGKTooltip()
            return
        }
        currentNodeIndex -= 1
        showGKTooltip()
    }
    
    func executeGKTooltipCompletionHandler() {
        let node = dataSource.gkTooltipNodes[currentNodeIndex]
        node.completionHandler?()
    }
    
    func showGKTooltip() {
        let node = dataSource.gkTooltipNodes[currentNodeIndex]
        let isEnableAutomaticScroll = ifNeedAutomaticScroll(with: node.target)
        
        if let targetView = isEnableAutomaticScroll.targetView, isEnableAutomaticScroll.ifNeed {
            _ = self.gkTooltipView.disappear(node)
            self.clearTip()
            scrollView?.scrollTo(item: targetView, with: {
                self.gkTooltipMoving(with: node, with: true, isHighlightedWithOneNode: self.dataSource.isHighlightedWithOneNode)
            })
        } else {
            gkTooltipMoving(with: node, with: false, isHighlightedWithOneNode: dataSource.isHighlightedWithOneNode)
        }
        
        let newNodeIndex = currentNodeIndex + 1
        delegate?.didAdvance(to: newNodeIndex, of: dataSource.gkTooltipNodes.count)
    }
    
    func gkTooltipMoving(with node: GKTooltipNode, with isScrolling: Bool, isHighlightedWithOneNode: Bool = false) {
        if self.dataSource.gkTooltipNodes.count == 1 {
            if !isHighlightedWithOneNode {
                self.view.backgroundColor = GKTooltip.backgroundColor.withAlphaComponent(0.5)
            }
            switch self.currentNodeIndex {
            case 0:
                if isHighlightedWithOneNode {
                    _ = self.gkTooltipView.appear(node)
                }
                self.showTip(gkTooltipTarget: node.target)
            case let index where index == self.dataSource.gkTooltipNodes.count:
                self.clearTip()
            default:
                self.showTip(gkTooltipTarget: node.target)
            }
        } else {
            switch self.currentNodeIndex {
            case 0:
                _ = self.gkTooltipView.appear(node)
                self.showTip(gkTooltipTarget: node.target)
            case let index where index == self.dataSource.gkTooltipNodes.count:
                _ = self.gkTooltipView.disappear(node)
                self.clearTip()
            default:
                if isScrolling {
                    _ = self.gkTooltipView.appear(node)
                } else {
                    _ = self.gkTooltipView.move(node)
                }
                self.showTip(gkTooltipTarget: node.target)
            }
        }
    }
    
    func ifNeedAutomaticScroll(with target: GKTooltipTarget) -> (ifNeed: Bool,targetView: UIView?) {
        if let scrollView = self.scrollView {
            return (!scrollView.isVisible(view: target.targetView), target.targetView)
        }
        return (false, nil)
    }
    
    func dismissGKTooltip() {
        self.view.backgroundColor = .clear
        clearTip()
        dismiss(animated: true, completion: nil)
        delegate?.didDismiss()
    }
}
