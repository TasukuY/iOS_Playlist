//
//  SongListTableViewController.swift
//  Playlist
//
//  Created by Tasuku Yamamoto on 4/11/22.
//

import UIKit

class SongListTableViewController: UITableViewController {
    //MARK: - Properties
    var playlist: Playlist?
    
    //MARK: - IBOutlets
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var songArtistTextField: UITextField!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - IBActions
    @IBAction func addSongButtonTapped(_ sender: Any) {
        guard let songTitle = songTitleTextField.text,
              let songArtist = songArtistTextField.text,
              !songTitle.isEmpty,
              !songArtist.isEmpty,
              let playlist = playlist else { return }
        SongController.createSong(title: songTitle, artirst: songArtist, playlist: playlist)
        songTitleTextField.text = ""
        songArtistTextField.text = ""
        tableView.reloadData()//to update the view after the user added the song
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //?? is like if. if the left hadn side condition fails, do what it says in the right hand side
        return playlist?.songs.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        guard let playlist = playlist else { return cell }
        let song = playlist.songs[indexPath.row]

        cell.textLabel?.text = song.songTitle
        cell.detailTextLabel?.text = song.songArtist
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let playlist = playlist else { return }
            // Delete the row from the data source
            let songToDelete = playlist.songs[indexPath.row]
            SongController.deleteSong(song: songToDelete, playlist: playlist)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
