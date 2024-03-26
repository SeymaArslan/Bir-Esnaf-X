//
//  ViewController.swift
//  Bir Esnaf
//
//  Created by Seyma on 16.11.2023.
//

import UIKit
import FirebaseFirestore
import ProgressHUD

class LoginViewController: UIViewController {
    
    var compTableVC = CompanyTableViewController()
    let userVM = UserVM()
    
    //MARK: - Outlets
    // Labels
    @IBOutlet weak var emailLabelOutlet: UILabel!
    @IBOutlet weak var passwordLabelOutlet: UILabel!
    @IBOutlet weak var repeatPasswordLabelOutlet: UILabel!
    @IBOutlet weak var signUpLabel: UILabel!
    
    // Text Fields
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    // Button Outlets
    @IBOutlet weak var loginButtonOutlet: UIButton!
    @IBOutlet weak var signUpButtonOutlet: UIButton!
    @IBOutlet weak var resendEmailButtonOutlet: UIButton!
    
    @IBOutlet weak var repeatPasswordLineView: UIView!
    
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUIFor(login: true)
        setupTextFieldDelegates()
        setupBackgroundTap()
        
    }
    
    
    var  isLogin: Bool = true
    
    //MARK: - Button Actions
    @IBAction func loginButtonPressed(_ sender: Any) {
        if isDataInputedFor(type: isLogin ? "login" : "register") {
            isLogin ? loginUser() : registerUser()   // login or register func
            
        } else {
            ProgressHUD.showError("Tüm alanları doldurun.")
        }
    }
    
    @IBAction func forgotPasswordButtonPressed(_ sender: Any) {
        if isDataInputedFor(type: "password") {
            resetPassword()
        } else {
            ProgressHUD.showError("Email adresi gerekli")
        }
    }
    
    @IBAction func resendEmailButtonPressed(_ sender: Any) {
        if isDataInputedFor(type: "password") {
            resendVerificationEmail()
        } else {
            ProgressHUD.showError("Email adresiniz gerekmektedir.")
        }
    }
    
    
    @IBAction func signUpButtonPressed(_ sender: UIButton) {
        updateUIFor(login: sender.titleLabel?.text == "Giriş yapın")
        isLogin.toggle()
    }
    
    
    
    //MARK: - Setup
    private func setupTextFieldDelegates() {
        emailTextField.addTarget(self, action: #selector(textFieldDidChange(_ :)), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldDidChange(_ :)), for: .editingChanged)
        repeatPasswordTextField.addTarget(self, action: #selector(textFieldDidChange(_ :)), for: .editingChanged)
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        updatePlaceholderLabels(textField: textField)
    }
    
    private func setupBackgroundTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func backgroundTap() {
        view.endEditing(false)
    }
    
    
    //MARK: - Animation
    private func updateUIFor(login: Bool) {
        loginButtonOutlet.setTitle(login ? "GİRİŞ" : "KAYIT" , for: .normal)
        signUpButtonOutlet.setTitle(login ? "Kayıt olun" : "Giriş yapın", for: .normal)
        signUpLabel.text = login ? "Bir hesabınız yok mu?" : "Bir hesabınız var mı?"
        UIView.animate(withDuration: 0.5) {
            self.repeatPasswordTextField.isHidden = login
            self.repeatPasswordLabelOutlet.isHidden = login
            self.repeatPasswordLineView.isHidden = login
        }
    }
    
    private func updatePlaceholderLabels(textField: UITextField) {
        switch textField {
        case emailTextField:
            emailLabelOutlet.text = textField.hasText ? "Email" : ""
        case passwordTextField:
            passwordLabelOutlet.text = textField.hasText ? "Şifre" : ""
        default:
            repeatPasswordLabelOutlet.text = textField.hasText ? "Şifre (Tekrar)" : ""
        }
    }
    
    
    
    //MARK: - Helpers
    private func isDataInputedFor(type: String) -> Bool {
        switch type {
        case "login":
            return emailTextField.text != "" && passwordTextField.text != ""
        case "register":
            return emailTextField.text != "" && passwordTextField.text != "" && repeatPasswordTextField.text != ""
        default:
            return emailTextField.text != ""
        }
    }
    
    private func loginUser() {
        FirebaseUserListener.shared.loginUserWithEmail(email: emailTextField.text!, password: passwordTextField.text!) { error, isEmailVerified in
            if error == nil {
                if isEmailVerified {
                    self.goToApp()
                } else {
                    ProgressHUD.showError("Lütfen emailinizi doğrulayın.")
                    self.resendEmailButtonOutlet.isHidden = false
                }
                
            } else {
                ProgressHUD.showError(error!.localizedDescription)
            }
        }
    }
    
    private func registerUser() {
        if passwordTextField.text! == repeatPasswordTextField.text! {
            FirebaseUserListener.shared.registerUserWith(email: emailTextField.text!, password: passwordTextField.text!) { error in
                if error == nil {
                    ProgressHUD.showSuccess("Doğrulama için email adresinize gidin.")
                    self.resendEmailButtonOutlet.isHidden = false
                } else {
                    ProgressHUD.showError(error!.localizedDescription)
                }
            }
        } else {
            ProgressHUD.showError("Parolalar Eşleşmiyor!")
        }
    }
    
    private func resetPassword() {
        FirebaseUserListener.shared.resetPasswordFor(email: emailTextField.text!) { error in
            if error == nil {
                ProgressHUD.showSuccess("Sıfırlama maili gönderildi.")
            } else {
                ProgressHUD.showError(error!.localizedDescription)
            }
        }
    }
    
    private func resendVerificationEmail() {
        FirebaseUserListener.shared.resendVerificationEmail(email: emailTextField.text!) { error in
            if error == nil {
                ProgressHUD.showSuccess("Yeni doğrulama emaili gönderildi.")
            } else {
                ProgressHUD.showError("Lütfen daha sonra tekrar deneyin, hata \(error!.localizedDescription)")
                print(error!.localizedDescription)
            }
        }
    }
    
    
    //MARK: - Navigation
    private func goToApp() {
        let mainView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainView") as! UITabBarController
        
        mainView.modalPresentationStyle = .fullScreen
        self.present(mainView, animated: true, completion: nil)
    }
    
}

