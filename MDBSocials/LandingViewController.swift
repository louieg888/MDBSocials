//
//  LandingViewController.swift
//  MDBSocials
//
//  Created by Louie McConnell on 9/28/17.
//  Copyright © 2017 Louie McConnell. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
    
    // logo
    let mdbSocialsLogo: UIImage = #imageLiteral(resourceName: "logo")
    var logoImageView: UIImageView!
    
    // buttons
    var signUpButton: UIButton!
    var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.backgroundColor = UIColor(colorLiteralRed: 16/255, green: 14/255, blue: 62/255, alpha: 1)
        navigationController?.navigationBar.isHidden = true
        addMDBSocialsLogo()
        addSignUpButton()
        addLoginButton()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addMDBSocialsLogo() {
        logoImageView = UIImageView()
        logoImageView.frame = CGRect(
            x: 0,
            y: 0.1 * view.frame.height,
            width: view.frame.width,
            height: 0.3 * view.frame.height
        )
        logoImageView.image = mdbSocialsLogo
        logoImageView.contentMode = .scaleAspectFit
        view.addSubview(logoImageView)
    }
    
    func addSignUpButton() {
        signUpButton = UIButton()
        signUpButton.frame = CGRect(
            x: 20,
            y: 0.78 * view.frame.height,
            width: view.frame.width - 40,
            height: 60
        )
        signUpButton.layer.cornerRadius = 7
        signUpButton.backgroundColor = UIColor(red: 64/255, green: 174/255, blue: 246/255, alpha: 1)
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.setTitleColor(UIColor.white, for: .normal)
        signUpButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 20)
        signUpButton.addTarget(self, action: #selector(goToSignUpVC), for: .touchUpInside)
        
        view.addSubview(signUpButton)
    }
    
    func goToSignUpVC() {
        performSegue(withIdentifier: "toSignupVC", sender: self)
    }
    
    func addLoginButton() {
        loginButton = UIButton()
        loginButton.frame = CGRect(
            x: 20,
            y: signUpButton.frame.maxY + 20,
            width: view.frame.width - 40,
            height: 60
        )
        loginButton.layer.cornerRadius = 7
        loginButton.backgroundColor = UIColor(red: 64/255, green: 174/255, blue: 246/255, alpha: 1)
        loginButton.setTitle("Login", for: .normal)
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 20)
        loginButton.addTarget(self, action: #selector(goToLoginVC), for: .touchUpInside)
        
        view.addSubview(loginButton)
    }
    
    func goToLoginVC() {
        performSegue(withIdentifier: "toLoginVC", sender: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
