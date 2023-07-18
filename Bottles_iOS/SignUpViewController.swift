import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var introduceTextField: UITextField!
    @IBOutlet weak var joinUsButton: UIButton!
    @IBOutlet weak var checkUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpBorder()
        setUpButton()
        welcomeLabel.font = .boldSystemFont(ofSize: 32)
    }
    
    func setUpBorder() {
       let views: [UIView] = [idTextField, passwordTextField, nameTextField, emailTextField, introduceTextField]
        
        views.forEach {
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.black.cgColor
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
        }
    }
    
    func setUpButton() {
        joinUsButton.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        joinUsButton.layer.cornerRadius = 15
        joinUsButton.layer.masksToBounds = true
        
        let content: String = "check up"
        let buttonAttrubutedTitle = NSMutableAttributedString(string: content, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 11)])
        buttonAttrubutedTitle.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: (content as NSString).range(of: content))
        
        checkUpButton.setAttributedTitle(buttonAttrubutedTitle, for: .normal)
    }
}
