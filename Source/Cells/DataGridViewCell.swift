//
//  DataGridViewCell.swift
//  Pods
//
//  Created by Vladimir Lyukov on 12/08/15.
//
//

import UIKit

public class DataGridViewCell: UICollectionViewCell {
    public dynamic var textLabelInsets = UIEdgeInsetsZero
    public dynamic var highlightedBackgroundColor = UIColor(white: 0.9, alpha: 1)
    public dynamic var selectedBackgroundColor = UIColor(white: 0.8, alpha: 1)

    private(set) public lazy var textLabel: UILabel = {
        let label = UILabel(frame: self.frame)
        label.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.contentView.addSubview(label)
        return label
        }()

    public override var highlighted: Bool {
        didSet {
            contentView.backgroundColor = highlighted ? highlightedBackgroundColor : UIColor.clearColor()
        }
    }

    public override var selected: Bool {
        didSet {
            contentView.backgroundColor = selected ? selectedBackgroundColor : UIColor.clearColor()
        }
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        textLabel.frame = UIEdgeInsetsInsetRect(bounds, textLabelInsets)
    }
}
