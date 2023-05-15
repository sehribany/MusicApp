//
//  ArtistsViewController.swift
//  MusicPlayer
//
//  Created by Şehriban Yıldırım on 9.05.2023.
//

import UIKit

import UIKit

class ArtistsViewController: UIViewController {
    
    
    var artist       : [Datas] = [Datas]()
    var categoryId   : Int?
    var categoryName : String?
    
    //Views
    
    private let artistCollection : UICollectionView = {
        
        let layout                                               = UICollectionViewFlowLayout()
        layout.scrollDirection                                   = .vertical
        let collectionView                                       = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor                           = .secondarySystemBackground
        collectionView.register(ArtistsCell.self, forCellWithReuseIdentifier: ArtistsCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
        
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.initialize()
        
    }
    
    // Initialize
    
    func initialize(){
        
        view.backgroundColor = .secondarySystemBackground

        if let categoryId = categoryId {
            
            fetchArtists(forCategoryID: categoryId)
            
        }
        
        title = categoryName
        
        self.view.addSubview(artistCollection)
        
        self.collectionCostraint()
        
    }
    
    //API
    
    private func fetchArtists(forCategoryID categoryId: Int) {
        APICaller.shared.getArtist(forGenreID: categoryId) { result in
            switch result {
                
            case .success(let artists):
                
                self.artist = artists
                
                DispatchQueue.main.async {
                    
                    self.artistCollection.reloadData()
                    
                }
                
            case .failure(let error):
                
                print("Error fetching artists: \(error)")
                
            }
        }
    }
    // Collection Constrants
        
    private func collectionCostraint(){
            
        artistCollection.topAnchor.constraint(equalTo: view.topAnchor).isActive                          = true
        artistCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive    = true
        artistCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        artistCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive                    = true
            
        artistCollection.delegate   = self
        artistCollection.dataSource = self
        
    }
    
}

extension ArtistsViewController : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        return artist.count
   
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ArtistsCell.identifier, for: indexPath) as! ArtistsCell
            
        let item = artist[indexPath.item]
        cell.configure(with: CategoryViewModel(nameLabel: item.name, pictureURL: item.pictureBig))
        cell.backgroundColor = .systemBackground
        
        return cell
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width / 2 - 20, height: 250)
        
    }
        
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
            
        let config = UIContextMenuConfiguration(identifier: nil,previewProvider: nil){ _ in
                
            return UIMenu(title: "", image: nil, identifier: nil,options: .displayInline)
                
        }
        
        return config
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
        let selectedArtist     = artist[indexPath.row]
        let albumVC            = ArtistDetailViewController()
        albumVC.artistId       = selectedArtist.id
        albumVC.artistName     = selectedArtist.name
        
        navigationController?.pushViewController(albumVC, animated: true)
        
    }
        
}



