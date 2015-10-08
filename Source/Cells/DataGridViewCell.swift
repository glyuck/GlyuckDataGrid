//
//  DataGridViewCell.swift
//  Pods
//
//  Created by Vladimir Lyukov on 12/08/15.
//
//

import UIKit

public class DataGridViewCell: UICollectionViewCell {
    public dynamic var textLabelInsets = UIEdgeInsetsZero
    public dynamic var highlightedBackgroundColor = UIColor(white: 0.9, alpha: 1)
    public dynamic var selectedBackgroundColor = UIColor(white: 0.8, alpha: 1)

    // borders
    public lazy var border: BorderHelper = {
        BorderHelper(view: self)
    }()

    private(set) public lazy var textLabel: UILabel = {
        let label = UILabel(frame: self.bounds)
        self.contentView.addSubview(label)
        return label
        }()

    public override var highlighted: Bool {
        didSet {
            contentView.backgroundColor = highlighted ? highlightedBackgroundColor : UIColor.clearColor()
        }
    }

    public override var selected: Bool {
        didSet {
            contentView.backgroundColor = selected ? selectedBackgroundColor : UIColor.clearColor()
        }
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        textLabel.frame = UIEdgeInsetsInsetRect(bounds, textLabelInsets)
    }

    public override func layoutSublayersOfLayer(layer: CALayer) {
        super.layoutSublayersOfLayer(layer)
        if layer == self.layer {
            border.layoutLayersInFrame(layer.frame)
        }
    }
}

// Border getters/setters for UIAppearance
extension DataGridViewCell {
    public dynamic var borderTopWidth: CGFloat {
        get { return border.topWidth }
        set { border.topWidth = newValue }
    }
    public dynamic var topColor: UIColor {
        get { return border.topColor }
        set { border.topColor = newValue }
    }
    public dynamic var borderLeftWidth: CGFloat {
        get { return border.leftWidth }
        set { border.leftWidth = newValue }
    }
    public dynamic var borderLeftColor: UIColor {
        get { return border.leftColor }
        set { border.leftColor = newValue }
    }
    public dynamic var borderBottomWidth: CGFloat {
        get { return border.bottomWidth }
        set { border.bottomWidth = newValue }
    }
    public dynamic var borderBottomColor: UIColor {
        get { return border.bottomColor }
        set { border.bottomColor = newValue }
    }
    public dynamic var borderRightWidth: CGFloat {
        get { return border.rightWidth }
        set { border.rightWidth = newValue }
    }

    public dynamic var borderRightColor: UIColor {
        get { return border.rightColor }
        set { border.rightColor = newValue }
    }
}
