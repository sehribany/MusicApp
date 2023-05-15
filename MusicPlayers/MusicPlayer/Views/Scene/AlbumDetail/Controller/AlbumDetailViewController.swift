//
//  AlbumDetailViewController.swift
//  MusicPlayer
//
//  Created by Şehriban Yıldırım on 12.05.2023.
//

import UIKit

class AlbumDetailViewController: UIViewController {
    
    var albumId    : Int?
    var albumName  : String?
    var albumImage : String?
    var musicList  : [AlbumDetailData]  = [AlbumDetailData]()
    var favoriteList  : [Track]  = [Track]()
    
    // Views
    
    public let musicTable : UITableView = {
        
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
        title                = albumName
        
        musicTable.delegate   = self
        musicTable.dataSource = self
        
        self.fetchMusic()
        
        view.addSubview(musicTable)
        
    }
    
    // Set TableView Position and Size
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        musicTable.frame = view.bounds
    }
    
    // GET API
    
    private func fetchMusic(){
        
        APICaller.shared.getAlbumDetail(forGenreID: albumId!){ [weak self] result in
            
            switch result {
            case .success(let musicData):
                self?.musicList = musicData
                DispatchQueue.main.async {
                    self!.musicTable.reloadData()
                }
            case .failure(let error):
                print("Failed to fetch data:", error)
            }
            
        }
    }
    
    private func downloadTitleAt(indexPath : IndexPath){
        
        DataPersistenceManager.shared.downloadTitleWith(model: musicList[indexPath.row]) { result in
            switch result{
            case.success():
                NotificationCenter.default.post(name: Notification.Name("downloaded"), object: nil)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
    

extension AlbumDetailViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumDetailCell.identifier, for: indexPath) as? AlbumDetailCell else { return UITableViewCell()}
        let selectedArtist     = musicList[indexPath.row]
        cell.configure(with: AlbumDetailViewModel(nameLabel: selectedArtist.title, pictureURL: albumImage!, duration: selectedArtist.duration))
        cell.favoriteTitleButton.tag = indexPath.row
        cell.favoriteTitleButton.addTarget(self, action: #selector(heartButtonTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func heartButtonTapped(_ sender: UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        if let cell = musicTable.cellForRow(at: indexPath) as? AlbumDetailCell {
            
            if let currentImage = cell.favoriteTitleButton.currentImage
            {
                let symbolConfig = UIImage.SymbolConfiguration(pointSize: 25)
                let resizedHeartImage = UIImage(systemName: "heart")!.withConfiguration(symbolConfig)
                let resizedHeartFillImage = UIImage(systemName: "heart.fill")!.withConfiguration(symbolConfig)
                
                
                if currentImage.isEqual(resizedHeartImage) {
                    cell.favoriteTitleButton.setImage(resizedHeartFillImage, for: .normal)
                    self.downloadTitleAt(indexPath: indexPath)
                    
                } else {
                    cell.favoriteTitleButton.setImage(resizedHeartImage, for: .normal)
                    let vc = FavoritesViewController()
                    vc.fetchDeleteLocalStorageForDownload(Int: indexPath)
                
                }
                
            }
            
        }
    }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 150
        }
        
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            let selectedArtisDetail = musicList[indexPath.row]
            let albumVC             = MusicViewController()
            albumVC.musicName       = selectedArtisDetail.title
            albumVC.selectedMusic   = selectedArtisDetail.preview
            albumVC.configure(with: albumImage!)
            navigationController?.pushViewController(albumVC, animated: true)
            
        }
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            
            return 40
            
        }
        
    }

