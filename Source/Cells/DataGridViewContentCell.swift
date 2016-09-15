//
//  DataGridViewContentCell.swift
//
//  Created by Vladimir Lyukov on 03/08/15.
//

import UIKit


private var setupAppearanceDispatchToken = Int()


/**
 Class for default data grid view cell.
*/
open class DataGridViewContentCell: DataGridViewBaseCell {
    private static var __once: () = {
            let appearance = self.appearance()
            appearance.textLabelInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)

            let labelAppearance = UILabel.glyuck_appearanceWhenContained(in: self)
            if #available(iOS 8.2, *) {
                labelAppearance.appearanceFont = UIFont.systemFont(ofSize: 14, weight: UIFontWeightLight)
            } else {
                labelAppearance.appearanceFont = UIFont(name: "HelveticaNeue-Light", size: 14)
            }
            labelAppearance.appearanceMinimumScaleFactor = 0.5
            labelAppearance.appearanceNumberOfLines = 0
        }()
    open override static func initialize() {
        super.initialize()
        _ = DataGridViewContentCell.__once
    }
}
