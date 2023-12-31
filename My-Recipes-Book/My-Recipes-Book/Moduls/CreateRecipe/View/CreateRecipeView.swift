//
//  CreateRecipeView.swift
//  My-Recipes-Book
//
//  Created by Михаил Болгар on 10.09.2023.
//

import Foundation

import UIKit

final class CreateRecipeView: UIView {

    // MARK: - Public UI Properties
    lazy var mainTableView: UITableView = {
        let mainTableView = UITableView(frame: self.bounds, style: .grouped)
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.backgroundColor = .white
        mainTableView.register(
            RecipeImageCell.self,
            forCellReuseIdentifier: "imageCell"
        )
        mainTableView.register(
            NameRecipeCell.self,
            forCellReuseIdentifier: "nameCell"
        )
        mainTableView.register(
            MealDetailsCell.self,
            forCellReuseIdentifier: "mealDetailsCell"
        )
        mainTableView.register(
            NewIngredientCell.self,
            forCellReuseIdentifier: "newIngredientCell"
        )
        mainTableView.register(
            ButtonCell.self,
            forCellReuseIdentifier: "buttonCell"
        )
        return mainTableView
    }()

    // MARK: - Private Properties
    private var ingredientData: [NewIngredient] = []

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.addSubview(mainTableView)

        mainTableView.separatorStyle = .none
        mainTableView.showsVerticalScrollIndicator = false

        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTap)
        )
        self.addGestureRecognizer(tapGesture)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Actions
    @objc private func handleTap() {
        self.endEditing(true)
    }

    @objc private func addIngredient() {
        let newIngredient = NewIngredient(name: "", quantity: 0)

        ingredientData.append(newIngredient)

        let indexPath = IndexPath(row: ingredientData.count - 1, section: 3)

        mainTableView.beginUpdates()
        mainTableView.insertRows(at: [indexPath], with: .automatic)
        mainTableView.endUpdates()

        mainTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }

    func deleteIngredient(at indexPath: IndexPath) {
        ingredientData.remove(at: indexPath.row)

        // Обновите таблицу с анимацией
        mainTableView.beginUpdates()
        mainTableView.deleteRows(at: [indexPath], with: .automatic)
        mainTableView.endUpdates()
    }

    // MARK: - Private Methods
    private func setupConstraints() {
        mainTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource
extension CreateRecipeView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        5
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 2 {
            return 2
        } else if section == 3 {
            return ingredientData.count
        } else {
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard
                let cell = mainTableView.dequeueReusableCell(
                    withIdentifier: "imageCell",
                    for: indexPath) as? RecipeImageCell
            else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        case 1:
            guard
                let cell = mainTableView.dequeueReusableCell(
                    withIdentifier: "nameCell",
                    for: indexPath) as? NameRecipeCell
            else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            return cell
        case 2:
            guard
                let cell = mainTableView.dequeueReusableCell(
                    withIdentifier: "mealDetailsCell",
                    for: indexPath) as? MealDetailsCell
            else {
                return UITableViewCell()
            }

            if indexPath.row == 0 {
                cell.configure("person.2.fill", detail: "Serves", detailLabel: "1", rowNumber: 0)
                cell.selectionStyle = .none
                return cell
            } else {
                cell.configure("clock.fill", detail: "Cook time", detailLabel: "20 min", rowNumber: 1)
                cell.selectionStyle = .none
                return cell
            }
        case 3:
            guard
                let cell = mainTableView.dequeueReusableCell(
                    withIdentifier: "newIngredientCell",
                    for: indexPath) as? NewIngredientCell
            else {
                return UITableViewCell()
            }
            cell.tableView = mainTableView
            cell.delegate = self
            return cell

        default:
            guard
                let cell = mainTableView.dequeueReusableCell(
                    withIdentifier: "buttonCell",
                    for: indexPath) as? ButtonCell
            else {
                return UITableViewCell()
            }
            return cell
        }
    }
}

// MARK: - UITableViewDelegate
extension CreateRecipeView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 1:
            return 50
        case 2:
            return 80
        case 3:
            return 65
        case 4:
            return 70
        default:
            return 240
        }
    }
}

// MARK: - HeaderView
extension CreateRecipeView {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(label)

        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textColor = .black
        label.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }

        switch section {
        case 0:
            label.text = "Create Recipe"
            label.font = UIFont(name: "Poppins-SemiBold", size: 24)
        case 3:
            label.text = "Ingredients"
            label.font = UIFont(name: "Poppins-SemiBold", size: 20)
        default:
            break
        }

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 60
        case 3:
            return 45
        default:
            return 0
        }
    }
}

// MARK: - FooterView
extension CreateRecipeView {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 3 {
            let footerView = UIView()

            let button = UIButton(type: .custom)
            button.setTitle("Add new ingredient", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = UIFont(name: "Poppins-SemiBold", size: 16)
            button.addTarget(self, action: #selector(addIngredient), for: .touchUpInside)

            let plusImage = UIImage(named: "plus")
            let plusImageView = UIImageView(image: plusImage)
            plusImageView.tintColor = .black

            button.addSubview(plusImageView)

            plusImageView.snp.makeConstraints { make in
                make.centerY.equalTo(button.snp.centerY)
                make.left.equalTo(button.snp.left)
                make.width.equalTo(20)
                make.height.equalTo(20)
            }

            footerView.addSubview(button)

            button.snp.makeConstraints { make in
                make.centerY.equalTo(footerView.snp.centerY)
                make.left.equalTo(footerView.snp.left).offset(16)
                make.right.equalTo(footerView.snp.right).offset(-140)
            }

            return footerView
        }

        return nil
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 3 ? 50.0 : 0.0
    }
}

// MARK: - NewIngredientCellDelegate
extension CreateRecipeView: NewIngredientCellDelegate {
    func didTapDeleteButton(cell: NewIngredientCell) {

        if let indexPath = mainTableView.indexPath(for: cell) {
              deleteIngredient(at: indexPath)
          }
    }
}
