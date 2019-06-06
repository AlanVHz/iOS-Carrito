//
//  CartTableViewController.swift
//  Carrito
//
//  Created by Alan Vargas on 4.04.2019.
//  Copyright © 2019 Alan Vargas. All rights reserved.
//

import UIKit

class CartTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
  var dataForCartController:[TableData] = []
  var tableMainController = TableViewController()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var payButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavbar()
    }
    
    func setupNavbar() {
        navigationItem.title = "Mi Carrito"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataForCartController.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath)
        cell.selectionStyle = .none
        
        if let name = dataForCartController[indexPath.row].name {
            cell.textLabel?.text = name
            cell.textLabel?.font = UIFont(name: "Marker Felt", size: 16.0)
            cell.textLabel?.textColor = UIColor(red:0.30, green:0.69, blue:0.49, alpha:1.0)
        }
        
        if let price = dataForCartController[indexPath.row].price {
            cell.detailTextLabel?.text = "$\(String(price))"
            cell.detailTextLabel?.font = UIFont(name: "Marker Felt", size: 12.0)
            cell.detailTextLabel?.isHighlighted = true
        }
        
        if let img = dataForCartController[indexPath.row].imgName {
            cell.heightAnchor.constraint(equalToConstant: 70.0).isActive = true
            cell.imageView?.image = UIImage(named: img)
        }
        
        return cell
    }
    

    @IBAction func payAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Pagar carrito", message: "¿Estás seguro de pagar ahora tu carrito de compras?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { (UIAlertAction) in
          self.dataForCartController.removeAll()
          self.tableMainController.dataForCartController.removeAll()
          
          self.navigationController?.popViewController(animated: true)
          self.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
   
}

extension CartTableViewController {
    func setupView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = UIColor(red:0.89, green:0.95, blue:1.00, alpha:1.0)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.60).isActive = true
        
        totalLabel.textAlignment = .center
        totalLabel.font = UIFont(name: "Marker Felt", size: 26.0)
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        totalLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        totalLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        totalLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20.0).isActive = true
        totalLabel.text = "Total: $\(getTotalAmount())"
        
        payButton.translatesAutoresizingMaskIntoConstraints = false
        payButton.backgroundColor = UIColor(red:0.20, green:0.29, blue:0.37, alpha:1.0)
        payButton.topAnchor.constraint(equalTo: totalLabel.bottomAnchor, constant: 20.0).isActive = true
        payButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        payButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        payButton.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        payButton.layer.cornerRadius = 15.0
        payButton.setTitle("Pagar", for: .normal)
        payButton.setTitleColor(.white, for: .normal)
    }
    
    func getTotalAmount() -> Double {
        var total = 0.0;
        for element in dataForCartController {
            total += element.price!
        }
        return total
    }
    
}
