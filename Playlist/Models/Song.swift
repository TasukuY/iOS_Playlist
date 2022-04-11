//
//  Song.swift
//  Playlist
//
//  Created by Tasuku Yamamoto on 4/11/22.
//

import Foundation

class Song: Codable {
    let songTitle: String
    let songArtist: String
    
    init(title: String, artist: String){
        self.songTitle = title
        self.songArtist = artist
    }
}//end of class

extension Song: Equatable{
    static func == (lhs: Song, rhs: Song) -> Bool{
        return lhs.songTitle == rhs.songTitle && lhs.songArtist == rhs.songArtist
    }
}
