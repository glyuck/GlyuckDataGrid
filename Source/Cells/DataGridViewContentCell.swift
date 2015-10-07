//
//  DataGridViewContentCell.swift
//
//  Created by Vladimir Lyukov on 03/08/15.
//

import UIKit


private var setupAppearanceDispatchTocken = dispatch_once_t()


public class DataGridViewContentCell: DataGridViewCell {
    public override static func initialize() {
        super.initialize()
        dispatch_once(&setupAppearanceDispatchTocken) {
            let appearance = self.appearance()
            appearance.textLabelInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)

            let labelAppearance = UILabel.glyuck_appearanceWhenContainedIn(self)
            if #available(iOS 8.2, *) {
                labelAppearance.font = UIFont.systemFontOfSize(14, weight: UIFontWeightLight)
            } else {
                labelAppearance.font = UIFont(name: "HelveticaNeue-Light", size: 14)
            }
            labelAppearance.minimumScaleFactor = 0.5
            labelAppearance.numberOfLines = 0
        }
    }
}
