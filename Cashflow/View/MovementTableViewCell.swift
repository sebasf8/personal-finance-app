//
//  MovementTableViewCell.swift
//  Cashflow
//
//  Created by Sebastian Fernandez on 31/05/2021.
//

import UIKit

class MovementTableViewCell: UITableViewCell {
    @IBOutlet weak private var nameLabel: UILabel!
    @IBOutlet weak private  var dateLabel: UILabel!
    @IBOutlet weak private  var amountLabel: UILabel!
    @IBOutlet weak var categoryView: CategoryIconView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(movement: CashflowItemViewModel) {
        amountLabel.textColor = movement.amountLabelColor
        nameLabel.text = movement.name
        dateLabel.text = movement.date
        amountLabel.text = movement.amount
        categoryView.configure(image: movement.categoryImage, color: movement.categoryColor)
    }

}
