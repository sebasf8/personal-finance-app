//
//  CategoryTableViewCell.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 08/06/2021.
//

import UIKit
import Combine

class CategoryTableViewCell: UITableViewCell {
    @IBOutlet private weak var iconView: CategoryIconView!
    @IBOutlet private weak var nameLabel: UILabel!

    private var viewModel: CategoryViewModel?
    private var subscriptions: Set<AnyCancellable> = []

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(viewModel: CategoryViewModel) {
        self.viewModel = viewModel
        iconView.configure(viewModel: viewModel)
        setupBindings()
    }

    func setupBindings() {
        guard let viewModel = viewModel else {
            return
        }

        subscriptions = [
            viewModel.$name.assign(to: \.text!, on: nameLabel)
        ]
    }
}
