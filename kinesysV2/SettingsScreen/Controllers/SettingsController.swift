//
//  SettingsController.swift
//  kinesysV2
//
//  Created by Chris Davis on 1/20/19.
//  Copyright © 2019 Chris Davis. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

//class CustomImagePickerController: UIImagePickerController {
//    var imageButton : UIButton?
//}

class SettingsController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let profilePictureButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("select photo", for: .normal)
        button.backgroundColor = .white
        button.layer.cornerRadius = 200 / 2
        button.clipsToBounds = true
        button.layer.borderWidth = 5
        button.layer.borderColor = UIColor.white.cgColor
        button.addTarget(self, action: #selector(handleSelectPhoto), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationItems()
        
        tableView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        tableView.separatorStyle = .none
        tableView.keyboardDismissMode = .interactive
    }
    
    @objc fileprivate func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func handleSave() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc fileprivate func handleSelectPhoto() {
        print("selecting photo")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let selectedImage = info[.editedImage] as? UIImage {
            profilePictureButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
            profilePictureButton.imageView?.contentMode = .scaleAspectFill
        }
        dismiss(animated: true)
        
    }
    
    class HeaderLabel: UILabel { // trick to make headerLabel in viewForHeaderInSection inset
        override func drawText(in rect: CGRect) {
            super.drawText(in: rect.insetBy(dx: 16, dy: 0))
        }
    }
    
    lazy var header: UIView = {
        let header = UIView()
        header.addSubview(profilePictureButton)
        profilePictureButton.anchor(top: header.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 25, left: 0, bottom: 0, right: 0), size: .init(width: 200, height: 200))
        profilePictureButton.centerXAnchor.constraint(equalTo: header.centerXAnchor).isActive = true
        return header
    }()
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            return header
        }
        let headerLabel = HeaderLabel()
        
        switch section {
        case 1:
            headerLabel.text = "Name"
        case 2:
            headerLabel.text = "Trainer"
        case 3:
            headerLabel.text = "Email"
        case 4:
            headerLabel.text = "Birthdate"
        case 5:
            headerLabel.text = "Height"
        default:
            headerLabel.text = "Bio"
        }
        return headerLabel
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 250
        }
        return 40
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 0
        } else if section == 1 {
            return 2
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SettingsCell(style: .default, reuseIdentifier: nil)
        
        switch indexPath.section {
        case 1:
            switch indexPath.row {
            case 0:
                cell.textField.placeholder = "First Name"
            default:
                cell.textField.placeholder = "Last Name"
            }
        case 2:
            cell.textField.placeholder = "Your trainer's name"
        case 3:
            cell.textField.placeholder = "Enter email"
        case 4:
             cell.textField.placeholder = "Enter birthdate"
        case 5:
            cell.textField.placeholder = "Enter height"
        default:
            cell.textField.placeholder = "Enter Bio"
        }
        
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }
    
    fileprivate func setupNavigationItems() {
        navigationItem.title = "Settings"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        
    }

}
