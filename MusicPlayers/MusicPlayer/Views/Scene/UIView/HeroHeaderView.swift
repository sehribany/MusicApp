//
//  HeroHeaderView.swift
//  MusicPlayer
//
//  Created by Şehriban Yıldırım on 9.05.2023.
//

import UIKit

class HeroHeaderView: UIView {

    //Views
    
    private let heroImageView : UIImageView = {
        
        let imageView           = UIImageView()
        imageView.contentMode   = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image         = UIImage(named: "dune")
        return imageView
        
    }()
    
    private func addGradient(){
        
        let gradientLayer    = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.frame  = bounds
        layer.addSublayer(gradientLayer)
        
    }
    
    // Configure ImageView

    public func configure(with string: String){
        
        guard let url = URL(string: string) else { return }
        heroImageView.kf.setImage(with: url)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    // Initialize
    
    func initialize(){
        
        addSubview(heroImageView)
        self.addGradient()
        
    }
    
    // Set ImageView Position and Size
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        heroImageView.frame = bounds
        
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
