//
//  BorderHelperSpec.swift
//
//  Created by Vladimir Lyukov on 13/08/15.
//

import Quick
import Nimble
import GlyuckDataGrid


class BorderHelperSpec: QuickSpec {
    override func spec() {
        var view: UIView!
        var sut: BorderHelper!

        beforeEach {
            view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
            sut = BorderHelper(view: view)
        }

        describe("BorderHelper") {
            describe(".topBorder") {
                describe("Layer") {
                    it("should be nil if width == 0") {
                        sut.topWidth = 0
                        expect(sut.topLayer).to(beNil())
                    }
                    it("should not be nil if width != 0") {
                        sut.topWidth = 1
                        expect(sut.topLayer).to(beTruthy())
                    }
                    it("should be sublayer of view.layer") {
                        sut.topWidth = 1
                        expect(sut.topLayer?.superlayer) === view.layer
                    }
                    it("should have correct background color after it's created") {
                        sut.topColor = UIColor.redColor() // Assign border color before border is created
                        sut.topWidth = 1

                        let isEqual = CGColorEqualToColor(sut.topLayer!.backgroundColor, UIColor.redColor().CGColor)
                        expect(isEqual).to(beTrue())
                    }
                    it("should be removed from superlayer and deallocated if width became 0") {
                        sut.topWidth = 1
                        expect(sut.topLayer).to(beTruthy())
                        expect(view.layer.sublayers?.count) == 1

                        sut.topWidth = 0
                        expect(sut.topLayer).to(beNil())
                        expect(view.layer.sublayers).to(beNil())
                    }
                }
                describe("Color") {
                    it("should be assigned to corresponding layer.backgroundColor") {
                        sut.topWidth = 1 // Ensure layer already created

                        sut.topColor = UIColor.greenColor()

                        let isEqual = CGColorEqualToColor(sut.topColor.CGColor, sut?.topLayer?.backgroundColor)
                        expect(isEqual).to(beTrue())
                    }
                }
            }
        }
        // Will just hope that all other borders are working same way as topBorder
        // Don't want to copy-paste this tests 3 times
    }
}
