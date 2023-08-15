//
//  ViewController.swift
//  MobilliumToolTips
//
//  Created by mobillium on 07/21/2023.
//  Copyright (c) 2023 mobillium. All rights reserved.
//

import UIKit
import MobilliumToolTips

class ViewController: UIViewController {

    let button1 = UIButton(type: .system)
    let button2 = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContents()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureTooltips()
    }
}

// MARK: - Private Functions -
extension ViewController {
    
    private func configureContents() {
        button1.setTitle("button", for: .normal)
        button1.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button1)
        
        button2.setTitle("button", for: .normal)
        button2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button2)

        NSLayoutConstraint.activate([
            button1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32),
            button1.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32),
            button2.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func configureTooltips() {
        let gkTooltip = GKTooltip()
        gkTooltip.startIntro(from: self, presentController: self, withNodes: self.getGKTooltipNodes(), isHighlightedWithOneNode: true)
        
    }
}

// MARK: - Tooltip Walkthrough -
extension ViewController {
    
    fileprivate func getGKTooltipNodes() -> [GKTooltipNode] {
        var nodes: [GKTooltipNode] = []

        let testNodeButton1 = GKTooltipNode(text: "Lorem ipsum dolor sit amet",
                                            target: .view(button1),
                                            roundedCorners: false,
                                            isLeftButtonHidden: true,
                                            isRightButtonHidden: true,
                                            isIconViewHidden: false,
                                            leftButtonText: "txt_again",
                                            leftButtonType: .again,
                                            leftButtonTintColor: .orange03,
                                            rightButtonText: "txt_next",
                                            rightButtonType: .next,
                                            rightButtonTintColor: .primary,
                                            frameConfiguration: .default)
        nodes.append(testNodeButton1)

        let testNodeButton2 = GKTooltipNode(text: "Lorem ipsum dolor sit amet, Lorem ipsum dolor sit amet\nLorem ipsum dolor sit amet,\n\nLorem ipsum dolor sit amet,",
                                            target: .view(button2),
                                            roundedCorners: false,
                                            isLeftButtonHidden: false,
                                            isRightButtonHidden: false,
                                            isIconViewHidden: true,
                                            leftButtonText: "txt_close",
                                            leftButtonType: .close,
                                            leftButtonTintColor: .elevation03,
                                            rightButtonText: "txt_again",
                                            rightButtonType: .again,
                                            rightButtonTintColor: .pureBlack,
                                            frameConfiguration: .none)

        nodes.append(testNodeButton2)
        
        return nodes
    }
}
