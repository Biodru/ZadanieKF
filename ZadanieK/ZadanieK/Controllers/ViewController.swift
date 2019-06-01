//
//  ViewController.swift
//  ZadanieK
//
//  Created by Piotr_Brus on 29/05/2019.
//  Copyright © 2019 Piotr_Brus. All rights reserved.
//

import UIKit
import ChameleonFramework

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    final let url = URL(string: "https://my-json-server.typicode.com/Biodru/api/db")
    var citiesArray = [City]()
    var selectedCity = ""
    
    @IBOutlet weak var citiesTable: UITableView!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    
    //MARK: - Funkcje tabeli
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CitiesCell else {
            
            return UITableViewCell()
            
        }
        
        if let color = FlatOrange().darken(byPercentage: CGFloat(indexPath.row) / CGFloat(citiesArray.count)) {
            
            cell.backgroundColor = color
            cell.nameLbl.textColor = ContrastColorOf(backgroundColor: color, returnFlat: true)
            cell.descLbl.textColor = ContrastColorOf(backgroundColor: color, returnFlat: true)
            
        }
        
        if citiesArray[indexPath.row].name == "Wroclaw" {
            
            cell.nameLbl.text = "Wrocław"
            
        } else if citiesArray[indexPath.row].name == "Poznan" {
            
            cell.nameLbl.text = "Poznań"
            
        } else if citiesArray[indexPath.row].name == "Lodz" {
            
            cell.nameLbl.text = "Łódź"
            
        } else {
            
            cell.nameLbl.text = citiesArray[indexPath.row].name
            
        }
        
        cell.descLbl.text = citiesArray[indexPath.row].description
        
        if let photoURL = URL(string: citiesArray[indexPath.row].photo) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: photoURL)
                if let data = data {
                    let photo = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.imgView.image = photo
                    }
                }
            }
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedCity = citiesArray[indexPath.row].name
        buttonState()
        print(citiesArray[indexPath.row].name)
        print(citiesArray[indexPath.row].description)
        
    }
    
    //MARK: - Przygotowanie przejścia
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TicketsViewController
        
        destinationVC.test = selectedCity
        
    }

    //MARK: - Stan przycisku
    
    func buttonState() {
        
        if selectedCity == "" {
            
            nextButton.isEnabled = false
            
        } else {
            
            nextButton.isEnabled = true
            
        }
        
    }

    @IBAction func nextScreen(_ sender: UIBarButtonItem) {
        
        performSegue(withIdentifier: "goToTickets", sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        citiesTable.backgroundColor = FlatOrange()
        self.navigationController?.navigationBar.barTintColor = FlatOrange()
        buttonState()
        downloadJSON()
    }
    
    //MARK: - Pobieranie danych
    
    func downloadJSON() {
        
        guard let downloadURL = url else {return}
        
        URLSession.shared.dataTask(with: downloadURL) {data, response, error in
            
            guard let data = data, error == nil, response != nil else {
                print("błąd")
                return
            }
            
            print("Mam dane!")
            
            do{
                let decoder = JSONDecoder()
                let downloadedCities = try decoder.decode(Cities.self, from: data)
                self.citiesArray = downloadedCities.cities
                DispatchQueue.main.async {
                    self.citiesTable.reloadData()
                }
                print(downloadedCities.cities[0].name)
            } catch {
                print("Błąd po pobraniu danych")
            }
            
            }.resume()
        
    }


}

