//
//  BorderHelper.swift
//  Pods
//
//  Created by Vladimir Lyukov on 13/08/15.
//
//

import UIKit


public class BorderHelper {
    public var topWidth = CGFloat(0) {
        didSet { updateLayer(&topLayer, forBorderWidth: topWidth, color: topColor) }
    }
    public var topColor: UIColor = UIColor.blackColor() {
        didSet { topLayer?.backgroundColor = topColor.CGColor }
    }
    public var leftWidth = CGFloat(0) {
        didSet { updateLayer(&leftLayer, forBorderWidth: leftWidth, color: leftColor) }
    }
    public var leftColor: UIColor = UIColor.blackColor() {
        didSet { leftLayer?.backgroundColor = leftColor.CGColor }
    }
    public var bottomWidth = CGFloat(0) {
        didSet { updateLayer(&bottomLayer, forBorderWidth: bottomWidth, color: bottomColor) }
    }
    public var bottomColor: UIColor = UIColor.blackColor() {
        didSet { bottomLayer?.backgroundColor = bottomColor.CGColor }
    }
    public var rightWidth = CGFloat(0) {
        didSet { updateLayer(&rightLayer, forBorderWidth: rightWidth, color: rightColor) }
    }
    public var rightColor: UIColor = UIColor.blackColor() {
        didSet { rightLayer?.backgroundColor = rightColor.CGColor }
    }

    public var topLayer: CALayer?
    public var leftLayer: CALayer?
    public var bottomLayer: CALayer?
    public var rightLayer: CALayer?

    private weak var view: UIView!

    public init(view: UIView) {
        self.view = view
    }

    private func updateLayer(inout layer:CALayer?, forBorderWidth width: CGFloat, color: UIColor) {
        if width == 0 {
            layer?.removeFromSuperlayer()
            layer = nil
        } else if layer == nil {
            layer = CALayer()
            layer!.backgroundColor = color.CGColor
            view.layer.addSublayer(layer!)
        }
        view.layer.setNeedsLayout()
    }

    public func layoutLayersInFrame(frame: CGRect) {
        topLayer?.backgroundColor = topColor.CGColor
        topLayer?.frame = CGRect(x: 0, y: 0, width: frame.width, height: topWidth)

        leftLayer?.backgroundColor = leftColor.CGColor
        leftLayer?.frame = CGRect(x: 0, y: 0, width: leftWidth, height: frame.height)

        bottomLayer?.backgroundColor = bottomColor.CGColor
        bottomLayer?.frame = CGRect(x: 0, y: frame.height - bottomWidth, width: frame.width, height: bottomWidth)

        rightLayer?.backgroundColor = rightColor.CGColor
        rightLayer?.frame = CGRect(x: frame.width - rightWidth, y: 0, width: rightWidth, height: frame.height)
    }
}
