//
//  SearchResultsCell.swift
//  Recipe finder
//
//  Created by Shreyas Rajapurkar on 13/12/21.
//

import Foundation
import UIKit

/**
 Displays a store's icon with it's name
 */

class StoreCell: UICollectionViewCell {
    let nameLabel = UILabel()
    let imageView = UIImageView()

    override func layoutSubviews() {
        super.layoutSubviews()
        setupSubviews()
        setupLayout()
        setupConstraints()
    }

    public func setup(model: Store) {
        setupWithData(model: model)
    }

    private func setupSubviews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(imageView)
    }

    private func setupLayout() {
        nameLabel.font = UIFont.boldSystemFont(ofSize: 15.0)

        contentView.backgroundColor = UIColor.white
        contentView.layer.borderColor = UIColor.darkGray.cgColor
        contentView.layer.borderWidth = 1.0
        contentView.layer.cornerRadius = 10.0

        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.borderWidth = 2.0
        imageView.layer.cornerRadius = 10.0
    }

    private func setupConstraints() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false

        var constraints = [NSLayoutConstraint]()

        constraints.append(imageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16))
        constraints.append(imageView.heightAnchor.constraint(equalToConstant: 48))
        constraints.append(imageView.widthAnchor.constraint(equalToConstant: 48))
        constraints.append(nameLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -16))
        constraints.append(nameLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor))
        constraints.append(imageView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor))

        NSLayoutConstraint.activate(constraints)
    }

    private func setupWithData(model: Store) {
        nameLabel.text = model.name

        if let imageURLString = model.imageURL,
        let imageURL = URL(string: imageURLString) {
            do {
                let imageData = try Data(contentsOf: imageURL)
                let image = UIImage(data: imageData)
                imageView.image = image
            } catch {
                print("Failure")
            }
        }
    }
}
