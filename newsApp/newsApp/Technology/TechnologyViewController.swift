//
//  GeneralViewController.swift
//  newsApp
//
//  Created by User on 27.11.2023.
//

import UIKit
import SnapKit

final class TechnologyViewController: UIViewController {
    
    // MARK: - GUI Variables
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        
        return searchBar
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let width = (view.frame.width - 15) / 2
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        
        let collectionView = UICollectionView(frame: CGRect(x: 0,
                                                            y: 0,
                                                            width: view.frame.width,
                                                            height: view.frame.height - searchBar.frame.height),
                                              collectionViewLayout: layout)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    // MARK: - Properties
    private var viewModel: TechnologyViewModelProtocol
    
    // MARK: - Initialization
    init(viewModel: TechnologyViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        collectionView.register(TechnologyCollectionViewCell.self,
                                forCellWithReuseIdentifier: "TechnologyCollectionViewCell")
        setupUI()
        self.setupViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setupViewModel() {
        viewModel.reloadData = { [weak self] in
            self?.collectionView.reloadData()
        }
        
        viewModel.reloadCell = { [weak self] row in
            self?.collectionView.reloadItems(at: [IndexPath(row: row,
                                                            section: 0)])
        }
        
        viewModel.showError = { error in
            // TODO: show alert with error
            print(error)
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(5)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension TechnologyViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TechnologyCollectionViewCell",
                                                            for: indexPath) as? TechnologyCollectionViewCell else { return UICollectionViewCell() }
        
        let article = viewModel.getArticle(for: indexPath.row)
        cell.set(article: article)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension TechnologyViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let article = viewModel.getArticle(for: indexPath.row)
        
        navigationController?.pushViewController(NewsVC(viewModel: NewsViewModel(article: article)), animated: true)
    }
}
