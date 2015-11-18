//
//  BorderHelper.swift
//  Pods
//
//  Created by Vladimir Lyukov on 13/08/15.
//
//

import UIKit


/**
 Helper class for adding and configuring borders to UIView. Can configure top/left/bottom/right borders separately.
*/
public class BorderHelper {
    /// Top border width (in points).
    public var topWidth = CGFloat(0) {
        didSet { updateLayer(&topLayer, forBorderWidth: topWidth, color: topColor) }
    }
    /// Top border color.
    public var topColor: UIColor = UIColor.blackColor() {
        didSet { topLayer?.backgroundColor = topColor.CGColor }
    }
    /// Left border width (in points).
    public var leftWidth = CGFloat(0) {
        didSet { updateLayer(&leftLayer, forBorderWidth: leftWidth, color: leftColor) }
    }
    /// Left border color.
    public var leftColor: UIColor = UIColor.blackColor() {
        didSet { leftLayer?.backgroundColor = leftColor.CGColor }
    }
    /// Bottom border width (in points).
    public var bottomWidth = CGFloat(0) {
        didSet { updateLayer(&bottomLayer, forBorderWidth: bottomWidth, color: bottomColor) }
    }
    /// Bottom border color.
    public var bottomColor: UIColor = UIColor.blackColor() {
        didSet { bottomLayer?.backgroundColor = bottomColor.CGColor }
    }
    /// Right border width (in points.
    public var rightWidth = CGFloat(0) {
        didSet { updateLayer(&rightLayer, forBorderWidth: rightWidth, color: rightColor) }
    }
    /// Right border color.
    public var rightColor: UIColor = UIColor.blackColor() {
        didSet { rightLayer?.backgroundColor = rightColor.CGColor }
    }

    /// Layer used to render top border.
    public var topLayer: CALayer?
    /// Layer used to render left border.
    public var leftLayer: CALayer?
    /// Layer user to render bottom border.
    public var bottomLayer: CALayer?
    /// Layer used to render right border.
    public var rightLayer: CALayer?

    /// Main view to add borders to.
    private weak var view: UIView!

    /**
     Creates and returns border helper for the specified view.

     - parameter view: UIView to add borders to.

     - returns: A newly created border helper.
     */
    public init(view: UIView) {
        self.view = view
    }

    /**
     Creates/destroys layer for border with specified width and color. If width is zero, layer is removed from superview and deallocated.

     - parameter layer: Pointer to border layer to be created/destoyed.
     - parameter width: border width (in points).
     - parameter color: border color.
     */
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

    /**
     Updates borders positions and sizes according to view frame. You should call this function from view.layoutSublayersOfLayer.

     - parameter frame: Parent view frame rectangle.
     */
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
