//
//  ArtistDetailViewController.swift
//  MusicPlayer
//
//  Created by Şehriban Yıldırım on 9.05.2023.
//

import UIKit
import Kingfisher

class ArtistDetailViewController: UIViewController {
    
    var artistId   : Int?
    var artistName : String?
    var albumList  : [ArtistDetailData]  = [ArtistDetailData]()
    
    //Views
    
    private var headerView : HeroHeaderView?
    
    private let albumTable : UITableView = {
        
        let table = UITableView()
        table.register(ArtistDetailCell.self, forCellReuseIdentifier: ArtistDetailCell.identifier)
        table.separatorStyle = .none
        return table
        
    }()
    

    override func viewDidLoad(){
        
        super.viewDidLoad()

        self.initialize()
    }
    
    //Initialize
    
    func initialize(){
        
        albumTable.dataSource = self
        albumTable.delegate   = self
        
        self.fetchAlbum()
        
        view.backgroundColor = .secondarySystemBackground
        
        if let artistId = artistId {
            
            fetchArtistsImage(forArtistID: artistId)
            
        }
        
        title  = artistName
        
        view.addSubview(albumTable)
        
        self.headerViewConstrant()
        
    }
    
    // HeaderView Constrant
    
    private func headerViewConstrant(){
        
        let statusBarHeight  = UIApplication.shared.statusBarFrame.height
        let navigationHeight = navigationController?.navigationBar.frame.height ?? 0

        headerView = HeroHeaderView(frame: CGRect(x: 0, y: statusBarHeight + navigationHeight, width: view.bounds.width, height: 450))
        albumTable.tableHeaderView = headerView
        
    }
    
    // Set TableView Position and Size
    
    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
        
        albumTable.frame = view.bounds
    }
    
    // Get API
    
    private func fetchArtistsImage(forArtistID artistId: Int) {
        
        APICaller.shared.getAlbums(forGenreID: artistId) { result in
            
            switch result {
                
            case .success(let album):
                
                self.headerView?.configure(with: album.pictureBig)
            
            case .failure(let error):
                
                print(error.localizedDescription)
                
            }
        }
    }
    
    private func fetchAlbum(){
        
        APICaller.shared.getArtistDetail(forGenreID: artistId!) { [weak self] result in
            
            switch result {
                
            case .success(let albumData):
                
                self?.albumList = albumData
                
                DispatchQueue.main.async {
                    
                    self!.albumTable.reloadData()
                    
                }
                
            case .failure(let error):
                
                print("Failed to fetch data:", error)
                
            }
        }
    }
    
}
    
extension ArtistDetailViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return albumList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArtistDetailCell.identifier, for: indexPath) as? ArtistDetailCell else { return UITableViewCell()}
        
        let selectedArtist = albumList[indexPath.row]
        
        cell.configure(with: AlbumViewModel(nameLabel: selectedArtist.title, pictureURL: selectedArtist.cover_big, releaseDate: selectedArtist.release_date))
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedArtisDetail = albumList[indexPath.row]
        let albumVC             = AlbumDetailViewController()
        albumVC.albumId         = selectedArtisDetail.id
        albumVC.albumName       = selectedArtisDetail.title
        albumVC.albumImage      = selectedArtisDetail.cover_big
        
        navigationController?.pushViewController(albumVC, animated: true)
    
    }
        
}
