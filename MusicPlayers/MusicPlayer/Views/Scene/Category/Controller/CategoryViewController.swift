//
//  CategoryViewController.swift
//  MusicPlayer
//
//  Created by Şehriban Yıldırım on 8.05.2023.
//

import UIKit
import Kingfisher

class CategoryViewController: UIViewController {
        
    var categories : [Data]  = [Data]()
    
    //Views
    
    private let categoryCollection : UICollectionView = {
        
        let layout                                               = UICollectionViewFlowLayout()
        layout.scrollDirection                                   = .vertical
        let collectionView                                       = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor                           = .secondarySystemBackground
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialize()
        
    }
    
    //Initialize
    
    func initialize(){
        
        view.backgroundColor = .secondarySystemBackground
        title                = "Category"
        self.fetchCategory()
        self.view.addSubview(categoryCollection)
        self.collectionCostraint()
        
    }
    
    //API
    
    private func fetchCategory() {
        
        APICaller.shared.getCategory { [weak self] location in
            switch location{
            case .success(let categories):
                self?.categories = categories
                DispatchQueue.main.async {
                    self?.categoryCollection.reloadData()
                }
            case .failure(let error): break
                print(error.localizedDescription)
            }
        }
    }
    
    // Collection Constrants
    
    private func collectionCostraint(){
        
        categoryCollection.topAnchor.constraint(equalTo: view.topAnchor).isActive                          = true
        categoryCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive    = true
        categoryCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        categoryCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive                    = true
        
        categoryCollection.delegate   = self
        categoryCollection.dataSource = self
        
    }
}

extension CategoryViewController : UICollectionViewDelegate , UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return categories.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
        
        let item = categories[indexPath.item]
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
        
        let selectedCategory   = categories[indexPath.row]
        let artistVC           = ArtistsViewController()
        artistVC.categoryId    = selectedCategory.id
        artistVC.categoryName  = selectedCategory.name
        
        navigationController?.pushViewController(artistVC, animated: true)

    }
    
}
