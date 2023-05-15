//
//  APICaller.swift
//  MusicPlayer
//
//  Created by Şehriban Yıldırım on 8.05.2023.
//

import Foundation

//Constants

struct Constants {
    static let baseURL = "https://api.deezer.com/"
}

class APICaller {
    
    static let shared = APICaller()
    
    
    // Get Music Category API

    func getCategory(compleation : @escaping (Result < [Data], Error >) ->Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)genre") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data  = data, error == nil else{ return }
            
            do{
                
                let results = try JSONDecoder().decode(Category.self, from: data)
                compleation(.success(results.data))
                
            }catch{
                compleation(.failure(error))
            }
            
        }
        task.resume()
    }
    
    // Get Artist API
    
    func getArtist(forGenreID genreID: Int, compleation : @escaping (Result < [Datas], Error >) ->Void){
        
        guard let url = URL(string: "\(Constants.baseURL)genre/\(genreID)/artists") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data  = data, error == nil else{ return }
            
            do{
                
                let results = try JSONDecoder().decode(Artist.self, from: data)
                compleation(.success(results.data))
                
            }catch{
                compleation(.failure(error))
            }
            
        }
        task.resume()
    }
    
    // Get Album API
    
    func getAlbums(forGenreID genreID: Int, compleation : @escaping (Result < Album, Error >) ->Void){
        
        guard let url = URL(string: "\(Constants.baseURL)artist/\(genreID)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data  = data, error == nil else{ return }
            
            do{
                
                let results = try JSONDecoder().decode(Album.self, from: data)
                compleation(.success(results))
                
            }catch{
                compleation(.failure(error))
            }
            
        }
        task.resume()
    }
    
    // Get ArtistDetail API
    
    func getArtistDetail(forGenreID genreID: Int,compleation : @escaping (Result < [ArtistDetailData], Error >) ->Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)artist/\(genreID)/albums") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data  = data, error == nil else{ return }
            
            do{
                
                let results = try JSONDecoder().decode(ArtistDetail.self, from: data)
                compleation(.success(results.data))
                
            }catch{
                compleation(.failure(error))
            }
            
        }
        task.resume()
    }
    
    // Get AlbumDetail API
    
    func getAlbumDetail(forGenreID genreID: Int,compleation : @escaping (Result < [AlbumDetailData], Error >) ->Void) {
        
        guard let url = URL(string: "\(Constants.baseURL)album/\(genreID)/tracks") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data  = data, error == nil else{ return }
            
            do{
                
                let results = try JSONDecoder().decode(AlbumDetail.self, from: data)
                compleation(.success(results.data))
                
            }catch{
                compleation(.failure(error))
            }
            
        }
        task.resume()
    }
    
}
