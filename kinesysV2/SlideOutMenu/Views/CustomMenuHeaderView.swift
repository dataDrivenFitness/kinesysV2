//
//  CustomMenuHeaderView.swift
//  SlideOutMenuLBTA
//
//  Created by Brian Voong on 10/2/18.
//  Copyright © 2018 Brian Voong. All rights reserved.
//

import UIKit

class CustomMenuHeaderView: UIView {
    
    let logoLabel: UILabel = {
        let label = UILabel()
        label.text = "KINESYS"
        label.font = UIFont(name: "Avenir-Light", size: 24)
        label.textColor = .orange
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Alex Ocasio-Cortez"
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        return label
    }()
    
    let profileImageView: ProfileImageView = {
        let iv = ProfileImageView()
        iv.image = UIImage(named: "alexOC_profile")
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 80 / 2
        iv.clipsToBounds = true
        iv.backgroundColor = .red
        return iv
    }()
    
    let settingsButton: UIButton = {
        let button = UIButton()
        let iconSize: CGFloat = 30
        let image = #imageLiteral(resourceName: "settings").withRenderingMode(.alwaysTemplate)
        button.tintColor = UIColor.darkGray
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(handleGoToSettings), for: .touchUpInside)
        button.widthAnchor.constraint(equalToConstant: iconSize).isActive = true
        button.heightAnchor.constraint(equalToConstant: iconSize).isActive = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupStackView()
    }
    
    @objc fileprivate func handleGoToSettings() {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingController)?.closeMenu()
    }
    
    fileprivate func setupStackView() {
        // this is a spacing hack with UIView
        let imageStackView = UIStackView(arrangedSubviews: [UIView(), profileImageView, UIView()])
        imageStackView.distribution = .equalCentering
        
        let nameStackView = UIStackView(arrangedSubviews: [UIView(), nameLabel, UIView()])
        nameStackView.distribution = .equalCentering
        
        let logoStackView = UIStackView(arrangedSubviews: [logoLabel, UIView(), settingsButton])
        logoStackView.distribution = .equalCentering

        let overallStackView = UIStackView(arrangedSubviews: [
            logoStackView,
            UIView(),
            imageStackView,
            SpacerView(space: 4),
            nameStackView
            ])
        
        overallStackView.axis = .vertical
        overallStackView.spacing = 8
        
        addSubview(overallStackView)
        overallStackView.translatesAutoresizingMaskIntoConstraints = false
        overallStackView.fillSuperview()
        
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
