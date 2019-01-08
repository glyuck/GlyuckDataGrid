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
open class BorderHelper {
    /// Top border width (in points).
    open var topWidth = CGFloat(0) {
        didSet { updateLayer(&topLayer, forBorderWidth: topWidth, color: topColor) }
    }
    /// Top border color.
    open var topColor: UIColor = UIColor.black {
        didSet { topLayer?.backgroundColor = topColor.cgColor }
    }
    /// Left border width (in points).
    open var leftWidth = CGFloat(0) {
        didSet { updateLayer(&leftLayer, forBorderWidth: leftWidth, color: leftColor) }
    }
    /// Left border color.
    open var leftColor: UIColor = UIColor.black {
        didSet { leftLayer?.backgroundColor = leftColor.cgColor }
    }
    /// Bottom border width (in points).
    open var bottomWidth = CGFloat(0) {
        didSet { updateLayer(&bottomLayer, forBorderWidth: bottomWidth, color: bottomColor) }
    }
    /// Bottom border color.
    open var bottomColor: UIColor = UIColor.black {
        didSet { bottomLayer?.backgroundColor = bottomColor.cgColor }
    }
    /// Right border width (in points.
    open var rightWidth = CGFloat(0) {
        didSet { updateLayer(&rightLayer, forBorderWidth: rightWidth, color: rightColor) }
    }
    /// Right border color.
    open var rightColor: UIColor = UIColor.black {
        didSet { rightLayer?.backgroundColor = rightColor.cgColor }
    }

    /// Layer used to render top border.
    open var topLayer: CALayer?
    /// Layer used to render left border.
    open var leftLayer: CALayer?
    /// Layer user to render bottom border.
    open var bottomLayer: CALayer?
    /// Layer used to render right border.
    open var rightLayer: CALayer?

    /// Main view to add borders to.
    fileprivate weak var view: UIView!

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
    fileprivate func updateLayer(_ layer:inout CALayer?, forBorderWidth width: CGFloat, color: UIColor) {
        if width == 0 {
            layer?.removeFromSuperlayer()
            layer = nil
        } else if layer == nil {
            layer = CALayer()
            layer!.backgroundColor = color.cgColor
            view.layer.addSublayer(layer!)
        }
        view.layer.setNeedsLayout()
    }

    /**
     Updates borders positions and sizes according to view frame. You should call this function from view.layoutSublayersOfLayer.

     - parameter frame: Parent view frame rectangle.
     */
    open func layoutLayersInFrame(_ frame: CGRect) {
        topLayer?.backgroundColor = topColor.cgColor
        topLayer?.frame = CGRect(x: 0, y: 0, width: frame.width, height: topWidth)

        leftLayer?.backgroundColor = leftColor.cgColor
        leftLayer?.frame = CGRect(x: 0, y: 0, width: leftWidth, height: frame.height)

        bottomLayer?.backgroundColor = bottomColor.cgColor
        bottomLayer?.frame = CGRect(x: 0, y: frame.height - bottomWidth, width: frame.width, height: bottomWidth)

        rightLayer?.backgroundColor = rightColor.cgColor
        rightLayer?.frame = CGRect(x: frame.width - rightWidth, y: 0, width: rightWidth, height: frame.height)
    }
}
