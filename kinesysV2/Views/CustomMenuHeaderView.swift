//
//  CustomMenuHeaderView.swift
//  SlideOutMenuLBTA
//
//  Created by Brian Voong on 10/2/18.
//  Copyright © 2018 Brian Voong. All rights reserved.
//

import UIKit

class CustomMenuHeaderView: UIView {
    
    let logoLabel = UILabel()
    let nameLabel = UILabel()
    let coinLabel = UILabel()
    let statsLabel = UILabel()
    let profileImageView = ProfileImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupComponentProps()
        setupStackView()
    }
    
    fileprivate func setupComponentProps() {
        logoLabel.text = "KINESYS"
        logoLabel.font = UIFont(name: "Avenir-Light", size: 30)
        logoLabel.textColor = .orange
        nameLabel.text = "Alex Ocasio-Cortez"
        nameLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        coinLabel.text = "1,234,765"
        statsLabel.text = "will fill this out later"
        profileImageView.image = UIImage(named: "alexOC_profile")
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.layer.cornerRadius = 80 / 2
        profileImageView.clipsToBounds = true
        profileImageView.backgroundColor = .red
        
        setupCoinAttributedText()
        setupStatsAttributedText()
    }
    
    fileprivate func setupCoinAttributedText() {
        coinLabel.font = UIFont.systemFont(ofSize: 14)
        let attributedText = NSMutableAttributedString(string: "coins ", attributes: [.font: UIFont.systemFont(ofSize: 14, weight: .medium)])
        attributedText.append(NSAttributedString(string: "1,546,952", attributes: [.foregroundColor: UIColor.black]))
        
        coinLabel.attributedText = attributedText
    }
    
    fileprivate func setupStatsAttributedText() {
        statsLabel.font = UIFont.systemFont(ofSize: 10)
        let attributedText = NSMutableAttributedString(string: "42 ", attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .medium)])
        attributedText.append(NSAttributedString(string: "Str   ", attributes: [.foregroundColor: UIColor.black]))
        attributedText.append(NSAttributedString(string: "7091 ", attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .medium)]))
        attributedText.append(NSAttributedString(string: "Agl   ", attributes: [.foregroundColor: UIColor.black]))
        attributedText.append(NSAttributedString(string: "7091 ", attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .medium)]))
        attributedText.append(NSAttributedString(string: "End"   , attributes: [.foregroundColor: UIColor.black]))
        attributedText.append(NSAttributedString(string: "7091 ", attributes: [.font: UIFont.systemFont(ofSize: 16, weight: .medium)]))
        attributedText.append(NSAttributedString(string: "Cha", attributes: [.foregroundColor: UIColor.black]))
        
        statsLabel.attributedText = attributedText
    }
    
    fileprivate func setupStackView() {
        // this is a spacing hack with UIView
        let rightSpacerView = UIView()
        let arrangedSubviews = [
            logoLabel,
            UIStackView(arrangedSubviews: [profileImageView, rightSpacerView]),
            nameLabel,
            coinLabel,
            SpacerView(space: 12),
            statsLabel
        ]
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        stackView.axis = .vertical
        stackView.spacing = 2
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
