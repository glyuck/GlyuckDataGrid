//
//  DataGridViewSpec.swift
//
//  Created by Vladimir Lyukov on 31/07/15.
//

import Quick
import Nimble
import GlyuckDataGrid


class DataGridViewLayoutSpec: QuickSpec {
    override func spec() {
        let frame = CGRect(x: 0, y: 0, width: 320, height: 480)
        let stubDelegate = StubDataGridViewDelegate()
        let stubDataSource = StubDataGridViewDataSource()
        var dataGridView: DataGridView!
        var layout: DataGridViewLayout!

        beforeEach {
            layout = DataGridViewLayout()
            dataGridView = DataGridView(frame: frame, collectionViewLayout: layout)
        }

        describe("layoutAttributesForItemAtIndexPath") {
            beforeEach {
                dataGridView.dataGridDataSource = stubDataSource
            }
            // Headers positioning
            context("layout header") {
                it("should return nil if dataGridView is nil") {
                    layout = DataGridViewLayout()
                    expect(layout.layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 0))).to(beNil())
                }
                it("should return correct coordinates for first header") {
                    let attributes = layout.layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 0))!

                    expect(attributes.frame) == CGRect(
                        x: 0,
                        y: 0,
                        width: layout.widthForColumn(0),
                        height: layout.heightForSectionHeader()
                    )
                }
                it("should return correct coordinates for second header") {
                    let attributes = layout.layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: 1, inSection: 0))!

                    expect(attributes.frame) == CGRect(
                        x: layout.widthForColumn(0),
                        y: 0,
                        width: layout.widthForColumn(1),
                        height: layout.heightForSectionHeader()
                    )
                }
                context("when content is scrolled") {
                    beforeEach {
                        dataGridView.contentOffset = CGPointMake(10, 20)
                    }
                    it("should return correct coordinates for first header") {
                        let attributes = layout.layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 0))!

                        expect(attributes.frame) == CGRect(
                            x: 0,
                            y: dataGridView.contentOffset.y,
                            width: layout.widthForColumn(0),
                            height: layout.heightForSectionHeader()
                        )
                    }
                    it("should return correct coordinates for second header") {
                        let attributes = layout.layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: 1, inSection: 0))!

                        expect(attributes.frame) == CGRect(
                            x: layout.widthForColumn(0),
                            y: dataGridView.contentOffset.y,
                            width: layout.widthForColumn(1),
                            height: layout.heightForSectionHeader()
                        )
                    }
                }
            }

            // Cells positioning
            context("layout cells") {
                it("should return correct coordinates for first column in first row") {
                    let attributes = layout.layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 1))!

                    expect(attributes.frame) == CGRect(
                        x: 0,
                        y: layout.heightForSectionHeader(),
                        width: layout.widthForColumn(0),
                        height: layout.heightForRow(0)
                    )
                }
                it("should return correct coordinates for second column in second row") {
                    let attributes = layout.layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: 1, inSection: 2))!

                    expect(attributes.frame) == CGRect(
                        x: layout.widthForColumn(0),
                        y: layout.heightForSectionHeader() + layout.heightForRow(0),
                        width: layout.widthForColumn(1),
                        height: layout.heightForRow(1)
                    )
                }
                context("when content is scrolled") {
                    beforeEach {
                        dataGridView.contentOffset = CGPointMake(10, 20)
                    }
                    it("should return correct coordinates for first column in first row") {
                        let attributes = layout.layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 1))!

                        expect(attributes.frame) == CGRect(
                            x: 0,
                            y: layout.heightForSectionHeader(),
                            width: layout.widthForColumn(0),
                            height: layout.heightForRow(0)
                        )
                    }
                    it("should return correct coordinates for second column in second row") {
                        let attributes = layout.layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: 1, inSection: 2))!

                        expect(attributes.frame) == CGRect(
                            x: layout.widthForColumn(0),
                            y: layout.heightForSectionHeader() + layout.heightForRow(0),
                            width: layout.widthForColumn(1),
                            height: layout.heightForRow(1)
                        )
                    }
                }
            }
        }

        describe("cells sizes") {
            describe("heightForRow") {
                it("should return delegate's dataGrid:heightForRow if present") {
                    dataGridView.dataGridDelegate = stubDelegate
                    expect(layout.heightForRow(0)) == stubDelegate.rowHeight
                }

                it("should return it's rowHeight if delegate missing/not implements method") {
                    layout.rowHeight = 120
                    expect(layout.heightForRow(0)) == 120
                }
            }

            describe("widthForColumn:") {
                it("should return delegate's dataGrid:widthForColumn:inSection: if present") {
                    dataGridView.dataGridDelegate = stubDelegate
                    expect(layout.widthForColumn(0)) == stubDelegate.columnWidth
                }
                it("should return equal widths for columns if delegate missing/not implements method") {
                    dataGridView.dataGridDataSource = stubDataSource
                    stubDataSource.numberOfColumns = 7
                    // Ensure dataGrid width isn't devisible evenly on number of columns
                    let exactColumnWidth = frame.width / CGFloat(stubDataSource.numberOfColumns)
                    expect(ceil(exactColumnWidth)) != exactColumnWidth

                    expect(layout.widthForColumn(0)) == ceil(exactColumnWidth)
                    for i in (1..<stubDataSource.numberOfColumns) {
                        expect(layout.widthForColumn(i)) == floor(exactColumnWidth)
                    }
                }
                it("should return zero if delegate and dataSource are not set") {
                    expect(layout.widthForColumn(0)) == 0
                }
            }

            describe("heightForHeaderInSection") {
                it("should return delegate's dataGrid:heightForRowAtIndexPath if present") {
                    dataGridView.dataGridDelegate = stubDelegate
                    expect(layout.heightForSectionHeader()) == stubDelegate.sectionHeaderHeight
                }

                it("should return it's rowHeight if delegate missing/not implements method") {
                    layout.sectionHeaderHeight = 120
                    expect(layout.heightForSectionHeader()) == 120
                }
            }
        }
    }
}
