import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var settingsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
    }
    
    func setTableView() {
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.settingsTableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath) as? SettingsCell else { return UITableViewCell() }
        
        if indexPath.row == 0 {
            cell.contentLabel.text = "개인정보 편집"
        } else if indexPath.row == 1 {
            cell.contentLabel.text = "Bottles란?"
        } else if indexPath.row == 2 {
            cell.contentLabel.text = "SFZ란?"
        } else {
            cell.contentLabel.text = "회원탈퇴"
        }
        
        return cell
    }
}

class SettingsCell: UITableViewCell {
    @IBOutlet weak var contentLabel: UILabel!
}
