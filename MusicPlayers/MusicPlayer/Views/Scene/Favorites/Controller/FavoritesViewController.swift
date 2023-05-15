//
//  FavoritesViewController.swift
//  MusicPlayer
//
//  Created by Şehriban Yıldırım on 8.05.2023.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    var favoriteList  : [Track]  = [Track]()
    var albumImage    : String?
    
    // Views
    
    private let favoriteTable : UITableView = {
        
        let table = UITableView()
        table.register(AlbumDetailCell.self, forCellReuseIdentifier: AlbumDetailCell.identifier)
        return table
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.initialize()
    }
    
    // Initialize
    
    func initialize(){
        
        view.backgroundColor = .secondarySystemBackground
        title                = "Favorites"
        
        favoriteTable.delegate   = self
        favoriteTable.dataSource = self
        view.addSubview(favoriteTable)
        self.fetchLocalStorageForDownload()
        NotificationCenter.default.addObserver(forName: Notification.Name("downloaded"), object: nil, queue: nil) { _ in
            self.fetchLocalStorageForDownload()
        }
        
    }
    
    // Set TableView Position and Size
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        favoriteTable.frame = view.bounds
    }
    
    // GET API
    
    public func fetchLocalStorageForDownload(){
        DataPersistenceManager.shared.fetchingTitlesFromDatabase { result in
            switch result{
            case .success(let favorite):
                self.favoriteList = favorite
                DispatchQueue.main.async {
                    self.favoriteTable.reloadData()
                }
               
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    public func fetchDeleteLocalStorageForDownload(Int indexPath : IndexPath){
        DataPersistenceManager.shared.deleteTitleWith(model: favoriteList[indexPath.row]) { result in
            switch result{
            case .success():
                print("Deleted fromt the database")
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.favoriteList.remove(at: indexPath.row)
            self.favoriteTable.reloadData()
            
            
        }
        
    }
}

extension FavoritesViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumDetailCell.identifier, for: indexPath) as? AlbumDetailCell else { return UITableViewCell()}
        let selectedArtist     = favoriteList[indexPath.row]
        cell.configure(with: AlbumDetailViewModel(nameLabel: selectedArtist.title!, pictureURL: "RickandMorty", duration: Int(selectedArtist.duration)))
        
        cell.favoriteTitleButton.tag = indexPath.row
        cell.favoriteTitleButton.setImage(UIImage(systemName: "heart.fill")?.withConfiguration(UIImage.SymbolConfiguration(pointSize: 25)), for: .normal)
        cell.favoriteTitleButton.addTarget(self, action: #selector(heartButtonTapped(_:)), for: .touchUpInside)
        return cell
    }
    
    @objc func heartButtonTapped(_ sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        if let cell = favoriteTable.cellForRow(at: indexPath) as? AlbumDetailCell {
            
            if let currentImage = cell.favoriteTitleButton.currentImage
            {
                let symbolConfig = UIImage.SymbolConfiguration(pointSize: 25)
                let resizedHeartImage = UIImage(systemName: "heart")!.withConfiguration(symbolConfig)
                let resizedHeartFillImage = UIImage(systemName: "heart.fill")!.withConfiguration(symbolConfig)
                
                if currentImage.isEqual(resizedHeartImage) {
                    cell.favoriteTitleButton.setImage(resizedHeartFillImage, for: .normal)
                    self.fetchLocalStorageForDownload()
                   
                } else {
                    cell.favoriteTitleButton.setImage(resizedHeartFillImage, for: .normal)
                    self.fetchDeleteLocalStorageForDownload(Int: indexPath)
                    cell.favoriteTitleButton.setImage(resizedHeartImage, for: .normal)

                    
                }
            }

        }
        
    }
            
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedArtisDetail = favoriteList[indexPath.row]
        let albumVC             = MusicViewController()
        albumVC.musicName       = selectedArtisDetail.title
        albumVC.selectedMusic   = selectedArtisDetail.preview
        albumVC.configure(with: albumImage ?? "")
        navigationController?.pushViewController(albumVC, animated: true)
        
    }
    
}
