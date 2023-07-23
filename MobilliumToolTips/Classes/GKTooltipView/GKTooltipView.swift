//
//  GKTooltipView.swift
//  MobilliumGenesisKitDemo
//
//  Created by Serkan Erkan on 7.07.2023.
//  Copyright © 2023 Mobillium. All rights reserved.
//

import UIKit

final class GKTooltipView: UIView {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    fileprivate func commonInit() {
        layer.mask = maskLayer
        layer.addSublayer(borderLayer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        maskLayer.frame = frame
    }

    func appear(_ node: GKTooltipNode, duration: TimeInterval = GKTooltip.animationDuration) -> CGRect {
        maskLayer.add(appearAnimation(duration, node: node, isMaskPath: true), forKey: nil)
        borderLayer.add(appearAnimation(duration, node: node, isMaskPath: false), forKey: nil)
        return node.target.targetView.frame
    }

    func disappear(_ node: GKTooltipNode, duration: TimeInterval = GKTooltip.animationDuration) -> CGRect {
        maskLayer.add(disappearAnimation(duration, node: node, isMaskPath: true), forKey: nil)
        borderLayer.add(disappearAnimation(duration, node: node, isMaskPath: false), forKey: nil)
        return node.target.targetView.frame
    }

    func move(_ toNode: GKTooltipNode, duration: TimeInterval = GKTooltip.animationDuration, moveType: GKTooltipMoveType = .direct) -> CGRect {
        switch moveType {
        case .direct:
            moveDirect(toNode, duration: duration)
        case .disappear:
            moveDisappear(toNode, duration: duration)
        }
        return toNode.target.targetView.frame
    }

    fileprivate lazy var maskLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillRule = CAShapeLayerFillRule.evenOdd
        layer.fillColor = UIColor.black.cgColor
        return layer
    }()
    
    fileprivate lazy var borderLayer: CAShapeLayer = {
        let layer = CAShapeLayer()
        layer.fillRule = CAShapeLayerFillRule.nonZero
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.lightGray.cgColor
        layer.lineWidth = 3.0

        return layer
    }()
}

private extension GKTooltipView {
    func moveDirect(_ toNode: GKTooltipNode, duration: TimeInterval = GKTooltip.animationDuration) {
        maskLayer.add(moveAnimation(duration, toNode: toNode, isMaskPath: true), forKey: nil)
        borderLayer.add(moveAnimation(duration, toNode: toNode, isMaskPath: false), forKey: nil)
    }

    func moveDisappear(_ toNode: GKTooltipNode, duration: TimeInterval = GKTooltip.animationDuration) {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            _ = self.appear(toNode, duration: duration)
        }
        _ = disappear(toNode)
        CATransaction.commit()
    }

    func maskPath(_ path: UIBezierPath) -> UIBezierPath {
        return [path].reduce(UIBezierPath(rect: frame)) {
            $0.append($1)
            return $0
        }
    }
    
    func pathRect(_ path: UIBezierPath) -> CGRect {
        return path.bounds
    }

    func appearAnimation(_ duration: TimeInterval, node: GKTooltipNode, isMaskPath: Bool) -> CAAnimation {
        if isMaskPath {
            let beginPath = maskPath(node.target.infinitesmalPath(node: node, translater: self))
            let endPath = maskPath(node.target.path(node: node, translater: self))
            return pathAnimation(duration, beginPath: beginPath, endPath: endPath)
        }
        else {
            let beginPath = node.target.infinitesmalPath(node: node, translater: self)
            let endPath = node.target.path(node: node, translater: self)
            return pathAnimation(duration, beginPath: beginPath, endPath: endPath)
        }
    }

    func disappearAnimation(_ duration: TimeInterval, node: GKTooltipNode, isMaskPath: Bool) -> CAAnimation {
        if isMaskPath {
            let endPath = maskPath(node.target.infinitesmalPath(node: node, translater: self))
            return pathAnimation(duration, beginPath: nil, endPath: endPath)
        }
        else {
            let endPath = node.target.infinitesmalPath(node: node, translater: self)
            return pathAnimation(duration, beginPath: nil, endPath: endPath)
        }
    }

    func moveAnimation(_ duration: TimeInterval, toNode: GKTooltipNode, isMaskPath: Bool) -> CAAnimation {
        if isMaskPath {
            let endPath = maskPath(toNode.target.path(node: toNode, translater: self))
            return pathAnimation(duration, beginPath: nil, endPath: endPath)
        }
        else {
            let endPath = toNode.target.path(node: toNode, translater: self)
            return pathAnimation(duration, beginPath: nil, endPath: endPath)
        }
    }

    func pathAnimation(_ duration: TimeInterval, beginPath: UIBezierPath?, endPath: UIBezierPath) -> CAAnimation {
        let animation = CABasicAnimation(keyPath: "path")
        animation.duration = duration
        animation.timingFunction = CAMediaTimingFunction(controlPoints: 0.66, 0, 0.33, 1)
        
        if let path = beginPath {
            animation.fromValue = path.cgPath
        }
        animation.toValue = endPath.cgPath
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        return animation
    }
}

enum GKTooltipMoveType {
    case direct
    case disappear
}
