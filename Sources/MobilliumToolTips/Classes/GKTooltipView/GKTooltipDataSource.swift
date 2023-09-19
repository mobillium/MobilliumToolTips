//
//  GKTooltipDataSource.swift
//  MobilliumGenesisKitDemo
//
//  Created by Serkan Erkan on 7.07.2023.
//  Copyright © 2023 Mobillium. All rights reserved.
//

struct GKTooltipDataSource {
    var gkTooltipNodes: [GKTooltipNode] = []
    var gkTooltipPopupModels: [GKTooltipPopupModel] = []
    var isHighlightedWithOneNode: Bool = false
    
    init(_ nodes: [GKTooltipNode], isHighlightedWithOneNode: Bool = false) {
        gkTooltipNodes = nodes
        fillGKTooltipPopupModels()
        self.isHighlightedWithOneNode = isHighlightedWithOneNode
    }
    
    init() {}
    
    private mutating func fillGKTooltipPopupModels() {
        for (index, node) in gkTooltipNodes.enumerated() {
            var model = GKTooltipPopupModel(tooltipText: node.text,
                                            currentPage: index,
                                            numberOfCount: gkTooltipNodes.count,
                                            leftButtonText: node.leftButtonText,
                                            rightButtonText: node.rightButtonText,
                                            leftButtonType: node.leftButtonType,
                                            rightButtonType: node.rightButtonType,
                                            leftButtonTintColor: node.leftButtonTintColor,
                                            rightButtonTintColor: node.rightButtonTintColor)
            model.isLeftButtonHidden = node.isLeftButtonHidden
            model.isRightButtonHidden = node.isRightButtonHidden
            model.isIconViewHidden = node.isIconViewHidden
            gkTooltipPopupModels.append(model)
        }
    }
}
