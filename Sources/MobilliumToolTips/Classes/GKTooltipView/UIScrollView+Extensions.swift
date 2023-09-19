//
//  UIScrollView+Extensions.swift
//  MobilliumGenesisKitDemo
//
//  Created by Serkan Erkan on 7.07.2023.
//  Copyright © 2023 Mobillium. All rights reserved.
//

import UIKit

public enum ScrollDirection {
    case Top
    case Right
    case Bottom
    case Left
    
    func contentOffsetWith(_ scrollView: UIScrollView) -> CGPoint {
        var contentOffset = CGPoint.zero
        switch self {
        case .Top:
            contentOffset = CGPoint(x: 0, y: -scrollView.contentInset.top)
        case .Right:
            contentOffset = CGPoint(x: scrollView.contentSize.width - scrollView.bounds.size.width, y: 0)
        case .Bottom:
            contentOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.size.height)
        case .Left:
            contentOffset = CGPoint(x: -scrollView.contentInset.left, y: 0)
        }
        return contentOffset
    }
}

extension UIScrollView {
    func scrollTo(direction: ScrollDirection, animated: Bool = true) {
        self.setContentOffset(direction.contentOffsetWith(self), animated: animated)
    }
    
    func scrollTo(item: UIView, animated: Bool = true, with completion: @escaping (() -> ())) {
        UIView.animate(withDuration: 0.3, animations: {
            self.contentOffset = self.calculateScrolingContentSize(item: item)
        }) { (success) in
            completion()
        }
    }
    
    func isVisible(view: UIView) -> Bool {
        let convertedFrame = view.convert(view.bounds, to: self)
        if self.bounds.contains(convertedFrame){
            return true
        }
        return false
    }
    
    func scrollToTop(animated: Bool) {
        let topOffset = CGPoint(x: 0, y: -contentInset.top)
        setContentOffset(topOffset, animated: animated)
    }
    
    func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height + contentInset.bottom)
        if(bottomOffset.y > 0) {
            setContentOffset(bottomOffset, animated: true)
        }
    }
    
    private func calculateScrolingContentSize(item: UIView) -> CGPoint {
        let rect = item.convert(item.bounds, to: self)
        if rect.minY + rect.height < frame.height {
            return CGPoint(x: 0, y: -contentInset.top)
        }
        else {
            let maximumBottomPadding = 40
            let bottomPadding: Int = Int(contentSize.height - (rect.minY + rect.height))
            let padding = min(maximumBottomPadding, bottomPadding)
            return CGPoint(x: 0, y: (rect.minY - self.frame.height) + rect.height + CGFloat(padding))
        }
    }
}
