//
//  NewRecipeViewController.swift
//  My-Recipes-Book
//
//  Created by Михаил Болгар on 10.09.2023.
//

import Foundation
import UIKit

final class NewRecipeViewController: UIViewController {

    // MARK: - Private UI Properties
    private var mainTableView = CreateRecipeView()

    // MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(mainTableView)

        setupConstraints()
    }

    // MARK: - Private Methods
    private func setupConstraints() {
        mainTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
