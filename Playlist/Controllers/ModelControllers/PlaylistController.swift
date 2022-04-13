//
//  PlaylistController.swift
//  Playlist
//
//  Created by Tasuku Yamamoto on 4/12/22.
//

import Foundation

class PlaylistController {
    //MARK: - Shared Instance
    static let shared = PlaylistController()
    
    //MARK: - Source of Truth
    var playlists: [Playlist] = []
    
    //MARK: - CRUD funcs
    func creatPlaylist(name: String) {
        let newPlaylist = Playlist(name: name)
        playlists.append(newPlaylist)
        saveDataToPersistenceStore()
    }
    
    func delete(playlist: Playlist) {
        guard let index = playlists.firstIndex(of: playlist) else { return }
        playlists.remove(at: index)
        saveDataToPersistenceStore()
    }
    
    //MARK: - Persistence
    //Persistence Store/location of the date
    func persistentStore() -> URL {
        //default is a singelton/shared object of filemanager
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("Playlist.json")
        return fileURL
    }
    
    //Save data
    func saveDataToPersistenceStore() {
        do{
            let data = try JSONEncoder().encode(playlists)
            try data.write(to: persistentStore())
        }catch {
            print("We had an error saving to our persistence store")
            print("Encoding Error \(error)")
            print(error.localizedDescription)
        }
    }
    
    //Load data
    func loadDataFromPersistenceStore() {
        do{
            let data = try Data(contentsOf: persistentStore())
            playlists = try JSONDecoder().decode([Playlist].self, from: data)
        }catch{
            print("We had an error loading our data from the persistence store")
            print("Decoding Error \(error)")
            print(error.localizedDescription)
        }
    }
}
