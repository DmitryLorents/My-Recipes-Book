//
//  HomeView.swift
//  My-Recipes-Book
//
//  Created by Дмитрий Лоренц on 28.08.2023.
//

import UIKit
import SnapKit

class HomeView: UIView {

    //MARK: - Properties
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView()//frame: .zero)//, collectionViewLayout: self.createCompositionalLayout() )
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .yellow
        return collectionView
    }()


    //MARK: - UI Elements


    //MARK: - Init

    override init (frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Palette.redPrimary80
        setOutlets()
        setupConstraints()

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Methods
    
    private func setOutlets() {
        self.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
//    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
//        
//        
//    }

}

//MARK: - UICollectionViewDelegate

extension HomeView: UICollectionViewDelegate {
    
}

//MARK: - UICollectionViewDataSource

extension HomeView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        UICollectionViewCell()
    }
    
    
}
