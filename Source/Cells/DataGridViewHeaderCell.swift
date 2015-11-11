//
//  DataGridViewHeaderCell.swift
//
//  Created by Vladimir Lyukov on 03/08/15.
//

import UIKit


private var setupAppearanceDispatchTocken = dispatch_once_t()


public class DataGridViewHeaderCell: DataGridViewCell {
    public dynamic var normalBackgroundColor: UIColor?
    public dynamic var sortedBackgroundColor: UIColor?
    public var dataGridView: DataGridView!
    public var indexPath: NSIndexPath!
    public var isSorted: Bool = false {
        didSet {
            backgroundColor = isSorted ? sortedBackgroundColor : normalBackgroundColor
        }
    }

    // MARK: - UIView
    public override static func initialize() {
        super.initialize()
        dispatch_once(&setupAppearanceDispatchTocken) {
            let appearance = self.appearance()
            appearance.backgroundColor = UIColor.whiteColor()
            appearance.normalBackgroundColor = UIColor.whiteColor()
            appearance.sortedBackgroundColor = UIColor(white: 220.0/255.0, alpha: 1)
            appearance.textLabelInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
            appearance.borderBottomColor = UIColor(white: 0.73, alpha: 1)
            appearance.borderBottomWidth = 1 / UIScreen.mainScreen().scale

            let labelAppearance = UILabel.glyuck_appearanceWhenContainedIn(self)
            if #available(iOS 8.2, *) {
                labelAppearance.font = UIFont.systemFontOfSize(14, weight: UIFontWeightRegular)
            } else {
                labelAppearance.font = UIFont(name: "HelveticaNeue", size: 14)
            }
            labelAppearance.textAlignment = .Center
            labelAppearance.adjustsFontSizeToFitWidth = true
            labelAppearance.minimumScaleFactor = 0.5
            labelAppearance.numberOfLines = 0
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupDataGridViewHeaderCell()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupDataGridViewHeaderCell()
    }

    // MARK: - Custom methods

    public func setupDataGridViewHeaderCell() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "didTap:")
        contentView.addGestureRecognizer(tapGestureRecognizer)
    }

    func configureForDataGridView(dataGridView: DataGridView, indexPath: NSIndexPath) {
        self.dataGridView = dataGridView
        self.indexPath = indexPath
    }

    public func didTap(gesture: UITapGestureRecognizer) {
        dataGridView.delegateWrapper?.collectionView(dataGridView.collectionView, didTapHeaderForColumn: indexPath.row)
    }
}
