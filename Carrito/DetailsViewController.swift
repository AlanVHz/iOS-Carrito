//
//  DetailsViewController.swift
//  Carrito
//
//  Created by Alan Vargas on 3.04.2019.
//  Copyright © 2019 Alan Vargas. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var data = TableData()
    var mainTableView:TableViewController!
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescription: UITextView!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var buttonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupConstraints()
        setupData()
        settingTitle()
    }
    
    func setupConstraints() {
        
        viewContainer.translatesAutoresizingMaskIntoConstraints = false
        viewContainer.backgroundColor = .white
        viewContainer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        viewContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        viewContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        viewContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.30).isActive = true
        
        productImage.translatesAutoresizingMaskIntoConstraints = false
        productImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0).isActive = true
        productImage.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor).isActive = true
        productImage.centerXAnchor.constraint(equalTo: viewContainer.centerXAnchor).isActive = true
        
        productPrice.translatesAutoresizingMaskIntoConstraints = false
        productPrice.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor).isActive = true
        productPrice.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: 50.0).isActive = true
        productPrice.font = UIFont(name: "Marker Felt", size: 26.0)
        productPrice.textColor = UIColor(red:0.30, green:0.69, blue:0.49, alpha:1.0)
        
        productDescription.translatesAutoresizingMaskIntoConstraints = false
        productDescription.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor).isActive = true
        productDescription.topAnchor.constraint(equalTo: productPrice.bottomAnchor, constant: 50.0).isActive = true
        productDescription.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        productDescription.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        productDescription.isEditable = false
        productDescription.font = UIFont(name: "Marker Felt", size: 26.0)
        productDescription.textColor = UIColor(red:0.30, green:0.69, blue:0.49, alpha:1.0)
        productDescription.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        buttonOutlet.translatesAutoresizingMaskIntoConstraints = false
        buttonOutlet.setTitle("Agregar al carrito", for: .normal)
        buttonOutlet.tintColor = .white
        buttonOutlet.backgroundColor = UIColor(red:0.30, green:0.69, blue:0.49, alpha:1.0)
        buttonOutlet.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        buttonOutlet.topAnchor.constraint(equalTo: productDescription.bottomAnchor).isActive = true
        buttonOutlet.widthAnchor.constraint(equalToConstant: 300.0).isActive = true
        buttonOutlet.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
        buttonOutlet.layer.cornerRadius = 15.0
    }
    
    func setupData() {
        productImage.image = UIImage(named: data.imgName!)
        productDescription.text = data.description
        productDescription.textAlignment = .center
        productPrice.text = "$\(String(data.price!))"
        
    }
    
    func settingTitle() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = data.name!
        navigationController?.isToolbarHidden = true
    }
    
    @IBAction func saveProduct(_ sender: UIButton) {
        let alert = UIAlertController(title: "Agregar Producto", message: "¿Estás seguro que deseas agregar este producto a tu carrito?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Cancelar", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Aceptar", style: .default, handler: { (UIAlertAction) in
            self.mainTableView.dataForCartController.append(self.data)
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        }))
        present(alert, animated: true, completion: nil)
    }
    
    

}
