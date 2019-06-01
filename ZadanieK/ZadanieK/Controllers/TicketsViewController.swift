//
//  TicketsViewController.swift
//  ZadanieK
//
//  Created by Piotr_Brus on 29/05/2019.
//  Copyright © 2019 Piotr_Brus. All rights reserved.
//
//Icons:
//Icon made by Freepik from www.flaticon.com

import UIKit
import ChameleonFramework

class TicketsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Zmienne

    var ticketsArray = [Ticket]()
    
    var test = ""
    
    var selectedTicket = ""
    
    //MARK: - Outlety
    
    @IBOutlet weak var ticketsTable: UITableView!
    
    //MARK: - Funkcje tabeli
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ticketsArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ticketCell") as? TicketsCell else {
            
            return UITableViewCell()
            
        }
        
        if let color = FlatOrange().darken(byPercentage: CGFloat(indexPath.row) / CGFloat(ticketsArray.count)) {
            
            cell.backgroundColor = color
            cell.tName.textColor = ContrastColorOf(backgroundColor: color, returnFlat: true)
            cell.tDescription.textColor = ContrastColorOf(backgroundColor: color, returnFlat: true)
            cell.tType.textColor = ContrastColorOf(backgroundColor: color, returnFlat: true)
            
        }
        
        cell.tName.text = ticketsArray[indexPath.row].tName
        cell.tDescription.text = ticketsArray[indexPath.row].tDescription
        cell.tType.text = ticketsArray[indexPath.row].tType
        
        if ticketsArray[indexPath.row].tType == "fTicket" {
            
            cell.tIcon.image = UIImage(named: "business-cards-database.png")
            
        } else {
            
            cell.tIcon.image = UIImage(named: "id-card.png")
            
        }
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedTicket = ticketsArray[indexPath.row].tName
        createAlert()
        print(ticketsArray[indexPath.row].tName)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ticketsTable.backgroundColor = FlatOrange()
        downloadTickets()
        self.navigationController!.navigationBar.topItem!.title = "Wróć"
        self.navigationController?.navigationBar.barTintColor = FlatOrange()
        
    }
    
    //MARK: - Alert
    
    func createAlert() {
        
        let alert = UIAlertController(title: "Kupujesz?", message: "Czy potwierdzasz zakup biletu \(selectedTicket)", preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "Tak", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            print("Kupiono bilet")
        }))
        
        alert.addAction(UIAlertAction(title: "Nie", style: UIAlertAction.Style.default, handler: { (action) in
            alert.dismiss(animated: true, completion: nil)
            print("Anulowano zakup")
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //MARK: - Pobieranie danych z API
    
    func downloadTickets() {
        let url = URL(string: "https://my-json-server.typicode.com/Biodru/api/tickets?city=\(test)")
        
        guard let downloadURL = url else {return}
        
        URLSession.shared.dataTask(with: downloadURL) {data, response, error in
            
            guard let data = data, error == nil, response != nil else {
                print("błąd")
                return
            }
            
            print(downloadURL)
            print(data)
            print("Mam dane!")
            
            do{
                let decoder = JSONDecoder()
                self.ticketsArray = try decoder.decode([Ticket].self, from: data)
                DispatchQueue.main.async {
                    self.ticketsTable.reloadData()
                }
                
            } catch {
                print("Błąd po pobraniu danych")
            }
            
            }.resume()
        
    }

}
