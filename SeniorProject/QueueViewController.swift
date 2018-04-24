
import UIKit
import SpotifyLogin

class QueueViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    /* TABLE DELEGATE METHODS */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let songCell = tableView.dequeueReusableCell(withIdentifier: "songCell", for: indexPath) as? SongCell
        
        songCell?.songNameLabel.text = "DEFAULT SONG NAME"
        songCell?.queuedByLabel.text = "DEFAULT USER"
        songCell?.votesLabel.text = "0"
        
        return songCell!
    }
}