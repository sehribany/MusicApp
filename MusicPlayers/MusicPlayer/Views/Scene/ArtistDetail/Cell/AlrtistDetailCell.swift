//
//  ArtistDetailCell.swift
//  MusicPlayer
//
//  Created by Şehriban Yıldırım on 9.05.2023.
//


import UIKit

class ArtistDetailCell: UITableViewCell {

    static let identifier = "AlbumsCell"
    
    private var blurView : UIVisualEffectView?
    
    // Views
    
    private let itemView: UIView = {
        
       let view = UIView()
        
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
        
    }()
    
    private let titleLabel : UILabel = {
        
        let label                                       = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font                                      = .systemFont(ofSize: 15.5, weight: UIFont.Weight.bold)
        label.numberOfLines                             = 0
        label.textColor = .black
        return label
        
    }()
    
    private let posterImageView : UIImageView = {
        
        let imageView                                       = UIImageView()
        imageView.contentMode                               = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds                             = true
        imageView.layer.cornerRadius                        = 10

        return imageView
        
    }()
    
    private let dateLabel : UILabel = {
        
        let label                                       = UILabel()
        label.font                                      = .systemFont(ofSize: 13, weight: UIFont.Weight.bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        
        return label
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.initialize()
        
    }

    //Initialize
    
    private func initialize(){
        
        self.prepareContentView()
                
        self.prepareItems()
                
    }
    
    func prepareContentView(){
                
        self.layer.cornerRadius = 15
                
    }
    
    func prepareItems(){
        
        contentView.addSubview(itemView)
        
        NSLayoutConstraint.activate([
            
            itemView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            itemView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            itemView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            itemView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        
        ])
        
        itemView.addSubview(posterImageView)
        
        NSLayoutConstraint.activate([
            
            posterImageView.leadingAnchor.constraint(equalTo: itemView.leadingAnchor),
            posterImageView.topAnchor.constraint(equalTo: itemView.topAnchor, constant: 10),
            posterImageView.bottomAnchor.constraint(equalTo: itemView.bottomAnchor, constant: 0),
            posterImageView.widthAnchor.constraint(equalToConstant: 100)
            
        ])
        
        itemView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
        
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
            
        ])
        
        itemView.addSubview(dateLabel)
        
        NSLayoutConstraint.activate([
        
            dateLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 20),
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 25)
            
        ])
    }
    
    // Constraints
    
    private func applyConstraints(){
    
    }
    
    // Configure ImageView and TitleLabel

    public func configure(with model: AlbumViewModel){

        guard let url   = URL(string: "\(model.pictureURL)") else { return }
        posterImageView.kf.setImage(with: url)
        titleLabel.text = model.nameLabel
        dateLabel.text  = convertDate(inputDate: model.releaseDate)
        
    }
    
    // Date Conversion
    
    func convertDate(inputDate: String) -> String? {
        
        let inputFormatter        = DateFormatter()
        inputFormatter.dateFormat = "yyyy-dd-mm"
        
        if let date = inputFormatter.date(from: inputDate) {
            
            let outputFormatter        = DateFormatter()
            outputFormatter.dateFormat = "dd.MM.yyyy"
            
            return outputFormatter.string(from: date)
            
        } else {
            
            return nil
            
        }
    }
    
    required init?(coder: NSCoder) {
        
        fatalError()
        
    }
    
}
