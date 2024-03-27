//
//  UserSettingsController.swift
//  KitDeneme
//
//  Created by Ozan Özkan on 20.03.2024.
//

import UIKit

class UserSettingsController: UIViewController {
    
    let logoutButton = UIButton(type: .system)
    let changePasswordButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLogoutButton()
        setupChangePasswordButton()
    }
    
    private func setupLogoutButton() {
        
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(.red, for: .normal)
        logoutButton.backgroundColor = .white
        logoutButton.layer.cornerRadius = 8
        logoutButton.layer.borderWidth = 1
        logoutButton.layer.borderColor = UIColor.white.cgColor
        logoutButton.addTarget(self, action: #selector(didTapLogout), for: .touchUpInside)
        view.addSubview(logoutButton)
        
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func setupChangePasswordButton() {
            
            changePasswordButton.setTitle("Change Password", for: .normal)
            changePasswordButton.setTitleColor(.blue, for: .normal)
            changePasswordButton.backgroundColor = .white
            changePasswordButton.layer.cornerRadius = 8
            changePasswordButton.layer.borderWidth = 1
            changePasswordButton.layer.borderColor = UIColor.white.cgColor
            changePasswordButton.addTarget(self, action: #selector(didTapChangePassword), for: .touchUpInside)
            view.addSubview(changePasswordButton)
            
            changePasswordButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                changePasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                changePasswordButton.topAnchor.constraint(equalTo: logoutButton.bottomAnchor, constant: 20)
            ])
        }
    
    @objc private func didTapLogout() {
        AuthService.shared.signOut { [weak self] error in
            guard let self = self else { return }
            if let error = error {
                AlertManager.showLogoutError(on: self, with: error)
            }
        }
        
        if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
            sceneDelegate.checkAuthentication()
        }
    }
    
    @objc private func didTapChangePassword() {
            let changePasswordController = ChangePasswordController()
            navigationController?.pushViewController(changePasswordController, animated: true)
        }
}
