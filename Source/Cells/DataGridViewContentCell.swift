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
                labelAppearance.font = UIFont.systemFontOfSize(15, weight: UIFontWeightLight)
            } else {
                labelAppearance.font = UIFont(name: "HelveticaNeue-Light", size: 15)
            }
            labelAppearance.minimumScaleFactor = 0.5
            labelAppearance.numberOfLines = 0
        }
    }
}
