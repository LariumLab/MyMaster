//
//  SearchSalonsInCityTableViewController.swift
//  Scheduling
//
//  Created by macbook on 11.04.2018.
//  Copyright © 2018 Aksiniya. All rights reserved.
//

import UIKit

class SearchSalonsInCityTableViewController: UITableViewController {
    
    var city : String = ""
    var salonsInCity : [ JSONSalonPreview ] = [ ]
    let cellIdentifier = "SearchSalonInCityCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "SearchSalonTableViewCell" , bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.title = city
        tableView.tableFooterView = UIView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return salonsInCity.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //        let salonCell = SearchSalonTableViewCell()
        //        return salonCell.cellHeight
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SearchSalonTableViewCell
        
        let currentSalon : JSONSalonPreview  = salonsInCity[indexPath.row]
        cell.nameLabel.text = currentSalon.customName
        cell.adressLabel.text = currentSalon.address
        let gamma = blueGamma()
        gamma.makeViewStyle(view: cell.colorView, color: gamma.biegeColor, radius: 10)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let SalonVC = UIStoryboard(name: "Search", bundle: nil).instantiateViewController(withIdentifier: "SearchSalon") as! SearchSalonTableViewController
        
        let salon = salonsInCity[indexPath.row]
        let salonID = salon.ID
        
        let getSalonInfoURL =  serverAdr + "api/getSalonInfo?salonID=" + salonID.uuidString
        let getSalonServicesURL = serverAdr + "api/getSalonServices?salonID=" + salonID.uuidString
        
        guard let URLGetSalonInfo = URL(string: getSalonInfoURL) else {
            return
        }
        guard let URLGetSalonServices = URL(string: getSalonServicesURL) else {
            return
        }
        
        //        let loadQueue = OperationQueue()
        //
        //        loadQueue.addOperation {
        //            guard let data = try? Data(contentsOf: URLGetSalonInfo) else {
        //                return
        //            }
        //            do {
        //                let salonInfo = try JSONDecoder().decode(JSONSalonInfo.self, from: data)
        //                SalonVC.currentSalon.adress = salon.address
        //                SalonVC.currentSalon.name = salon.customName
        //                SalonVC.currentSalon.ID = salon.ID.uuidString
        //                SalonVC.currentSalon.description = salonInfo.description
        //                SalonVC.currentSalon.phoneNumber = salonInfo.phoneNumber
        //                SalonVC.currentSalon.nickname = salonInfo.nickName
        //                SalonVC.currentSalon.city = self.city
        //            } catch let err {
        //                print(err)
        //            }
        //        }
        //
        //        loadQueue.addOperation {
        //            guard let data = try? Data(contentsOf: URLGetSalonServices) else {
        //                return
        //            }
        //            do {
        //                let services : [JSONService] = try JSONDecoder().decode([JSONService].self, from: data)
        //                for service in services {
        //                    let serv : Service = Service(salonID: service.salonID, serviceID: service.serviceID, name: service.name, description: service.description, masters: [], priceFrom: service.priceFrom, priceTo: service.priceTo)
        //                    SalonVC.currentSalon.services.append(serv)
        //                }
        //            } catch let err {
        //                print(err)
        //            }
        //        }
        //        self.view.showBlurLoader()
        //        loadQueue.waitUntilAllOperationsAreFinished()
        //        self.view.removeBlurLoader()
        
        
        let loadGroup = DispatchGroup()
        
        loadGroup.enter()
        guard let data1 = try? Data(contentsOf: URLGetSalonInfo) else {
            return
        }
        do {
            let salonInfo = try JSONDecoder().decode(JSONSalonInfo.self, from: data1)
            SalonVC.currentSalon.adress = salon.address
            SalonVC.currentSalon.name = salon.customName
            SalonVC.currentSalon.ID = salon.ID.uuidString
            SalonVC.currentSalon.description = salonInfo.description
            SalonVC.currentSalon.phoneNumber = salonInfo.phoneNumber
            SalonVC.currentSalon.nickname = salonInfo.nickName
            SalonVC.currentSalon.city = self.city
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
                SalonVC.currentSalon.services.append(serv)
            }
        } catch let err {
            print(err)
        }
        loadGroup.leave()
        
        
        self.navigationController?.pushViewController(SalonVC, animated: true)
        SalonVC.view.showBlurLoader()
        
        loadGroup.notify(queue: .main) {
            SalonVC.view.removeBlurLoader()
        }
    }
}
