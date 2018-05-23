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
    
    var showRegisterController : Bool = false
    
	override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        setConstraints()
    }

    override func viewDidAppear(_ animated: Bool) {
        if showRegisterController == true {
            let createClientVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateClientAccount") as! ClientRegisterTableViewController
            createClientVC.loginVC = self
            self.navigationController?.pushViewController(createClientVC, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func LoginWithoutRegistration(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let TabBarC = storyboard.instantiateViewController(withIdentifier: "TabBar") as! UITabBarController
        let ViewProfileNavigationC = storyboard.instantiateViewController(withIdentifier: "ViewProfileNavigationController") as! UINavigationController
        TabBarC.viewControllers?.append(ViewProfileNavigationC)
        ViewProfileNavigationC.tabBarItem = UITabBarItem(title: "Профиль", image: #imageLiteral(resourceName: "profile") , tag: 2)
        let profileVC = ViewProfileNavigationC.viewControllers.last as! ProfileViewViewController
        profileVC.loginVC = self
//        profileVC.loginVC = self
//        loadData(acc: viewAccount)
        profileType = ProfileType.view
        
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
        
        present(TabBarC, animated: false, completion: nil)
    }
    
	@IBAction func signIn(_ sender: Any) {

        self.view.showBlurLoader()
        
        
        // ========
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let TabBarC = storyboard.instantiateViewController(withIdentifier: "TabBar") as! UITabBarController
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
        
        
        if (login.text?.isEmpty)! && (password.text?.isEmpty)! {
            let alertC = UIAlertController(title: "Ошибка", message: "Поле \"логин\" или \"пароль\" пустое", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
            alertC.addAction(okAction)
            present(alertC, animated: true, completion: nil)
            return
        }
        
        let loginAndPassURL = serverAdr + "api/signIn?login=" + login.text! + "&password=" + password.text!
        let URLloginAndPass = URL(string: loginAndPassURL)
        
        guard URLloginAndPass != nil else {
            // FUNC
            print("Error when try get URL")
            return
        }
        
        var request = URLRequest(url: URLloginAndPass!)
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard data != nil, error == nil else {
                print("Error when try to load data")
                print(error?.localizedDescription ?? "No data")
                let alertC = UIAlertController(title: "Ошибка", message: "Ошибка при подключении к серверу", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
                alertC.addAction(okAction)
                self.present(alertC, animated: true, completion: nil )
                return
            }
            
            let httpResponse = response as? HTTPURLResponse
            guard httpResponse?.statusCode != 400 else {
                print(httpResponse?.statusCode)
                self.view.removeBlurLoader()

                let alertC = UIAlertController(title: "Ошибка", message: "Неверный логин или пароль", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
                alertC.addAction(okAction)
                self.present(alertC, animated: true, completion: nil )
                
                return
            }
            
            let token = data
            self.loadProfile(token: token!)
        }
        task.resume()
        
    }
    
    func loadProfile(token: Data){
        let tokenInString = String(data: token, encoding: .utf8)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let TabBarC = storyboard.instantiateViewController(withIdentifier: "TabBar") as! UITabBarController

        let profileTypeInChar = tokenInString!.prefix(1)
        switch profileTypeInChar {
        case "S":
            let loadedSalon = Salon()
            
            let getSalonIdURL = serverAdr + "api/salon/getSalonID?token=" + tokenInString!
            let URLgetSalonID = URL(string: getSalonIdURL)
            
            guard URLgetSalonID != nil else {
                // FUNC
                return
            }
            
            let request = URLRequest(url: URLgetSalonID!)
            
            URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard let data = data, error == nil else {
                    print("Error when try to load data")
                    print(error?.localizedDescription ?? "No data")
                    let alertC = UIAlertController(title: "Ошибка", message: "Ошибка при подключении к серверу", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
                    alertC.addAction(okAction)
                    self.present(alertC, animated: true, completion: nil )
                    return
                }
                
                let salonIDInString = String(data: data, encoding: .utf8)
                
                let getSalonInfoURL =  serverAdr + "api/getSalonInfo?salonID=" + salonIDInString!
                let getSalonServicesURL = serverAdr + "api/getSalonServices?salonID=" + salonIDInString!

                guard let URLGetSalonInfo = URL(string: getSalonInfoURL) else {
                    return
                }
                guard let URLGetSalonServices = URL(string: getSalonServicesURL) else {
                    return
                }
                
                let loadGroup = DispatchGroup()
                loadGroup.enter()
                guard let data1 = try? Data(contentsOf: URLGetSalonInfo) else {
                    return
                }
                do {
                    let salonInfo = try JSONDecoder().decode(JSONSalonInfo.self, from: data1)
                    loadedSalon.adress = salon.adress
                    loadedSalon.name = salon.name
                    loadedSalon.ID = salon.ID
                    loadedSalon.description = salonInfo.description
                    loadedSalon.phoneNumber = salonInfo.phoneNumber
                    loadedSalon.nickname = salonInfo.nickName
                    loadedSalon.city = salonInfo.city
                } catch let err {
                    print(err)
                }
                loadGroup.leave()
                
                
                loadGroup.enter()
                guard let data2 = try? Data(contentsOf: URLGetSalonServices) else {
                    return
                }
                do {
                    let services : [JSONService] = try JSONDecoder().decode([JSONService].self, from: data2)
                    for service in services {
                        let serv : Service = Service(salonID: service.salonID, serviceID: service.serviceID, name: service.name, description: service.description, masters: [], priceFrom: service.priceFrom, priceTo: service.priceTo)
                        loadedSalon.services.append(serv)
                    }
                } catch let err {
                    print(err)
                }
                loadGroup.leave()
                
                
                loadGroup.notify(queue: .main) {
                    let SalonRequestsNavigationC = storyboard.instantiateViewController(withIdentifier: "SalonRequestsNavigationController")
                    TabBarC.viewControllers?.append(SalonRequestsNavigationC)
                    SalonRequestsNavigationC.tabBarItem = UITabBarItem(title: "Заявки", image: #imageLiteral(resourceName: "requests") , tag: 2)
                    let SalonProfileNavigationC = storyboard.instantiateViewController(withIdentifier: "SalonNavigationController") as! UINavigationController
                    TabBarC.viewControllers?.append(SalonProfileNavigationC)
                    SalonProfileNavigationC.tabBarItem = UITabBarItem(title: "Профиль", image: #imageLiteral(resourceName: "profile"), tag: 3)
                    
                    _ = Keychain.save(key: "userToken", data: token)
//                    self.TabBar = TabBarC
                    salon = loadedSalon
                    self.view.removeBlurLoader()
                    self.present(TabBarC, animated: false, completion: nil)
                }
                    
            }.resume()
            
        case "C":
            let loadedClient = Client()
            
            let LoadClientDataURL = serverAdr + "api/"
            let URLLoadClientData = URL(string: LoadClientDataURL)
            
            guard URLLoadClientData != nil else {
                break
            }
            
            let task = URLSession.shared.dataTask(with: URLLoadClientData!) { (data, response, error) in
                guard let data = data, error == nil else {
                    print("Error when try to load data")
                    print(error?.localizedDescription ?? "No data")
                    let alertC = UIAlertController(title: "Ошибка при создании аккаунта", message: "Ошибка при подключении к серверу", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ок", style: .cancel, handler: nil)
                    alertC.addAction(okAction)
                    self.present(alertC, animated: true, completion: nil )
                    return
                }
                
            }
            
            return
        default:
            print("Find error when try to pull acc type")
            break
        }
    }
    
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
    
	/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
