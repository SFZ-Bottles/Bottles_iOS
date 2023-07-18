import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setColor()
        setBorder()
        setPlaceHolder()
    }
    
    func setColor() {
        loginButton.backgroundColor = UIColor.black.withAlphaComponent(0.05)
    }
    
    func setBorder() {
        idTextField.layer.borderWidth = 1
        idTextField.layer.borderColor = UIColor.black.cgColor
        idTextField.layer.cornerRadius = 15
        idTextField.layer.masksToBounds = true
        
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.borderColor = UIColor.black.cgColor
        passwordTextField.layer.cornerRadius = 15
        passwordTextField.layer.masksToBounds = true
        
        loginButton.layer.cornerRadius = 15
        
        let lineAttribute = NSMutableAttributedString(string: "sign-up")
        lineAttribute.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, lineAttribute.length))
        signUpButton.setAttributedTitle(lineAttribute, for: .normal)
    }
    
    func setPlaceHolder() {
        idTextField.placeholder = "ID"
        passwordTextField.placeholder = "Password"
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        guard let signUpVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else { return }
        
        navigationController?.pushViewController(signUpVC, animated: true)
    }
}

