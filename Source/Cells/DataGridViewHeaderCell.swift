//
//  DataGridViewHeaderCell.swift
//
//  Created by Vladimir Lyukov on 03/08/15.
//

import UIKit


private var setupAppearanceDispatchTocken = dispatch_once_t()


public class DataGridViewHeaderCell: UICollectionViewCell {
    public dynamic var textLabelInsets = UIEdgeInsetsZero

    private(set) public lazy var textLabel: UILabel = {
        let label = UILabel(frame: self.frame)
        label.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        self.contentView.addSubview(label)
        return label
    }()

    public override var highlighted: Bool {
        didSet {
            backgroundColor = highlighted ? UIColor.lightGrayColor() : UIColor.darkGrayColor()
        }
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        textLabel.frame = UIEdgeInsetsInsetRect(bounds, textLabelInsets)
    }

    public override static func initialize() {
        super.initialize()
        dispatch_once(&setupAppearanceDispatchTocken) {
            let appearance = self.appearance()
            appearance.textLabelInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

            if UILabel.respondsToSelector("appearanceWhenContainedInInstancesOfClasses:") {
                if #available(iOS 9.0, *) {
                    let labelAppearance = UILabel.appearanceWhenContainedInInstancesOfClasses([self])
                    labelAppearance.font = UIFont.systemFontOfSize(14, weight: UIFontWeightRegular)
                    labelAppearance.textAlignment = .Center
                    labelAppearance.adjustsFontSizeToFitWidth = true
                    labelAppearance.minimumScaleFactor = 0.5
                    labelAppearance.numberOfLines = 0
                }
            }
        }
    }
}
