//
//  SongController.swift
//  Playlist
//
//  Created by Tasuku Yamamoto on 4/11/22.
//

import Foundation

class SongController {
    
    //CRUD - Create, Read, Update, Delete
    //Create
    static func createSong(title: String, artirst: String, playlist: Playlist){
        let newSong = Song(title: title, artist: artirst)
        playlist.songs.append(newSong)
        PlaylistController.shared.saveDataToPersistenceStore()
    }
    
    //Delete
    static func deleteSong(song: Song, playlist: Playlist){
        guard let index = playlist.songs.firstIndex(of: song) else { return }
        playlist.songs.remove(at: index)
        PlaylistController.shared.saveDataToPersistenceStore()
    }
}
