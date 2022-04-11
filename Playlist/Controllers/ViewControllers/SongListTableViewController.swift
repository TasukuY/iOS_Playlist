//
//  SongListTableViewController.swift
//  Playlist
//
//  Created by Tasuku Yamamoto on 4/11/22.
//

import UIKit

class SongListTableViewController: UITableViewController {
    //MARK: - IBOutlets
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var songArtistTextField: UITextField!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        SongController.shared.loadDataFromPersistenceStore()
    }
    
    //MARK: - IBActions
    @IBAction func addSongButtonTapped(_ sender: Any) {
        guard let songTitle = songTitleTextField.text,
              let songArtist = songArtistTextField.text,
              !songTitle.isEmpty,
              !songArtist.isEmpty else { return }
        SongController.shared.createSong(title: songTitle, artirst: songArtist)
        songTitleTextField.text = ""
        songArtistTextField.text = ""
        tableView.reloadData()//to update the view after the user added the song
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SongController.shared.songs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath)
        let song = SongController.shared.songs[indexPath.row]
        cell.textLabel?.text = song.songTitle
        cell.detailTextLabel?.text = song.songArtist
        return cell
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let songToDelete = SongController.shared.songs[indexPath.row]
            SongController.shared.deleteSong(song: songToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
