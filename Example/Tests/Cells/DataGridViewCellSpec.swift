//
//  DataGridViewCellSpec.swift
//  GlyuckDataGrid
//
//  Created by Vladimir Lyukov on 12/08/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import GlyuckDataGrid


class DataGridViewCellSpec: QuickSpec {
    override func spec() {
        var sut: DataGridViewCell!

        beforeEach {
            sut = DataGridViewCell(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
        }

        describe("textLabel") {
            it("should not be nil") {
                expect(sut.textLabel).to(beTruthy())
            }

            it("should be subview of contentView") {
                expect(sut.textLabel.superview) === sut.contentView
            }

            it("should resize along with cell with respect to cell.textLabelInsets") {
                sut.textLabel.text = ""  // Ensure text label is initialized when tests are started

                sut.textLabelInsets = UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
                sut.frame = CGRectMake(0, 0, sut.frame.width * 2, sut.frame.height / 2)
                sut.layoutIfNeeded()
                expect(sut.textLabel.frame) == UIEdgeInsetsInsetRect(sut.bounds, sut.textLabelInsets)
            }
        }
    }
}
