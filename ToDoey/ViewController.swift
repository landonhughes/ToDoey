//
//  ViewController.swift
//  ToDoey
//
//  Created by Landon Hughes on 2/13/22.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        // Do any additional setup after loading the view.
    }

    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "ToDoey"
    }
    
}

