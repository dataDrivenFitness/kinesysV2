//
//  ThirdPageCell.swift
//  kinesysV2
//
//  Created by Chris Davis on 2/4/19.
//  Copyright © 2019 Chris Davis. All rights reserved.
//

import UIKit

class FourthPageCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "assess2")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    let textView: UILabel = {
        let tv = UILabel()
        tv.text = "Unapologetically Better"
        tv.font = UIFont(name: "Avenir-Medium", size: 25)
        tv.textColor = .white
        return tv
    }()
    
    let descriptionView: UILabel = {
        let tv = UILabel()
        tv.numberOfLines = 2
        tv.textAlignment = .center
        tv.text = "The most advanced fitness\napp on the planet"
        tv.font = UIFont(name: "Avenir-Light", size: 18)
        tv.textColor = .white
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
    }
    fileprivate func setupViews() {
        //        backgroundColor = . blue
        addSubview(imageView)
        imageView.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 150, left: 50, bottom: 0, right: 50), size: .init(width: 300, height: 200))
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(textView)
        textView.anchor(top: imageView.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 15, left: 50, bottom: 0, right: 50))
        textView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(descriptionView)
        descriptionView.anchor(top: textView.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 15, left: 50, bottom: 0, right: 50))
        descriptionView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
