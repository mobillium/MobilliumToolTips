//
//  GKTooltipPopupView.swift
//  MobilliumGenesisKitDemo
//
//  Created by Serkan Erkan on 7.07.2023.
//  Copyright © 2023 Mobillium. All rights reserved.
//

import UIKit

protocol GKTooltipPopupDelegate {
    func buttonTapped(buttonType: GKTooltipPopupModel.ButtonType)
    func closeTapped()
    func didTapLink(index: Int)
}

class GKTooltipPopupView: UIView {
    private let containerView: UIView = UIView()
    private let iconView = UIImageView()
    private var labelTooltipText: UILabel = UILabel()
    
    private var buttonStackView = UIStackView()
    private let leftButton: UIButton = UIButton()
    private let rightButton: UIButton = UIButton()
    
    // setting popup-view height
    var bottomConstant: CGFloat {
        if buttonStackView.isHidden {
            return 8 + bubleV
        } else {
            return 64 + bubleV
        }
    }
    
    private var topConstraint = NSLayoutConstraint()
    private var bottomConstraint = NSLayoutConstraint()
    private var bottomStackViewHeightConstraint = NSLayoutConstraint()
    private var tooltipBottomLabelConstraint = NSLayoutConstraint()
    private var tooltipLabelTrailingConstraint = NSLayoutConstraint()
    private var tooltipLabelTopConstraint = NSLayoutConstraint()
    private var tooltipLabelLeadingConstraint = NSLayoutConstraint()
    
    var delegate: GKTooltipPopupDelegate?
    var dataSource: GKTooltipPopupModel? {
        didSet {
            if let dataSource = dataSource {
                setupUI(with: dataSource)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public init() {
        super.init(frame: .zero)
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        draw()
        configureUI()
        configureButtons()
    }
}

// MARK: - Private Methods -
extension GKTooltipPopupView {
    private func configureUI(){
        iconView.image = .icInfo
        iconView.tintColor = .pureBlack
        
        labelTooltipText.font = .footnote01Medium
        labelTooltipText.textColor = .pureBlack
        labelTooltipText.textAlignment = .left
        labelTooltipText.numberOfLines = 0
        
        leftButton.titleLabel?.font = UIFont.systemFont(ofSize: 12.0, weight: .regular)
        leftButton.setTitleColor(UIColor.blue, for: .normal)
        leftButton.contentHorizontalAlignment = .left
        leftButton.titleLabel?.adjustsFontSizeToFitWidth = true
        leftButton.titleLabel?.minimumScaleFactor = 0.5
        
        rightButton.titleLabel?.font = UIFont.systemFont(ofSize: 12.0, weight: .bold)
        rightButton.setTitleColor(UIColor.blue, for: .normal)
        rightButton.contentHorizontalAlignment = .right
        rightButton.titleLabel?.adjustsFontSizeToFitWidth = true
        rightButton.titleLabel?.minimumScaleFactor = 0.5
    }
    
    private func configureButtons() {
        self.leftButton.addTarget(self, action: #selector(leftButtonAction(sender:)), for: .touchUpInside)
        self.rightButton.addTarget(self, action: #selector(rightButtonAction(sender:)), for: .touchUpInside)
    }
    
    private func setupUI(with dataSource: GKTooltipPopupModel) {
        self.iconView.isHidden = dataSource.isIconViewHidden
        self.labelTooltipText.text = dataSource.tooltipText
        self.leftButton.setTitle(dataSource.leftButtonText, for: .normal)
        self.rightButton.setTitle(dataSource.rightButtonText, for: .normal)
        self.leftButton.isHidden = dataSource.isLeftButtonHidden
        self.rightButton.isHidden = dataSource.isRightButtonHidden
        
        // hide-show left-right buttons
        if dataSource.isLeftButtonHidden && dataSource.isRightButtonHidden {
            buttonStackView.isHidden = true
            bottomStackViewHeightConstraint.constant = 20
            
        } else {
            buttonStackView.isHidden = false
            bottomStackViewHeightConstraint.constant = stackViewHeight
        }
        
        // hide-show icon
        if dataSource.isIconViewHidden {
            NSLayoutConstraint.deactivate([tooltipLabelLeadingConstraint])
            tooltipLabelLeadingConstraint = labelTooltipText.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
            tooltipLabelLeadingConstraint.isActive = true
        } else {
            NSLayoutConstraint.deactivate([tooltipLabelLeadingConstraint])
            tooltipLabelLeadingConstraint = labelTooltipText.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 16)
            tooltipLabelLeadingConstraint.isActive = true
        }
    }
    
    private func updateConstraint(bottomPadding: CGFloat, topPadding: CGFloat) {
        self.bottomConstraint.constant = bottomPadding
        self.topConstraint.constant = topPadding
    }
}

// MARK: - Public Methods -
extension GKTooltipPopupView {
    public func getRect() -> CGRect {
        let tooltipLabelSize: CGSize = labelTooltipText.sizeThatFits(self.maximumSize)
        let totalHeight = topConstant + (tooltipLabelSize.height) + bottomConstant
        
        return CGRect(x: 0, y: 0, width: self.maximumWidth, height: totalHeight)
    }
    
    public func configure(with model: GKTooltipPopupModel) {
        self.dataSource = model
        
        setButtonTintColors(leftButtonTintColor: model.leftButtonTintColor,
                            rightButtonTintColor: model.rightButtonTintColor)
    }
    
    public func updatePadding(by arrowPosition: EasyTipView.ArrowPosition) {
        var bottomPadding = self.bottomConstant
        var topPadding = self.topConstant
        switch arrowPosition {
        case .bottom:
            bottomPadding = self.bottomConstant + self.arrowHeight
            topPadding = self.topConstant - self.arrowHeight
        case .top, .any:
            bottomPadding = self.bottomConstant
            topPadding = self.topConstant
        default: break
        }
        updateConstraint(bottomPadding: -bottomPadding, topPadding: topPadding)
    }
    
    func showIconView() {
        iconView.isHidden = false
    }
    
    func hideIconView() {
        iconView.isHidden = true
    }
    
    func setButtonTintColors(leftButtonTintColor: UIColor, rightButtonTintColor: UIColor) {
        leftButton.setTitleColor(leftButtonTintColor, for: .normal)
        rightButton.setTitleColor(rightButtonTintColor, for: .normal)
    }
}

// MARK: - Drawing -
extension GKTooltipPopupView: GKTooltipPopupViewConstant {
    func draw() {
        topBottomConstraints()
        buttonStack()
        leftIcon()
        tooltipText()
    }
    
    func topBottomConstraints() {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        topConstraint = containerView.topAnchor.constraint(equalTo: topAnchor, constant: self.topConstant)
        topConstraint.isActive = true

        bottomConstraint = containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: self.bottomConstant)
        bottomConstraint.isActive = true
        containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: self.leadingConstant).isActive = true
        containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -self.trailingConstant).isActive = true
    }
    
    func buttonStack() {
        addSubview(buttonStackView)
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.distribution = .fillProportionally
        buttonStackView.axis = .horizontal
        buttonStackView.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 8).isActive = true
        buttonStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        buttonStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        
        buttonStackView.addArrangedSubview(leftButton)
        buttonStackView.addArrangedSubview(rightButton)
        leftButton.setContentHuggingPriority(.required, for: .horizontal)
        rightButton.setContentHuggingPriority(.required, for: .horizontal)
        
        bottomStackViewHeightConstraint = buttonStackView.heightAnchor.constraint(equalToConstant: stackViewHeight)
        bottomStackViewHeightConstraint.isActive = true
    }
    
