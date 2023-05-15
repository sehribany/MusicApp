//
//  FavoritesCell.swift
//  MusicPlayer
//
//  Created by Şehriban Yıldırım on 14.05.2023.
//

import UIKit

class FavoritesCell: UITableViewCell {

    static let identifier = "AlbumDetailCell"
     
     // Views
     
     public let favoriteTitleButton : UIButton = {
         
         let button                                       = UIButton()
         let image                                        = UIImage(systemName: "heart", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25))
         button.setImage(image, for: .normal)
         button.translatesAutoresizingMaskIntoConstraints = false
         button.tintColor                                 = .black
         return button
         
     }()

     
     private let titleLabel : UILabel = {
         
         let label                                       = UILabel()
         label.translatesAutoresizingMaskIntoConstraints = false
         label.font                                      = .systemFont(ofSize: 14, weight: UIFont.Weight.bold)
         return label
         
     }()
     
     private let posterImageView : UIImageView = {
         
         let imageView                                       = UIImageView()
         imageView.contentMode                               = .scaleAspectFill
         imageView.translatesAutoresizingMaskIntoConstraints = false
         imageView.clipsToBounds                             = true
         return imageView
         
     }()
    
    private let trackDurationLabel : UILabel = {
        
        let label                                       = UILabel()
        label.font                                      = .systemFont(ofSize: 15, weight: UIFont.Weight.light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
     
     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         self.initialize()
     }
     
     
     //Initialize
     
     private func initialize(){
         
         contentView.addSubview(posterImageView)
         contentView.addSubview(titleLabel)
         contentView.addSubview(favoriteTitleButton)
         contentView.addSubview(trackDurationLabel)
         
         posterImageView.layer.cornerRadius = 8
         applyConstraints()
     }
     
     // Set ImageView Position and Size
     
     override func layoutSubviews() {
         super.layoutSubviews()
         posterImageView.frame.size = CGSize(width: 105, height: 150)
     }

     // Constraints
     
     private func applyConstraints(){
         
         let posterImageViewConstraints =
         [
             posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
             posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
             posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
             posterImageView.widthAnchor.constraint(equalToConstant: 100)
         
         ]
         
         let titleLabelConstraints =
         [
             titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 20),
             titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
         ]
         
         let favoriteTitleButtonConstraints =
         [
            favoriteTitleButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25),
            favoriteTitleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
         ]
         
         let trackDurationLabelConstraints =
         [
            trackDurationLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 20),
            trackDurationLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25)
         ]
         
         
         NSLayoutConstraint.activate(posterImageViewConstraints)
         NSLayoutConstraint.activate(titleLabelConstraints)
         NSLayoutConstraint.activate(favoriteTitleButtonConstraints)
         NSLayoutConstraint.activate(trackDurationLabelConstraints)
         
     }

    
    // Toggle Heart Button
    
    func toggleHeartButton() {
        
        if let currentImage = favoriteTitleButton.currentImage
        {
            let symbolConfig = UIImage.SymbolConfiguration(pointSize: 25)
            let resizedHeartImage = UIImage(systemName: "heart")!.withConfiguration(symbolConfig)
            let resizedHeartFillImage = UIImage(systemName: "heart.fill")!.withConfiguration(symbolConfig)
            
            if currentImage.isEqual(resizedHeartImage) {
                favoriteTitleButton.setImage(resizedHeartFillImage, for: .normal)
            } else {
                favoriteTitleButton.setImage(resizedHeartImage, for: .normal)
            }
        }
    }
     
     // Configure ImageView and TitleLabel

     public func configure(with model: AlbumDetailViewModel){

        // guard let url           = URL(string: "\(model.pictureURL)") else { return }
        // posterImageView.kf.setImage(with: url)
         titleLabel.text         = model.nameLabel
         trackDurationLabel.text = secondsToMinutesSeconds(seconds:(model.duration))
    
     }
    
    public func configureImage(string: String){
        
        guard let url = URL(string: "\(string)") else { return }
        posterImageView.kf.setImage(with: url)
    }
    
    // Time Conversion
    func secondsToMinutesSeconds(seconds: Int) -> String {
        let mins = seconds / 60
        let secs = seconds % 60
        return String(format: "%d:%02d", mins, secs)
    }
     
     required init?(coder: NSCoder) {
         fatalError()
     }

}
