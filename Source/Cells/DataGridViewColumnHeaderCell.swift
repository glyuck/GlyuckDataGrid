//
//  DataGridViewColumnHeaderCell.swift
//
//  Created by Vladimir Lyukov on 03/08/15.
//

import UIKit


open class DataGridViewColumnHeaderCell: DataGridViewBaseHeaderCell {
    private static var __once: () = {
        let appearance = DataGridViewColumnHeaderCell.appearance()
        appearance.backgroundColor = UIColor.white
        appearance.sortedBackgroundColor = UIColor(white: 220.0/255.0, alpha: 1)
        appearance.sortAscSuffix = " ↑"
        appearance.sortDescSuffix = " ↓"
        appearance.textLabelInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        appearance.borderBottomColor = UIColor(white: 0.73, alpha: 1)
        appearance.borderBottomWidth = 1 / UIScreen.main.scale
        
        if let labelAppearance = UILabel.glyuck_appearanceWhenContained(in: DataGridViewColumnHeaderCell.self) {
            if #available(iOS 8.2, *) {
                labelAppearance.appearanceFont = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular)
            } else {
                labelAppearance.appearanceFont = UIFont(name: "HelveticaNeue", size: 14)
            }
            labelAppearance.appearanceTextAlignment = .center
            labelAppearance.appearanceAdjustsFontSizeToFitWidth = true
            labelAppearance.appearanceMinimumScaleFactor = 0.5
            labelAppearance.appearanceNumberOfLines = 0
        }
        
    }()
    // MARK: - UIView
//    open override static func initialize() {
//        super.initialize()
//        _ = DataGridViewColumnHeaderCell.__once
//    }
    
    // MARK: - Custom methods
    
    open override func didTap(_ gesture: UITapGestureRecognizer) {
        dataGridView.collectionViewDelegate.collectionView(dataGridView.collectionView, didTapHeaderForColumn: indexPath.index)
    }
}
