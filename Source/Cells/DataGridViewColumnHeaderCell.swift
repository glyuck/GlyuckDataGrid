//
//  DataGridViewColumnHeaderCell.swift
//
//  Created by Vladimir Lyukov on 03/08/15.
//

import UIKit


private var setupAppearanceDispatchToken = dispatch_once_t()


public class DataGridViewColumnHeaderCell: DataGridViewBaseHeaderCell {
    // MARK: - UIView
    public override static func initialize() {
        super.initialize()
        dispatch_once(&setupAppearanceDispatchToken) {
            let appearance = self.appearance()
            appearance.backgroundColor = UIColor.whiteColor()
            appearance.normalBackgroundColor = UIColor.whiteColor()
            appearance.sortedBackgroundColor = UIColor(white: 220.0/255.0, alpha: 1)
            appearance.sortAscSuffix = " ↑"
            appearance.sortDescSuffix = " ↓"
            appearance.textLabelInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
            appearance.borderBottomColor = UIColor(white: 0.73, alpha: 1)
            appearance.borderBottomWidth = 1 / UIScreen.mainScreen().scale

            let labelAppearance = UILabel.glyuck_appearanceWhenContainedIn(self)
            if #available(iOS 8.2, *) {
                labelAppearance.appearanceFont = UIFont.systemFontOfSize(14, weight: UIFontWeightRegular)
            } else {
                labelAppearance.appearanceFont = UIFont(name: "HelveticaNeue", size: 14)
            }
            labelAppearance.appearanceTextAlignment = .Center
            labelAppearance.appearanceAdjustsFontSizeToFitWidth = true
            labelAppearance.appearanceMinimumScaleFactor = 0.5
            labelAppearance.appearanceNumberOfLines = 0
        }
    }

    // MARK: - Custom methods

    public override func didTap(gesture: UITapGestureRecognizer) {
        dataGridView.collectionViewDelegate.collectionView(dataGridView.collectionView, didTapHeaderForColumn: indexPath.row)
    }
}
