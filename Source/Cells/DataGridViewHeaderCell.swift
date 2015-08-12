//
//  DataGridViewHeaderCell.swift
//
//  Created by Vladimir Lyukov on 03/08/15.
//

import UIKit


private var setupAppearanceDispatchTocken = dispatch_once_t()


public class DataGridViewHeaderCell: DataGridViewCell {
    public override static func initialize() {
        super.initialize()
        dispatch_once(&setupAppearanceDispatchTocken) {
            let appearance = self.appearance()
            appearance.backgroundColor = UIColor.whiteColor()
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
