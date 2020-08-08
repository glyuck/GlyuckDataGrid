//
//  DataGridViewBaseCell.swift
//  Pods
//
//  Created by Vladimir Lyukov on 12/08/15.
//
//

import UIKit


/**
 Base class for data grid view cells.
*/
open class DataGridViewBaseCell: UICollectionViewCell {
    /// The inset or outset margins for the rectangle around the cell’s text label.
    @objc open dynamic var textLabelInsets = UIEdgeInsets.zero
    /// Background color for highlighted state.
    @objc open dynamic var highlightedBackgroundColor = UIColor(white: 0.9, alpha: 1)
    /// Background color for selected state.
    @objc open dynamic var selectedBackgroundColor = UIColor(white: 0.8, alpha: 1)
    /// Helper object for configuring cell borders.
    open lazy var border: BorderHelper = {
        BorderHelper(view: self)
    }()

    /// Returns the label used for the main textual content of the table cell. (read-only)
    fileprivate(set) open lazy var textLabel: UILabel = {
        let label = UILabel(frame: self.bounds)
        self.contentView.addSubview(label)
        return label
    }()

    // MARK: - UICollectionViewCell

    open override var isHighlighted: Bool {
        didSet {
            contentView.backgroundColor = isHighlighted ? highlightedBackgroundColor : UIColor.clear
        }
    }

    open override var isSelected: Bool {
        didSet {
            contentView.backgroundColor = isSelected ? selectedBackgroundColor : UIColor.clear
        }
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        textLabel.frame = bounds.inset(by: textLabelInsets)
    }

    open override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        if layer == self.layer {
            border.layoutLayersInFrame(layer.frame)
        }
    }
}

// Border getters/setters for UIAppearance
extension DataGridViewBaseCell {
    @objc public dynamic var borderTopWidth: CGFloat {
        get { return border.topWidth }
        set { border.topWidth = newValue }
    }
    @objc public dynamic var borderTopColor: UIColor {
        get { return border.topColor }
        set { border.topColor = newValue }
    }
    @objc public dynamic var borderLeftWidth: CGFloat {
        get { return border.leftWidth }
        set { border.leftWidth = newValue }
    }
    @objc public dynamic var borderLeftColor: UIColor {
        get { return border.leftColor }
        set { border.leftColor = newValue }
    }
    @objc public dynamic var borderBottomWidth: CGFloat {
        get { return border.bottomWidth }
        set { border.bottomWidth = newValue }
    }
    @objc public dynamic var borderBottomColor: UIColor {
        get { return border.bottomColor }
        set { border.bottomColor = newValue }
    }
    @objc public dynamic var borderRightWidth: CGFloat {
        get { return border.rightWidth }
        set { border.rightWidth = newValue }
    }

    @objc public dynamic var borderRightColor: UIColor {
        get { return border.rightColor }
        set { border.rightColor = newValue }
    }
}
