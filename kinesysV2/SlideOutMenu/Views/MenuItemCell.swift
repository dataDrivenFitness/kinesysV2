//
//  MenuCell.swift
//  kinesysV2
//
//  Created by Chris Davis on 1/19/19.
//  Copyright © 2019 Chris Davis. All rights reserved.
//

import UIKit

class IconImageView: UIImageView {
    override var intrinsicContentSize: CGSize {
        return .init(width: 44, height: 44)
    }
    
}

class MenuItemCell: UITableViewCell {
    
    let iconImageView: IconImageView = {
        let iv = IconImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = #imageLiteral(resourceName: "home").withRenderingMode(.alwaysTemplate)
        iv.tintColor = UIColor.darkGray
        return iv
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    let bgView: UIView = {
        let v = UIView()
        v.backgroundColor = .orange
//        v.layer.cornerRadius = 25
        return v
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .default
        
        setupStackView()
        
        setupBackgroundView()
        
    }
    
    fileprivate func setupStackView() {
        let stackView = UIStackView(arrangedSubviews: [SpacerView(space: 4), iconImageView, titleLabel, UIView()])
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 12
        stackView.fillSuperview()
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = .init(top: 4, left: 12, bottom: 4, right: 12)
    }
    
    fileprivate func setupBackgroundView() {
        addSubview(bgView)
        bgView.fillSuperview(padding: .init(top: 0, left: 12, bottom: 0, right: 12))
        sendSubviewToBack(bgView)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        bgView.isHidden = !selected
        titleLabel.textColor = selected ? UIColor.white : UIColor.black
        iconImageView.tintColor = selected ? UIColor.white : UIColor.darkGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
