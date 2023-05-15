//
//  CategoryCell.swift
//  MusicPlayer
//
//  Created by Şehriban Yıldırım on 8.05.2023.
//

import UIKit
import Foundation
import Kingfisher

class CategoryCell: UICollectionViewCell {
    
    static let identifier = "CategoryCell"
    
    private var blurView : UIVisualEffectView?

    // Category ImageView
    
    private let categoryImageView : UIImageView = {
        
        let imageView           = UIImageView()
        imageView.contentMode   = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
        
    }()
     
    // Create Name Label
    
    private let nameLabel: UILabel = {
        
        let label           = UILabel()
        label.textAlignment = .center
        label.textColor     = .white
        label.font          = .systemFont(ofSize: 20, weight: UIFont.Weight.bold)
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
        
    }()
    
    private let nameLabelView: UIView = {
        
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
        
    }()
    
    override init(frame: CGRect){
        
        super.init(frame: frame)
        
        self.initialize()
                
    }
    
    // Initialize
    
    func initialize(){
        
        self.prepareContentView()
                
        contentView.addSubview(categoryImageView)
        
        categoryImageView.addSubview(nameLabelView)
        
        categoryImageView.addSubview(nameLabel)
        
        self.applyConstraints()
        
        self.labelBackground()
        
    }
    
    func prepareContentView(){
                
        self.layer.cornerRadius = 15
                
    }
    
    //Label Background
    
    func labelBackground(){
        
        let blurEffect = UIBlurEffect(style: .light)
        let blurView   = UIVisualEffectView(effect: blurEffect)
        blurView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 50)
        self.blurView  = blurView
        
        nameLabelView.addSubview(blurView)
        
    }
    
    // Set ImageView Position and Size
    
    private func applyConstraints(){
        
        NSLayoutConstraint.activate([
            
            categoryImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            categoryImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            categoryImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            categoryImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0)
            
        ])
        
        NSLayoutConstraint.activate([
        
            nameLabelView.heightAnchor.constraint(equalToConstant: 50),
            nameLabelView.widthAnchor.constraint(equalTo: categoryImageView.widthAnchor, multiplier: 1),
            nameLabelView.bottomAnchor.constraint(equalTo: categoryImageView.bottomAnchor,constant: 0)
            
        ])
        
        NSLayoutConstraint.activate([
        
            nameLabel.centerXAnchor.constraint(equalTo: nameLabelView.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: nameLabelView.centerYAnchor)
            
        ])
   
    }
    
    // Configure ImageView and TitleLabel

    public func configure(with model: CategoryViewModel){

        guard let url = URL(string: model.pictureURL) else { return }
        
        categoryImageView.kf.setImage(with: url)
        
        nameLabel.text = model.nameLabel
        
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }

}

