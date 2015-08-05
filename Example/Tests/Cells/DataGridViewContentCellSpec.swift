//
//  DataGridViewContentCellSpec.swift
//
//  Created by Vladimir Lyukov on 03/08/15.
//

import Quick
import Nimble
import GlyuckDataGrid


class DataGridViewContentCellSpec: QuickSpec {
    override func spec() {
        var cell: DataGridViewContentCell!

        beforeEach {
            cell = DataGridViewContentCell(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
        }

        describe("textLabel") {
            it("should not be nil") {
                expect(cell.textLabel).to(beTruthy())
            }

            it("should be subview of contentView") {
                expect(cell.textLabel.superview) === cell.contentView
            }

            it("should resize along with cell with respect to cell.textLabelInsets") {
                cell.textLabel.text = ""  // Ensure text label is initialized when tests are started

                cell.textLabelInsets = UIEdgeInsets(top: 1, left: 2, bottom: 3, right: 4)
                cell.frame = CGRectMake(0, 0, cell.frame.width * 2, cell.frame.height / 2)
                cell.layoutIfNeeded()
                expect(cell.textLabel.frame) == UIEdgeInsetsInsetRect(cell.bounds, cell.textLabelInsets)
            }
        }
    }
}