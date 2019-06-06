//
//  TableViewController.swift
//  Carrito
//
//  Created by Alan Vargas on 31.03.2019.
//  Copyright © 2019 Alan Vargas. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    let sections = ["Comida", "Bebidas"]
    var dataForDetailsController = TableData()
    var dataForCartController:[TableData] = []
    var dataForTable = [
        [
            TableData(id: 0, name: "Sabritas", price: 15.00, description: "Frituras de papa", imgName: "sabritas"),
            TableData(id: 1, name: "Chocoroles", price: 20.00, description: "Galleta tipo sandwich rellena de delicioso chocolate", imgName: "chocoroles"),
            TableData(id: 2, name: "Oreo", price: 10.00, description: "Galletas tipo sandwich", imgName: "oreo"),
            TableData(id: 3, name: "Cheetos", price: 10.00, description: "Harina de maíz con sabor a queso", imgName: "cheetos"),
            TableData(id: 4, name: "Donitas Bimbo", price: 15.00, description: "Donitas espolvoreadas con azucar glas", imgName: "donitas"),
            TableData(id: 5, name: "Doritos", price: 15.00, description: "Tortilla chip con sabores varios", imgName: "doritos"),
            TableData(id: 6, name: "Gomitas", price: 10.00, description: "Gomas de sabores en forma de osito", imgName: "gomitas"),
            TableData(id: 7, name: "Príncipe", price: 15.00, description: "Galletas rellenas con sabor a chocolate", imgName: "principe"),
            TableData(id: 8, name: "Kranky", price: 10.00, description: "Hojuela de maíz con cubierta sabor a chocolate", imgName: "kranky"),
            TableData(id: 9, name: "Rokaleta", price: 5.00, description: "Paleta de caramelo enchilado con relleno de goma de mascar", imgName: "rokaleta")
        ],
        [
            TableData(id: 10, name: "Coca-Cola", price: 15.00, description: "Bebida refrescante carbonatada", imgName: "coca"),
            TableData(id: 11, name: "Pepsi", price: 15.00, description: "Bebida refrescante carbonatada", imgName: "pepsi"),
            TableData(id: 12, name: "Boing Mango", price: 10.00, description: "Bebida refrescante sabor mango", imgName: "boing"),
            TableData(id: 13, name: "Agua", price: 10.00, description: "Agua natural", imgName: "agua"),
            TableData(id: 14, name: "Agua de Guayaba", price: 15.00, description: "Agua sabor Guayaba natural", imgName: "agua2")
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
      settingTitle()
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataForTable[section].count
    }
    
    // El título de las secciones
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    // Row seleccionada
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dataForDetailsController.description = dataForTable[indexPath.section][indexPath.row].description
        dataForDetailsController.id = dataForTable[indexPath.section][indexPath.row].id
        dataForDetailsController.imgName = dataForTable[indexPath.section][indexPath.row].imgName
        dataForDetailsController.name = dataForTable[indexPath.section][indexPath.row].name
        dataForDetailsController.price = dataForTable[indexPath.section][indexPath.row].price

        performSegue(withIdentifier: "productDetailsSegue", sender: self)

    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "myCell")
        
        cell.textLabel?.text = dataForTable[indexPath.section][indexPath.row].name
        cell.textLabel?.font = UIFont(name: "Marker Felt", size: 16.0)
        cell.textLabel?.textColor = UIColor(red:0.30, green:0.69, blue:0.49, alpha:1.0)
        
        cell.detailTextLabel?.text = "$\(String(dataForTable[indexPath.section][indexPath.row].price!))"
        cell.detailTextLabel?.font = UIFont(name: "Marker Felt", size: 12.0)
        cell.detailTextLabel?.isHighlighted = true
        
        cell.heightAnchor.constraint(equalToConstant: 70.0).isActive = true
        cell.imageView?.image = UIImage(named: dataForTable[indexPath.section][indexPath.row].imgName!)
        cell.selectionStyle = .none
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "productDetailsSegue" {
            let detailsViewController = segue.destination as! DetailsViewController
            detailsViewController.data = dataForDetailsController
            detailsViewController.mainTableView = self
        }
        
        if segue.identifier == "cartSegue" {
            let cartController = segue.destination as! CartTableViewController
            cartController.dataForCartController = dataForCartController
            cartController.tableMainController = self
        }
    }
    
    func settingTitle() {
        // para el título
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = "Supercito"
        
        let viewCartButton = UIBarButtonItem(image: UIImage(named: "cart"), style: .plain, target: self, action: #selector(viewCart))
        navigationItem.rightBarButtonItem = viewCartButton
    }
    
    @objc func viewCart() {
        performSegue(withIdentifier: "cartSegue", sender: self)
    }

}
