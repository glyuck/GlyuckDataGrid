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
        var stubDelegate: StubDataGridViewDelegate!
        var stubDataSource: StubDataGridViewDataSource!
        var dataGridView: DataGridView!
        var layout: DataGridViewLayout!

        beforeEach {
            stubDelegate = StubDataGridViewDelegate()
            stubDataSource = StubDataGridViewDataSource()
            dataGridView = DataGridView(frame: frame)
            dataGridView.dataSource = stubDataSource
            dataGridView.delegate = stubDelegate
            layout = dataGridView.layout
        }

        describe("layoutAttributesForItemAtIndexPath") {
            // Headers positioning
            context("layout header") {
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
                it("should return greater zIndex then for content cell") {
                    let headerAttributes = layout.layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 0))!
                    let contentAttributes = layout.layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 1))!
                    expect(headerAttributes.zIndex) > contentAttributes.zIndex
                }
                context("when content is scrolled") {
                    beforeEach {
                        dataGridView.contentOffset = CGPointMake(10, 20)
                    }
                    it("should return unscrolled coordinates if offset negative") {
                        dataGridView.contentOffset = CGPointMake(-10, -20)

                        let attributes = layout.layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 0))!

                        expect(attributes.frame) == CGRect(
                            x: 0,
                            y: 0,
                            width: layout.widthForColumn(0),
                            height: layout.heightForSectionHeader()
                        )
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
                context("when there is contentInset") {
                    beforeEach {
                        dataGridView.collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0)
                    }

                    it("should be applied to section header Y position") {
                        let attributes = layout.layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 0))!

                        expect(attributes.frame) == CGRect(
                            x: 0,
                            y: dataGridView.collectionView.contentInset.top + dataGridView.collectionView.contentOffset.y,
                            width: layout.widthForColumn(0),
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

                context("when cell is floating") {
                    it("should return correct coordinates when content scrolled") {
                        // given
                        stubDelegate.floatingColumns = [0, 1]
                        dataGridView.contentOffset = CGPointMake(500, 20)

                        // when
                        let row0Attributes = layout.layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 1))!
                        let row1Attributes = layout.layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: 1, inSection: 1))!

                        // then
                        expect(row0Attributes.frame) == CGRect(
                            x: dataGridView.contentOffset.x,
                            y: layout.heightForSectionHeader(),
                            width: layout.widthForColumn(0),
                            height: layout.heightForRow(0)
                        )
                        expect(row1Attributes.frame) == CGRect(
                            x: dataGridView.contentOffset.x + layout.widthForColumn(0),
                            y: layout.heightForSectionHeader(),
                            width: layout.widthForColumn(1),
                            height: layout.heightForRow(0)
                        )
                    }

                    it("should give greater zIndex for floating cells") {
                        // given
                        stubDelegate.floatingColumns = [1]

                        // when
                        let header0Attributes = layout.layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 0))!
                        let header1Attributes = layout.layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: 1, inSection: 0))!
                        let row0Attributes = layout.layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: 0, inSection: 1))!
                        let row1Attributes = layout.layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: 1, inSection: 1))!

                        // then
                        expect(row1Attributes.zIndex) > row0Attributes.zIndex
                        expect(header1Attributes.zIndex) > header0Attributes.zIndex
                        expect(header1Attributes.zIndex) > row0Attributes.zIndex
                        expect(header1Attributes.zIndex) > row1Attributes.zIndex
                    }
                }
            }

            describe("layoutAttributesForElementsInRect") {
                beforeEach {
                    stubDelegate.rowHeight = 25
                    stubDelegate.sectionHeaderHeight = 50
                    stubDelegate.columnWidth = 100
                }

                func ensureItems(items: [Int], sections: [Int], inLayoutAttributes attributes: [AnyObject]) {
                    expect(attributes.count) == items.count * sections.count
                    let attributes = attributes as! [UICollectionViewLayoutAttributes]
                    for item in items {
                        for section in sections {
                            let res = attributes.filter { $0.indexPath.item == item && $0.indexPath.section == section }.count == 1
                            // Can't make description work in swift 1.2
//                            expect(res).to(beTrue(), description: "Expected layout attributes to contain index path IndexPath(forItem: \(item), inSection: \(section)")
                            expect(res).to(beTrue())
                        }
                    }
                }

                it("should return corresponding rows and columns") {
                    let rect = CGRect(
                        x: 0,
                        y: 0,
                        width: 2 * stubDelegate.columnWidth,
                        height: stubDelegate.sectionHeaderHeight + 2 * stubDelegate.rowHeight
                    )
                    let attributes = layout.layoutAttributesForElementsInRect(rect)

                    ensureItems([0, 1], sections: [0, 1, 2], inLayoutAttributes: attributes!)
                }

                it("should not return off-screen rows/columns") {
                    let rect = CGRect(
                        x: stubDelegate.columnWidth,
                        y: stubDelegate.rowHeight,
                        width: 2 * stubDelegate.columnWidth,
                        height: stubDelegate.sectionHeaderHeight + 2 * stubDelegate.rowHeight
                    )
                    let attributes = layout.layoutAttributesForElementsInRect(rect)

                    ensureItems([1, 2], sections: [0, 2, 3], inLayoutAttributes: attributes!)
                }

                it("should return half-on-screen rows&columns") {
                    let rect = CGRect(
                        x: stubDelegate.columnWidth / 2,
                        y: stubDelegate.rowHeight / 2,
                        width: 2 * stubDelegate.columnWidth,
                        height: stubDelegate.sectionHeaderHeight + 2 * stubDelegate.rowHeight
                    )
                    let attributes = layout.layoutAttributesForElementsInRect(rect)

                    ensureItems([0, 1, 2], sections: [0, 1, 2, 3], inLayoutAttributes: attributes!)
                }

                it("should return veeery wide rows") {
                    stubDelegate.columnWidth = 300
                    let rect = CGRect(x: 350, y: 0, width: 100, height: stubDelegate.sectionHeaderHeight + 2 * stubDelegate.rowHeight)

                    let attributes = layout.layoutAttributesForElementsInRect(rect)

                    ensureItems([1], sections: [0, 1, 2], inLayoutAttributes: attributes!)
                }

                it("should return veeeeery tall columns") {
                    stubDelegate.rowHeight = 300
                    let rect = CGRect(x: 0, y: 325, width: 2 * stubDelegate.columnWidth, height: 100)

                    let attributes = layout.layoutAttributesForElementsInRect(rect)

                    ensureItems([0, 1], sections: [0, 2], inLayoutAttributes: attributes!)
                }
            }
        }

        describe("cells sizes") {
            describe("heightForRow") {
                it("should return delegate's dataGrid:heightForRow if present") {
                    expect(layout.heightForRow(0)) == stubDelegate.rowHeight
                }

                it("should return it's rowHeight if delegate missing/not implements method") {
                    dataGridView.delegate = nil
                    layout.rowHeight = 120
                    expect(layout.heightForRow(0)) == 120
                }
            }

            describe("widthForColumn:") {
                it("should return delegate's dataGrid:widthForColumn:inSection: if present") {
                    expect(layout.widthForColumn(0)) == stubDelegate.columnWidth
                }
                it("should return equal widths for columns if delegate missing/not implements method") {
                    dataGridView.dataSource = stubDataSource
                    dataGridView.delegate = nil
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
                    dataGridView.dataSource = nil
                    dataGridView.delegate = nil
                    expect(layout.widthForColumn(0)) == 0
                }
            }

            describe("heightForHeaderInSection") {
                it("should return delegate's dataGrid:heightForRowAtIndexPath if present") {
                    expect(layout.heightForSectionHeader()) == stubDelegate.sectionHeaderHeight
                }

                it("should return it's rowHeight if delegate missing/not implements method") {
                    dataGridView.delegate = nil
                    layout.sectionHeaderHeight = 120
                    expect(layout.heightForSectionHeader()) == 120
                }
            }
        }

        describe("shouldInvalidateLayoutForBoundsChange") {
            it("should return always true") {
                let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
                let res = layout.shouldInvalidateLayoutForBoundsChange(rect)
                expect(res).to(beTrue())
            }
        }

        describe("collectionViewContentSize") {
            it("should return sum width for all columns and sum height for all rows and header") {
                let size = layout.collectionViewContentSize()
                expect(size.width) == Array(0..<dataGridView.numberOfColumns()).reduce(CGFloat(0)) { $0 + layout.widthForColumn($1) }
                expect(size.height) == Array(0..<dataGridView.numberOfRows()).reduce(layout.heightForSectionHeader()) { $0 + layout.heightForRow($1) }
            }
        }
    }
}
