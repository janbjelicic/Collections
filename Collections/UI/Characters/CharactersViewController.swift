//
//  CharactersViewController.swift
//  Collections
//
//  Created by Jan Bjelicic on 19/03/2021.
//

import UIKit

class CharactersViewController: UICollectionViewController {

    private var viewModel: CharactersViewModel!
    
    func configure(viewModel: CharactersViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigationBar()
        fetchCharacters()
    }
    
    private func setupCollectionView() {
        collectionView.collectionViewLayout = compositionalLayout
    }
    
    private func setupNavigationBar() {
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh))
        navigationItem.rightBarButtonItem = refreshButton
    }
    
    @objc func refresh() {
        fetchCharacters()
    }
    
    private func fetchCharacters() {
        viewModel.fetchCharacters { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showErrorAlert()
                }
                print(error)
            }
        }
    }
    
    private func showErrorAlert() {
        let alert = UIAlertController(title: "Error",
                                      message: "Error occurred, try again later",
                                      preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        present(alert, animated: false)
    }

}

// MARK: - Collection View data source
extension CharactersViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.data.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.data[section].characters.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.characterCellID,
                                                            for: indexPath) else {
            return UICollectionViewCell()
        }
        cell.lblName.text = viewModel.data[indexPath.section].characters[indexPath.row].name
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                           withReuseIdentifier: R.reuseIdentifier.characterHeaderID,
                                                                           for: indexPath) else {
            return UICollectionReusableView()
        }
        header.lblTitle.text = viewModel.data[indexPath.section].race.rawValue
        return header
    }
    
}

// MARK: - Collection View delegate
extension CharactersViewController {
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.coordinator?.showCharacterDetails(character: viewModel.data[indexPath.section].characters[indexPath.row])
    }
    
}

// MARK: - Flow layout
extension CharactersViewController: UICollectionViewDelegateFlowLayout {
    
    private var compositionalLayout: UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                                                 heightDimension: .fractionalHeight(1.0)))
            item.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 0.0, bottom: 0.0, trailing: 0.0)
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .estimated(136),
                                                                                              heightDimension: .absolute(44)),
                                                           subitem: item,
                                                           count: 1)
            let section = NSCollectionLayoutSection(group: group)
            
            let headerView = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .absolute(44)),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)
            headerView.pinToVisibleBounds = true
            section.boundarySupplementaryItems = [headerView]

            section.contentInsets = NSDirectionalEdgeInsets(top: 16.0,
                                                            leading: 0.0,
                                                            bottom: 16.0,
                                                            trailing: 0.0)

            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            return section
        }
        return layout
    }
    
}
