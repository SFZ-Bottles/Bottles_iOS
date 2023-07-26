import UIKit
import Alamofire

class SignUpViewController: UIViewController {
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var introduceTextView: UITextView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var joinUsButton: UIButton!
    @IBOutlet weak var checkUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpBorder()
        setUpButton()
        setTextFieldDelegate()
        welcomeLabel.font = .boldSystemFont(ofSize: 32)
    }
    
    func setUpBorder() {
        let views: [UIView] = [idTextField, passwordTextField, nameTextField, emailTextField, introduceTextView]
        
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
    
    func setTextFieldDelegate() {
        idTextField.delegate = self
        passwordTextField.delegate = self
        nameTextField.delegate = self
        emailTextField.delegate = self
    }
    
    func checkID(id: String) {
        let url: String = "http://14.4.145.80:8000/api/users/check-duplicate-id/\(id)/"
        
        AF.request(url, method: .get).response { response in
            guard let statusCode = response.response?.statusCode else { return }
            
            switch statusCode {
            case 200:
                self.showAlert(title: "ok, available id")
                return
            case 409:
                self.showAlert(title: "already exist id")
                return
            default:
                return
            }
        }
    }
    
    func getID() {
        guard let id = idTextField.text,
              let pw = passwordTextField.text,
              let name = nameTextField.text,
              let email = emailTextField.text,
              let info = introduceTextView.text
        else { return }
        
        guard id.count != 0,
              pw.count != 0,
              name.count != 0,
              email.count != 0,
              info.count != 0
        else { return }
        
        if id.count > 30 || info.count > 150 {
            showAlert(title: "회원가입 요청 중 id, preface의 길이가 오버되었다")
            guard id.count < 31 || info.count < 150 else { return }
        }
        
        let url: String = "http://14.4.145.80:8000/api/users/"
        let param: Parameters = [
            "id": id,
            "pw": pw,
            "name": name,
            "email": email,
            "info": info
        ]
        
        AF.request(url, method: .post, parameters: param, encoding: JSONEncoding.default).response { response in
            guard let statusCode = response.response?.statusCode else { return }
            guard let result = response.data else { return }
            print(statusCode)
            switch statusCode {
            case 200:
                self.showAlert(title: "register successfully.")
            case 409:
                do {
                    let errorData = try JSONDecoder().decode(Error.self, from: result)
                    
                    if errorData.error == "already exist id" {
                        self.showAlert(title: errorData.error)
                    } else if errorData.error == "already exist email" {
                        self.showAlert(title: errorData.error)
                    }
                } catch {
                    return
                }
            default:
                return
            }
        }
    }
    
    @IBAction func checkIdButton(_ sender: UIButton) {
        guard let idText = idTextField.text else { return }
        guard idText.count != 0 else { return }
        
        checkID(id: idText)
    }
    
    @IBAction func signUpButton(_ sender: UIButton) {
        getID()
    }
}
