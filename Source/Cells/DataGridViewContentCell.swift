//
//  DataGridViewContentCell.swift
//
//  Created by Vladimir Lyukov on 03/08/15.
//

import UIKit


private var setupAppearanceDispatchToken = dispatch_once_t()


/**
 Class for default data grid view cell.
*/
public class DataGridViewContentCell: DataGridViewCell {
    public override static func initialize() {
        super.initialize()
        dispatch_once(&setupAppearanceDispatchToken) {
            let appearance = self.appearance()
            appearance.textLabelInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)

            let labelAppearance = UILabel.glyuck_appearanceWhenContainedIn(self)
            if #available(iOS 8.2, *) {
                labelAppearance.appearanceFont = UIFont.systemFontOfSize(14, weight: UIFontWeightLight)
            } else {
                labelAppearance.appearanceFont = UIFont(name: "HelveticaNeue-Light", size: 14)
            }
            labelAppearance.appearanceMinimumScaleFactor = 0.5
            labelAppearance.appearanceNumberOfLines = 0
        }
    }
}
