//
//  LoginViewController.swift
//  Scheduling
//
//  Created by Виталий Рамазанов on 27.03.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
	
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var password: UITextField!
	@IBOutlet weak var login: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var justViewLabel: UILabel!
    @IBOutlet weak var justViewButton: UIButton!
    @IBOutlet weak var createClientLabel: UILabel!
    @IBOutlet weak var createClientButton: UIButton!
    @IBOutlet weak var createSalonLabel: UILabel!
    @IBOutlet weak var createSalonButton: UIButton!
    
    func setConstraints() {
        
        let textFields : [UITextField] = [login, password]
        var buttons : [UIButton] = [justViewButton, createClientButton, createSalonButton]
        var labels : [UILabel] = [justViewLabel, createClientLabel, createSalonLabel]
        
        login.translatesAutoresizingMaskIntoConstraints = false
        password.translatesAutoresizingMaskIntoConstraints = false
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        justViewLabel.translatesAutoresizingMaskIntoConstraints = false
        justViewButton.translatesAutoresizingMaskIntoConstraints = false
        createClientLabel.translatesAutoresizingMaskIntoConstraints = false
        createClientButton.translatesAutoresizingMaskIntoConstraints = false
        createSalonLabel.translatesAutoresizingMaskIntoConstraints = false
        createSalonButton.translatesAutoresizingMaskIntoConstraints = false

        let verticalConstraintForLogin = NSLayoutConstraint(item: login, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 50)
        let verticalConstraintForPass = NSLayoutConstraint(item: password, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: login, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 25)
        view.addConstraints([verticalConstraintForLogin, verticalConstraintForPass])
        
        for textField in textFields {
            let horizontalConstraint = NSLayoutConstraint(item: textField, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
            let widthConstraint = NSLayoutConstraint(item: textField, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: (2/3)*UIScreen.main.bounds.width )
            view.addConstraints([horizontalConstraint, widthConstraint])
        }
        
        // signin
        let verticalConstraintForSignIn = NSLayoutConstraint(item: signInButton, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: password, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 25)
        let horizontalConstraintForSignIn = NSLayoutConstraint(item: signInButton, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let widthConstraintForSignIn = NSLayoutConstraint(item: signInButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: (2/3)*UIScreen.main.bounds.width )
        view.addConstraints([verticalConstraintForSignIn ,horizontalConstraintForSignIn, widthConstraintForSignIn])

        // JustViewLabel
        let verticalConstraintForJustView = NSLayoutConstraint(item: justViewLabel, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: signInButton, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 50)
        let horizontalConstraintForJustView = NSLayoutConstraint(item: justViewLabel, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let widthConstraintForJustView = NSLayoutConstraint(item: justViewLabel, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: (2/3)*UIScreen.main.bounds.width )
        view.addConstraints([verticalConstraintForJustView ,horizontalConstraintForJustView, widthConstraintForJustView])
        
        updateViewConstraints()
        
        for i in 0...2 {
            
            let verticalConstraintButton = NSLayoutConstraint(item: buttons[i], attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: labels[i], attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 10)
            let widthConstraintButton = NSLayoutConstraint(item: buttons[i], attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: (2/3)*UIScreen.main.bounds.width)
            let horizontalConstraintButton = NSLayoutConstraint(item: buttons[i], attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
            
            view.addConstraints([verticalConstraintButton, horizontalConstraintButton, widthConstraintButton])
            
            if i == 2 {
                continue
            }
            
            let verticalConstraintLabel = NSLayoutConstraint(item: labels[i+1], attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: buttons[i], attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 25)
            let widthConstraintLabel = NSLayoutConstraint(item: labels[i+1], attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: (2/3)*UIScreen.main.bounds.width)
            let horizontalConstraintLabel = NSLayoutConstraint(item: labels[i+1], attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: contentView, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
            view.addConstraints([verticalConstraintLabel, horizontalConstraintLabel, widthConstraintLabel])
        }
        
        updateViewConstraints()
        
    }
    
	override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func LoginWithoutRegistration(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let TabBarC = storyboard.instantiateViewController(withIdentifier: "TabBar") as! UITabBarController
        let ViewProfileNavigationC = storyboard.instantiateViewController(withIdentifier: "ViewProfileNavigationController")
        TabBarC.viewControllers?.append(ViewProfileNavigationC)
        ViewProfileNavigationC.tabBarItem = UITabBarItem(title: "Профиль", image: #imageLiteral(resourceName: "profile") , tag: 2)
        loadData(acc: viewAccount)
        present(TabBarC, animated: false, completion: nil)
    }
    
	@IBAction func signIn(_ sender: Any) {
//        if users[login.text!] != nil && users[login.text!] == password.text! {
//            testLabel.text = "OK"
//            let TabBarC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TabBar") as! UITabBarController
//                present(TabBarC, animated: false, completion: nil)
//        }

        for user in users {
            if user.login == login.text && user.password == password.text {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let TabBarC = storyboard.instantiateViewController(withIdentifier: "TabBar") as! UITabBarController
                
                switch user.profileType{
                case .salon:
                    let SalonRequestsNavigationC = storyboard.instantiateViewController(withIdentifier: "SalonRequestsNavigationController")
                    TabBarC.viewControllers?.append(SalonRequestsNavigationC)
                    SalonRequestsNavigationC.tabBarItem = UITabBarItem(title: "Заявки", image: #imageLiteral(resourceName: "requests") , tag: 2)
                    let SalonProfileNavigationC = storyboard.instantiateViewController(withIdentifier: "SalonNavigationController") as! UINavigationController
                TabBarC.viewControllers?.append(SalonProfileNavigationC)
                    SalonProfileNavigationC.tabBarItem = UITabBarItem(title: "Профиль", image: #imageLiteral(resourceName: "profile"), tag: 3)
                case .client:
                    let ClientProfileNavigationC = storyboard.instantiateViewController(withIdentifier: "ClientNavigationController")
                    TabBarC.viewControllers?.append(ClientProfileNavigationC)
                    ClientProfileNavigationC.tabBarItem = UITabBarItem(title: "Профиль", image: #imageLiteral(resourceName: "profile"), tag: 3)
                case .view:
                    let ViewProfileNavigationC = storyboard.instantiateViewController(withIdentifier: "ViewProfileNavigationController")
                    TabBarC.viewControllers?.append(ViewProfileNavigationC)
                    ViewProfileNavigationC.tabBarItem = UITabBarItem(title: "Профиль", image: #imageLiteral(resourceName: "profile") , tag: 2)
                }
                loadData(acc: user)
                
                // ========
                let searchNavigationC = TabBarC.viewControllers?.first as! UINavigationController
                let searchVC = searchNavigationC.viewControllers.first as! SearchTableViewController
                guard  let URLGetCityList = URL(string: serverAdr + "api/getCityList") else { return }
                URLSession.shared.dataTask(with: URLGetCityList) { (data, response, error) in
                    guard let data = data else { return }
                    do {
                        let citiesData = try JSONDecoder().decode([String].self, from: data)
                        cities = citiesData
                        DispatchQueue.main.async {
                            searchVC.tableView.reloadData()
                        }
                    } catch let err {
                        print(err)
                    }
                    }.resume()
                // ========
                
                present(TabBarC, animated: false, completion: nil)
            }
        }
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
