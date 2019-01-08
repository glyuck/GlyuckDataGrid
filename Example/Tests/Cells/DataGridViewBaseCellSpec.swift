//
//  DataGridViewBaseCellSpec.swift
//  GlyuckDataGrid
//
//  Created by Vladimir Lyukov on 12/08/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import GlyuckDataGrid


class DataGridViewBaseCellSpec: QuickSpec {
    override func spec() {
        var sut: DataGridViewBaseCell!

        beforeEach {
            sut = DataGridViewBaseCell(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
        }

        describe("textLabel") {
            it("should not be nil") {
                expect(sut.textLabel).notTo(beNil())
            }

            it("should be subview of contentView") {
                expect(sut.textLabel.superview) === sut.contentView
            }

            it("should resize along with cell with respect to cell.textLabelInsets") {
                sut.textLabel.text = ""  // Ensure text label is initialized when tests are started

                sut.textLabelInsets = UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
                sut.frame = CGRect(x: 0, y: 0, width: sut.frame.width * 2, height: sut.frame.height / 2)
                sut.layoutIfNeeded()
                expect(sut.textLabel.frame) == sut.bounds.inset(by: sut.textLabelInsets)
            }
        }
    }
}
