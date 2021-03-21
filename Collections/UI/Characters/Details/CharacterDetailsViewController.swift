//
//  CharacterDetailsViewController.swift
//  Collections
//
//  Created by Jan Bjelicic on 21/03/2021.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    @IBOutlet weak var lblName: UILabel!
    
    private var viewModel: CharacterDetailsViewModel!
    
    func configure(viewModel: CharacterDetailsViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        lblName.text = viewModel.character.name
    }
    
}
