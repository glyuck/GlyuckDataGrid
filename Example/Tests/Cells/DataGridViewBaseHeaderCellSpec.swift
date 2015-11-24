//
//  DataGridViewBaseHeaderCellSpec.swift
//  GlyuckDataGrid
//
//  Created by Vladimir Lyukov on 24/11/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import Quick
import Nimble
import GlyuckDataGrid


class DataGridViewBaseHeaderCellSpec: QuickSpec {
    override func spec() {
        var sut: DataGridViewBaseHeaderCell!

        beforeEach {
            sut = DataGridViewBaseHeaderCell(frame: CGRect(x: 0, y: 0, width: 100, height: 60))
        }

        describe("DataGridViewBaseHeaderCell") {
            it("should have textLabel.title updated according to isSorted and isSortedAsc") {
                sut.sortAscSuffix = " ASC"
                sut.sortDescSuffix = " DESC"

                sut.title = "Title"
                expect(sut.textLabel.text) == "Title"

                sut.isSorted = true
                expect(sut.textLabel.text) == "Title ASC"

                sut.isSortedAsc = false
                expect(sut.textLabel.text) == "Title DESC"

                sut.title = "Title 2"
                expect(sut.textLabel.text) == "Title 2 DESC"

                sut.isSorted = false
                expect(sut.textLabel.text) == "Title 2"
            }

            it("should update backgroundColor according to isSorted") {
                sut.backgroundColor = UIColor.greenColor()
                sut.sortedBackgroundColor = UIColor.redColor()

                expect(sut.backgroundColor) == UIColor.greenColor()

                sut.isSorted = true
                expect(sut.backgroundColor) == UIColor.redColor()

                sut.isSorted = false
                expect(sut.backgroundColor) == UIColor.greenColor()
            }
        }
    }
}