    func leftIcon() {
        containerView.addSubview(iconView)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true
        iconView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        iconView.widthAnchor.constraint(equalToConstant: 16).isActive = true
        iconView.heightAnchor.constraint(equalToConstant: 16).isActive = true
    }
    
    func tooltipText() {
        containerView.addSubview(labelTooltipText)
        labelTooltipText.translatesAutoresizingMaskIntoConstraints = false
        tooltipLabelTopConstraint = labelTooltipText.topAnchor.constraint(equalTo: containerView.topAnchor)
        tooltipLabelTopConstraint.isActive = true
        
        labelTooltipText.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 16).isActive = true
        labelTooltipText.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        tooltipLabelTrailingConstraint = labelTooltipText.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        tooltipLabelTrailingConstraint.isActive = true
        
        tooltipBottomLabelConstraint = labelTooltipText.bottomAnchor.constraint(equalTo: buttonStackView.topAnchor, constant: -buttonSpacing)
        tooltipBottomLabelConstraint.isActive = true
        
        labelTooltipText.setContentHuggingPriority(.required, for: .vertical)
        labelTooltipText.setContentCompressionResistancePriority(.required, for: .vertical)
    }
}

// MARK: - Actions -
extension GKTooltipPopupView {
    
    @objc func leftButtonAction(sender: UIButton) {
        if let source = dataSource {
            delegate?.buttonTapped(buttonType: source.leftButtonType)
        }
    }
    
    @objc func rightButtonAction(sender: UIButton) {
        if let source = dataSource {
            delegate?.buttonTapped(buttonType: source.rightButtonType)
        }
    }
}
