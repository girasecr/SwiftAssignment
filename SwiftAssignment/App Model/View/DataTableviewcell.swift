//
//  DataTableviewcell.swift
//  SwiftAssignment
//
//  Created by Chetan Girase on 13/04/20.
//  Copyright © 2020 Chetan Girase. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage
import SnapKit

class DataTableviewCell: UITableViewCell {
    
    //**************************************************
    // MARK: Properties/Constants
    //**************************************************
    
    struct CONSTANTS {
        static let cellIdentifier = "DataTableviewCell"
    }
    
    static func cellIdentifier()-> String {
        return CONSTANTS.cellIdentifier
    }
    
    var row:Row? {
        didSet {
            guard let rowItem = row else {return}
            titleLabel.text = rowItem.title
            descriptionLabel.text = rowItem.rowDescription
            
            if let imageURL = rowItem.imageHref {
                setImage(from: imageURL)
            }
            else {
                self.profileImageView.image = UIImage(named: "defaultthumb.png")
            }
        }
    }
    
    let profileImageView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = 5
        img.clipsToBounds = true
        
        return img
    }()
    
    let titleLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor =  .lightGray
        //label.clipsToBounds = true
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //**************************************************
    // MARK: Initializer
    //**************************************************
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(profileImageView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(descriptionLabel)
        
        setAutolayoutConstraintToViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //**************************************************
    // MARK: Private Methods
    //**************************************************
    
    private func setAutolayoutConstraintToViews() {
        //SnapKit Autolayout
        
        profileImageView.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView.snp.centerY)
            make.leading.equalTo(self.contentView.snp.leading).offset(10)
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentView.snp.top).offset(0)
            make.leading.equalTo(self.profileImageView.snp.leading).offset(70)
            make.trailing.equalTo(self.contentView.snp.trailing).offset(-10)
            make.height.equalTo(40)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(self.titleLabel.snp.bottom).offset(0)
            make.leading.equalTo(self.titleLabel.snp.leading)
            make.trailing.equalTo(self.contentView.snp.trailing).offset(-10)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-10)
            make.height.greaterThanOrEqualTo(21)
        }
    }
       
    private func setImage(from url: String) {
        guard let imageURL = URL(string: url) else { return }
        let placeholderImage = UIImage(named: "defaultthumb.png")
        
        self.profileImageView.af.setImage(withURL: imageURL, placeholderImage: placeholderImage)
    }
}
