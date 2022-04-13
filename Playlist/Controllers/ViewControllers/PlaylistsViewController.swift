//
//  PlaylistsViewController.swift
//  Playlist
//
//  Created by Tasuku Yamamoto on 4/12/22.
//

import UIKit

class PlaylistsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //MARK: - IBOutlets
    @IBOutlet weak var playlistNameTextField: UITextField!
    @IBOutlet weak var playlistTableView: UITableView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        playlistTableView.delegate = self
        playlistTableView.dataSource = self
        PlaylistController.shared.loadDataFromPersistenceStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playlistTableView.reloadData()
    }
    
    //MARK: - IBActions
    @IBAction func addPlaylistButtonTapped(_ sender: Any) {
        guard let playlistName = playlistNameTextField.text, !playlistName.isEmpty else { return }
        PlaylistController.shared.creatPlaylist(name: playlistName)
        playlistTableView.reloadData()
        playlistNameTextField.text = ""
    }
    
    //MARK: - TableView Data Source Funcs
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlaylistController.shared.playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = playlistTableView.dequeueReusableCell(withIdentifier: "playlistCell", for: indexPath)
        
        let playlist = PlaylistController.shared.playlists[indexPath.row]
        cell.textLabel?.text = playlist.name
        
        if playlist.songs.count == 1 {
            cell.detailTextLabel?.text = "1 Song"
        }else{
            cell.detailTextLabel?.text = "\(playlist.songs.count) Songs"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let playlistToDelete = PlaylistController.shared.playlists[indexPath.row]
            PlaylistController.shared.delete(playlist: playlistToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //IIDOO
        if segue.identifier == "toSongsList" {
            guard let indexPath = playlistTableView.indexPathForSelectedRow,
                  let destination = segue.destination as? SongListTableViewController else { return }
            
            let playlistToSend = PlaylistController.shared.playlists[indexPath.row]
            destination.playlist = playlistToSend
        }
    }

}//End of class
