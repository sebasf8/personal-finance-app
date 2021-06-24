//
//  CollectionViewController.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 19/06/2021.
//

import UIKit

private let reuseIdentifier = "CategoryCell"

class CategoryCollectionViewController: UICollectionViewController {
    private var viewModel: CategoryImageCollectionViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        clearsSelectionOnViewWillAppear = false
        configureNavigationBar()
        registerCell()
    }

    func configure(viewModel: CategoryImageCollectionViewModel) {
        self.viewModel = viewModel
    }

    private func configureNavigationBar() {
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        let saveButton = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(save))

        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = saveButton
    }

    private func registerCell() {
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        self.collectionView!.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
    }

    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel?.numberOfElements ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)

        if let cell = cell as? CategoryCollectionViewCell, let viewModel = viewModel {
            cell.configure(image: viewModel.getImageFor(index: indexPath.row))
        }

        return cell
    }

    @objc func cancel() {
        navigationController?.popViewController(animated: true)
    }

    @objc func save() {
        viewModel?.save()
        navigationController?.popViewController(animated: true)
    }

    // MARK: UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView,
                                 shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        viewModel?.selectImageAt(index: indexPath.row)
        return true
    }
}
