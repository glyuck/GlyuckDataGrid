//
//  DataGridViewRowHeaderCell.swift
//  Pods
//
//  Created by Vladimir Lyukov on 20/11/15.
//
//

import UIKit


private var setupAppearanceDispatchToken = dispatch_once_t()


public class DataGridViewRowHeaderCell: DataGridViewBaseHeaderCell {
    public override static func initialize() {
        super.initialize()
        dispatch_once(&setupAppearanceDispatchToken) {
            let appearance = self.appearance()
            appearance.backgroundColor = UIColor.whiteColor()
            appearance.normalBackgroundColor = UIColor.whiteColor()
            appearance.sortedBackgroundColor = UIColor(white: 220.0/255.0, alpha: 1)
            appearance.sortAscSuffix = " →"
            appearance.sortDescSuffix = " ←"
            appearance.textLabelInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
            appearance.borderRightColor = UIColor(white: 0.73, alpha: 1)
            appearance.borderRightWidth = 1 / UIScreen.mainScreen().scale

            let labelAppearance = UILabel.glyuck_appearanceWhenContainedIn(self)
            if #available(iOS 8.2, *) {
                labelAppearance.font = UIFont.systemFontOfSize(14, weight: UIFontWeightRegular)
            } else {
                labelAppearance.font = UIFont(name: "HelveticaNeue", size: 14)
            }
            labelAppearance.adjustsFontSizeToFitWidth = true
            labelAppearance.minimumScaleFactor = 0.5
            labelAppearance.numberOfLines = 0
        }
    }
}
