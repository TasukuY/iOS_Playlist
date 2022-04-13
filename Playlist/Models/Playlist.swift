//
//  Playlist.swift
//  Playlist
//
//  Created by Tasuku Yamamoto on 4/12/22.
//

import Foundation

class Playlist: Codable, Equatable {
    let name: String
    var songs: [Song]
    
    //This will let you have two init options initi with name argument or init with name and songs arguments
    init(name: String, songs: [Song] = []){
        self.name = name
        self.songs = songs
    }
    
    static func ==(lhs: Playlist, rhs: Playlist) -> Bool {
        return lhs.name == rhs.name && lhs.songs == rhs.songs
    }
}
