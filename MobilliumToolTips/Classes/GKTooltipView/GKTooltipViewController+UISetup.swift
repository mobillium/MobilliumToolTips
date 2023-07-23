//
//  GKTooltipViewController+UISetup.swift
//  MobilliumGenesisKitDemo
//
//  Created by Serkan Erkan on 7.07.2023.
//  Copyright © 2023 Mobillium. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Public Methods -
extension GKTooltipViewController {
    func setup() {
        modalPresentationStyle = .overFullScreen
    }
    
    func setupGKTooltipView() {
        gkTooltipView.frame = UIScreen.main.bounds
        gkTooltipView.backgroundColor = GKTooltip.backgroundColor.withAlphaComponent(GKTooltip.alpha)
        gkTooltipView.isUserInteractionEnabled = false
        gkTooltipPopup.delegate = self
        guard let view = view else { return }
        view.insertSubview(gkTooltipView, at: 0)
        view.addConstraints([NSLayoutConstraint.Attribute.top, .bottom, .left, .right].map {
            NSLayoutConstraint(item: view,
                               attribute: $0,
                               relatedBy: .equal,
                               toItem: gkTooltipView,
                               attribute: $0,
                               multiplier: 1,
                               constant: 0)
        })
    }
    
    func showTip(gkTooltipTarget: GKTooltipTarget) {
        clearTip()
        showTip(with: gkTooltipTarget.targetView)
    }
    
    func clearTip() {
        if let tipView = self.tipView {
            tipView.dismiss(withCompletion: {})
        }
    }
    
    func setupTapGestureRecognizer() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(GKTooltipViewController.viewTapped(_:)))
        view.addGestureRecognizer(gesture)
    }
    
    // MARK: - Private Methods -
    private func showTip(with view: UIView) {
        gkTooltipPopup.configure(with: dataSource.gkTooltipPopupModels[currentNodeIndex])
        gkTooltipPopup.frame = gkTooltipPopup.getRect()
        let preferences = getTipPrefences(bubbleHInset: gkTooltipPopup.bubleH, bubleVInset: gkTooltipPopup.bubleV)
        let tipView = EasyTipView(contentView: gkTooltipPopup, preferences: preferences, delegate: nil)
        tipView.show(forView: view)
        self.tipView = tipView
        
        // change frame according to arrow
        gkTooltipPopup.updatePadding(by: (self.tipView?.preferences.drawing.arrowPosition)!)
    }
    
    private func showTip(with barItem: UIBarItem) {
        gkTooltipPopup.configure(with: dataSource.gkTooltipPopupModels[currentNodeIndex])
        gkTooltipPopup.frame = gkTooltipPopup.getRect()
        let preferences = getTipPrefences(bubbleHInset: gkTooltipPopup.bubleH, bubleVInset: gkTooltipPopup.bubleV)
        let tipView = EasyTipView(contentView: gkTooltipPopup, preferences: preferences, delegate: nil)
        tipView.show(forItem: barItem)
        self.tipView = tipView
        
        // change padding according to arrow
        gkTooltipPopup.updatePadding(by: (self.tipView?.preferences.drawing.arrowPosition)!)
    }
    
    private func getTipPrefences(bubbleHInset: CGFloat, bubleVInset: CGFloat) -> EasyTipView.Preferences {
        var preferences = EasyTipView.globalPreferences
        preferences.drawing.backgroundColor = .pureWhite
        preferences.drawing.cornerRadius = 10
        preferences.drawing.shadowColor = .pureBlack
        preferences.drawing.shadowRadius = 14
        preferences.drawing.shadowOpacity = 0.65
        
        preferences.animating.showInitialAlpha = 0
        preferences.animating.showDuration = GKTooltip.popupAnimationDuration
        preferences.animating.dismissDuration = GKTooltip.popupAnimationDuration
        
        preferences.positioning.bubbleHInset = bubbleHInset
        preferences.positioning.bubbleVInset = 32
        
        return preferences
    }
}
