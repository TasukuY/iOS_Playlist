//
//  SongController.swift
//  Playlist
//
//  Created by Tasuku Yamamoto on 4/11/22.
//

import Foundation

class SongController {
    //Shared Instance
    static let shared = SongController()
    
    //Source of Truth
    var songs: [Song] = []
    
    //CRUD - Create, Read, Update, Delete
    //Create
    func createSong(title: String, artirst: String){
        let newSong = Song(title: title, artist: artirst)
        songs.append(newSong)
        saveDataToPersistenceStore()
    }
    
    //Delete
    func deleteSong(song: Song){
        guard let index = songs.firstIndex(of: song) else { return }
        songs.remove(at: index)
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
            let data = try JSONEncoder().encode(songs)
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
            songs = try JSONDecoder().decode([Song].self, from: data)
        }catch{
            print("We had an error loading our data from the persistence store")
            print("Decoding Error \(error)")
            print(error.localizedDescription)
        }
    }
}
