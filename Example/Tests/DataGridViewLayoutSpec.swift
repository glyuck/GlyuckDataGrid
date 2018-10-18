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
        var sut: DataGridViewLayout!

        beforeEach {
            stubDelegate = StubDataGridViewDelegate()
            stubDataSource = StubDataGridViewDataSource()
            dataGridView = DataGridView(frame: frame)
            dataGridView.rowHeaderWidth = 44
            dataGridView.dataSource = stubDataSource
            dataGridView.delegate = stubDelegate
            sut = dataGridView.collectionView.collectionViewLayout as? DataGridViewLayout
        }

        describe("layoutAttributesForSupplementaryViewOfKind:atIndexPath:") {
            context("when there are 0 rows in table") {
                it("should return supplementary views for headers and don't crash") {
                    stubDataSource.numberOfRows = 0

                    let attributes = sut.layoutAttributesForSupplementaryView(ofKind: DataGridView.SupplementaryViewKind.ColumnHeader.rawValue, at: IndexPath(item: 0, section: 0))!

                    expect(attributes.frame) == CGRect(
                        x: dataGridView.rowHeaderWidth,
                        y: 0,
                        width: sut.widthForColumn(0),
                        height: sut.heightForSectionHeader()
                    )
                }
            }
            context("layout column header") {
                it("should return correct coordinates for first header") {
                    let attributes = sut.layoutAttributesForSupplementaryView(ofKind: DataGridView.SupplementaryViewKind.ColumnHeader.rawValue, at: IndexPath(index: 0))!

                    expect(attributes.frame) == CGRect(
                        x: dataGridView.rowHeaderWidth,
                        y: 0,
                        width: sut.widthForColumn(0),
                        height: sut.heightForSectionHeader()
                    )
                }
                it("should return correct coordinates for second header") {
                    let attributes = sut.layoutAttributesForSupplementaryView(ofKind: DataGridView.SupplementaryViewKind.ColumnHeader.rawValue, at: IndexPath(index: 1))!

                    expect(attributes.frame) == CGRect(
                        x: dataGridView.rowHeaderWidth + sut.widthForColumn(0),
                        y: 0,
                        width: sut.widthForColumn(1),
                        height: sut.heightForSectionHeader()
                    )
                }
                it("should return greater zIndex then for content cell") {
                    let headerAttributes = sut.layoutAttributesForSupplementaryView(ofKind: DataGridView.SupplementaryViewKind.ColumnHeader.rawValue, at: IndexPath(index: 0))!
                    let contentAttributes = sut.layoutAttributesForItem(at: IndexPath(item: 0, section: 0))!
                    expect(headerAttributes.zIndex) > contentAttributes.zIndex
                }
                context("when content is scrolled") {
                    beforeEach {
                        dataGridView.contentOffset = CGPoint(x: 10, y: 20)
                    }
                    it("should return unscrolled coordinates if offset negative") {
                        dataGridView.contentOffset = CGPoint(x: -10, y:
                            -20)

                        let attributes = sut.layoutAttributesForSupplementaryView(ofKind: DataGridView.SupplementaryViewKind.ColumnHeader.rawValue, at: IndexPath(index: 0))!

                        expect(attributes.frame) == CGRect(
                            x: dataGridView.rowHeaderWidth,
                            y: 0,
                            width: sut.widthForColumn(0),
                            height: sut.heightForSectionHeader()
                        )
                    }
                    it("should return correct coordinates for first header") {
                        let attributes = sut.layoutAttributesForSupplementaryView(ofKind: DataGridView.SupplementaryViewKind.ColumnHeader.rawValue, at: IndexPath(index: 0))!

                        expect(attributes.frame) == CGRect(
                            x: dataGridView.rowHeaderWidth,
                            y: dataGridView.contentOffset.y,
                            width: sut.widthForColumn(0),
                            height: sut.heightForSectionHeader()
                        )
                    }
                    it("should return correct coordinates for second header") {
                        let attributes = sut.layoutAttributesForSupplementaryView(ofKind: DataGridView.SupplementaryViewKind.ColumnHeader.rawValue, at: IndexPath(index: 1))!

                        expect(attributes.frame) == CGRect(
                            x: dataGridView.rowHeaderWidth + sut.widthForColumn(0),
                            y: dataGridView.contentOffset.y,
                            width: sut.widthForColumn(1),
                            height: sut.heightForSectionHeader()
                        )
                    }
                }
                context("when there is contentInset") {
                    beforeEach {
                        dataGridView.collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0)
                    }

                    it("should be applied to section header Y position") {
                        let attributes = sut.layoutAttributesForSupplementaryView(ofKind: DataGridView.SupplementaryViewKind.ColumnHeader.rawValue, at: IndexPath(index: 0))!

                        expect(attributes.frame) == CGRect(
                            x: dataGridView.rowHeaderWidth,
                            y: dataGridView.collectionView.contentInset.top + dataGridView.collectionView.contentOffset.y,
                            width: sut.widthForColumn(0),
                            height: sut.heightForSectionHeader()
                        )
                    }
                }
            }

            context("layout rows header") {
                it("should return correct coordinates for first header") {
                    let attributes = sut.layoutAttributesForRowHeaderViewAtIndexPath(IndexPath(index: 0))!

                    expect(attributes.frame) == CGRect(
                        x: 0,
                        y: sut.heightForSectionHeader(),
                        width: sut.widthForRowHeader(),
                        height: sut.heightForRow(0)
                    )
                }
                it("should return correct coordinates for second header") {
                    let attributes = sut.layoutAttributesForRowHeaderViewAtIndexPath(IndexPath(index: 1))!

                    expect(attributes.frame) == CGRect(
                        x: 0,
                        y: sut.heightForSectionHeader() + sut.heightForRow(0),
                        width: sut.widthForRowHeader(),
                        height: sut.heightForRow(1)
                    )
                }
                it("should return greater zIndex then for content cell") {
                    let headerAttributes = sut.layoutAttributesForRowHeaderViewAtIndexPath(IndexPath(index: 0))!
                    let contentAttributes = sut.layoutAttributesForItem(at: IndexPath(item: 0, section: 0))!
                    expect(headerAttributes.zIndex) > contentAttributes.zIndex
                }
                context("when content is scrolled") {
                    beforeEach {
                        dataGridView.contentOffset = CGPoint(x: 10, y: 20)
                    }
                    it("should return unscrolled coordinates if offset negative") {
                        dataGridView.contentOffset = CGPoint(x: -10, y: -20)

                        let attributes = sut.layoutAttributesForRowHeaderViewAtIndexPath(IndexPath(index: 0))!

                        expect(attributes.frame) == CGRect(
                            x: 0,
                            y: sut.heightForSectionHeader(),
                            width: sut.widthForRowHeader(),
                            height: sut.heightForRow(0)
                        )
                    }
                    it("should return correct coordinates for first header") {
                        let attributes = sut.layoutAttributesForRowHeaderViewAtIndexPath(IndexPath(index: 0))!

                        expect(attributes.frame) == CGRect(
                            x: dataGridView.contentOffset.x,
                            y: sut.heightForSectionHeader(),
                            width: sut.widthForRowHeader(),
                            height: sut.heightForRow(0)
                        )
                    }
                    it("should return correct coordinates for second header") {
                        let attributes = sut.layoutAttributesForRowHeaderViewAtIndexPath(IndexPath(index: 1))!

                        expect(attributes.frame) == CGRect(
                            x: dataGridView.contentOffset.x,
                            y: sut.heightForSectionHeader() + sut.heightForRow(0),
                            width: sut.widthForRowHeader(),
                            height: sut.heightForRow(1)
                        )
                    }
                    context("when there is contentInset") {
                        beforeEach {
                            dataGridView.collectionView.contentInset = UIEdgeInsets(top: 10, left: 5, bottom: 0, right: 0)
                        }

                        it("should be applied to row header X position") {
                            let attributes = sut.layoutAttributesForRowHeaderViewAtIndexPath(IndexPath(index: 0))!

                            expect(attributes.frame) == CGRect(
                                x: dataGridView.collectionView.contentInset.left + dataGridView.collectionView.contentOffset.x,
                                y: sut.heightForSectionHeader(),
                                width: sut.widthForRowHeader(),
                                height: sut.heightForRow(0)
                            )
                        }
                    }
                }
            }
            context("layout corner header") {
                it("should return correct coordinates for top-left corner header") {
                    let attributes = sut.layoutAttributesForCornerHeaderViewAtIndexPath(IndexPath(index: 0))!

                    expect(attributes.frame) == CGRect(
                        x: 0,
                        y: 0,
                        width: sut.widthForRowHeader(),
                        height: sut.heightForSectionHeader()
                    )
                }
                it("should return greater zIndex then for content and header cells") {
                    let cornerHeaderAttributes = sut.layoutAttributesForCornerHeaderViewAtIndexPath(IndexPath(index: 0))!
                    let rowHeaderAttributes = sut.layoutAttributesForRowHeaderViewAtIndexPath(IndexPath(index: 0))!
                    let columnHeaderAttributes = sut.layoutAttributesForColumnHeaderViewAtIndexPath(IndexPath(index: 0))!
                    let contentAttributes = sut.layoutAttributesForItem(at: IndexPath(item: 0, section: 0))!
                    expect(cornerHeaderAttributes.zIndex) > rowHeaderAttributes.zIndex
                    expect(cornerHeaderAttributes.zIndex) > columnHeaderAttributes.zIndex
                    expect(cornerHeaderAttributes.zIndex) > contentAttributes.zIndex
                }
                context("when content is scrolled") {
                    beforeEach {
                        dataGridView.contentOffset = CGPoint(x: 10, y: 20)
                    }
                    it("should return unscrolled coordinates if offset negative") {
                        dataGridView.contentOffset = CGPoint(x: -10, y: -20)

                        let attributes = sut.layoutAttributesForCornerHeaderViewAtIndexPath(IndexPath(index: 0))!

                        expect(attributes.frame) == CGRect(
                            x: 0,
                            y: 0,
                            width: sut.widthForRowHeader(),
                            height: sut.heightForSectionHeader()
                        )
                    }
                    it("should return correct coordinates for top-left corner header") {
                        let attributes = sut.layoutAttributesForCornerHeaderViewAtIndexPath(IndexPath(index: 0))!

                        expect(attributes.frame) == CGRect(
                            x: dataGridView.contentOffset.x,
                            y: dataGridView.contentOffset.y,
                            width: sut.widthForRowHeader(),
                            height: sut.heightForSectionHeader()
                        )
                    }
                    context("when there is contentInset") {
                        beforeEach {
                            dataGridView.collectionView.contentInset = UIEdgeInsets(top: 10, left: 5, bottom: 0, right: 0)
                        }

                        it("should be applied to row header X position") {
                            let attributes = sut.layoutAttributesForCornerHeaderViewAtIndexPath(IndexPath(index: 0))!

                            expect(attributes.frame) == CGRect(
                                x: dataGridView.collectionView.contentInset.left + dataGridView.collectionView.contentOffset.x,
                                y: dataGridView.collectionView.contentInset.top + dataGridView.collectionView.contentOffset.y,
                                width: sut.widthForRowHeader(),
                                height: sut.heightForSectionHeader()
                            )
                        }
                    }
                }
            }
        }

        describe("layoutAttributesForItemAtIndexPath") {
            // Cells positioning
            context("layout cells") {
                it("should return correct coordinates for first column in first row") {
                    let attributes = sut.layoutAttributesForItem(at: IndexPath(item: 0, section: 0))!

                    expect(attributes.frame) == CGRect(
                        x: sut.widthForRowHeader(),
                        y: sut.heightForSectionHeader(),
                        width: sut.widthForColumn(0),
                        height: sut.heightForRow(0)
                    )
                }
                it("should return correct coordinates for second column in second row") {
                    let attributes = sut.layoutAttributesForItem(at: IndexPath(item: 1, section: 1))!

                    expect(attributes.frame) == CGRect(
                        x: sut.widthForRowHeader() + sut.widthForColumn(0),
                        y: sut.heightForSectionHeader() + sut.heightForRow(0),
                        width: sut.widthForColumn(1),
                        height: sut.heightForRow(1)
                    )
                }
                context("when content is scrolled") {
                    beforeEach {
                        dataGridView.contentOffset = CGPoint(x: 10, y: 20)
                    }
                    it("should return correct coordinates for first column in first row") {
                        let attributes = sut.layoutAttributesForItem(at: IndexPath(item: 0, section: 0))!

                        expect(attributes.frame) == CGRect(
                            x: sut.widthForRowHeader(),
                            y: sut.heightForSectionHeader(),
                            width: sut.widthForColumn(0),
                            height: sut.heightForRow(0)
                        )
                    }
                    it("should return correct coordinates for second column in second row") {
                        let attributes = sut.layoutAttributesForItem(at: IndexPath(item: 1, section: 1))!

                        expect(attributes.frame) == CGRect(
                            x: sut.widthForRowHeader() + sut.widthForColumn(0),
                            y: sut.heightForSectionHeader() + sut.heightForRow(0),
                            width: sut.widthForColumn(1),
                            height: sut.heightForRow(1)
                        )
                    }
                }

                context("when cell is floating") {
                    it("should return correct coordinates when content scrolled") {
                        // given
                        stubDelegate.floatingColumns = [0, 1]
                        dataGridView.contentOffset = CGPoint(x: 500, y: 20)

                        // when
                        let row0Attributes = sut.layoutAttributesForItem(at: IndexPath(item: 0, section: 0))!
                        let row1Attributes = sut.layoutAttributesForItem(at: IndexPath(item: 1, section: 0))!

                        // then
                        expect(row0Attributes.frame) == CGRect(
                            x: dataGridView.contentOffset.x,
                            y: sut.heightForSectionHeader(),
                            width: sut.widthForColumn(0),
                            height: sut.heightForRow(0)
                        )
                        expect(row1Attributes.frame) == CGRect(
                            x: dataGridView.contentOffset.x + sut.widthForColumn(0),
                            y: sut.heightForSectionHeader(),
                            width: sut.widthForColumn(1),
                            height: sut.heightForRow(0)
                        )
                    }

                    it("should give greater zIndex for floating cells") {
                        // given
                        stubDelegate.floatingColumns = [1]

                        // when
                        let header0Attributes = sut.layoutAttributesForSupplementaryView(ofKind: DataGridView.SupplementaryViewKind.ColumnHeader.rawValue, at: IndexPath(index: 0))!
                        let header1Attributes = sut.layoutAttributesForSupplementaryView(ofKind: DataGridView.SupplementaryViewKind.ColumnHeader.rawValue, at: IndexPath(index: 1))!
                        let row0Attributes = sut.layoutAttributesForItem(at: IndexPath(item: 0, section: 0))!
                        let row1Attributes = sut.layoutAttributesForItem(at: IndexPath(item: 1, section: 0))!

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
                    dataGridView.rowHeaderWidth = 0
                    dataGridView.columnHeaderHeight = 50
                    stubDelegate.columnWidth = 100
                }

                func isAttribute(_ attr: UICollectionViewLayoutAttributes, forIndexPath indexPath: IndexPath, forSupplementaryViewOfKind kind: DataGridView.SupplementaryViewKind) -> Bool {
                    return attr.indexPath == indexPath
                        && attr.representedElementCategory == .supplementaryView
                        && attr.representedElementKind == kind.rawValue
                }

                func ensure(items: [Int], sections: [Int], columnHeader: Bool, rowHeader: Bool, inRect rect: CGRect, file: FileString = #file, line: UInt = #line) {
                    let attributes = sut.layoutAttributesForElements(in: rect)!
                    expect(attributes.count, file: file, line: line) == items.count * sections.count + (columnHeader ? items.count : 0) + (rowHeader ? sections.count : 0) + (columnHeader && rowHeader ? 1 : 0)
                    if columnHeader && rowHeader {
                        let headerIndexPath = IndexPath(index: 0)
                        let res = attributes.filter { isAttribute($0, forIndexPath: headerIndexPath, forSupplementaryViewOfKind: .CornerHeader) }.count == 1
                        expect(res, file: file, line: line).to(beTrue(), description: "Expected layout attributes to contain IndexPath(index: 0) for section header")
                    }
                    for item in items {
                        if columnHeader {
                            let headerIndexPath = IndexPath(index: item)
                            let res = attributes.filter { isAttribute($0, forIndexPath: headerIndexPath, forSupplementaryViewOfKind: .ColumnHeader) }.count == 1
                            expect(res, file: file, line: line).to(beTrue(), description: "Expected layout attributes to contain IndexPath(index: \(item)) for column header")
                        }
                        for section in sections {
                            if rowHeader {
                                let headerIndexPath = IndexPath(index: section)
                                let res = attributes.filter { isAttribute($0, forIndexPath: headerIndexPath, forSupplementaryViewOfKind: .RowHeader) }.count == 1
                                expect(res, file: file, line: line).to(beTrue(), description: "Expected layout attributes to contain IndexPath(index: \(section)) for row header")
                            }
                            let indexPath = IndexPath(item: item, section: section)
                            let res = attributes.filter { $0.indexPath == indexPath && $0.representedElementCategory == .cell }.count == 1
                            expect(res, file: file, line: line).to(beTrue(), description: "Expected layout attributes to contain IndexPath(forItem: \(item), inSection: \(section)) for cell")
                        }
                    }
                }

                context("when rowHeaderWidth != 0") {
                    beforeEach {
                        dataGridView.rowHeaderWidth = 60
                    }

                    it("should return corresponding rows and columns") {
                        let rect = CGRect(
                            x: 0,
                            y: 0,
                            width: dataGridView.rowHeaderWidth + 2 * stubDelegate.columnWidth,
                            height: dataGridView.columnHeaderHeight + 2 * stubDelegate.rowHeight
                        )
                        ensure(items: [0, 1], sections: [0, 1], columnHeader: true, rowHeader: true, inRect: rect)
                    }

                    it("should return row header even if grid view is horizontally scrolled") {
                        let rect = CGRect(
                            x: dataGridView.rowHeaderWidth + 2 * stubDelegate.columnWidth,
                            y: 0,
                            width: 2 * stubDelegate.columnWidth,
                            height: dataGridView.columnHeaderHeight + 2 * stubDelegate.rowHeight
                        )
                        ensure(items: [2,3], sections: [0, 1], columnHeader: true, rowHeader: true, inRect: rect)
                    }
                }

                it("should return corresponding rows and columns") {
                    let rect = CGRect(
                        x: 0,
                        y: 0,
                        width: 2 * stubDelegate.columnWidth,
                        height: dataGridView.columnHeaderHeight + 2 * stubDelegate.rowHeight
                    )
                    ensure(items: [0, 1], sections: [0, 1], columnHeader: true, rowHeader: false, inRect: rect)
                }

                it("should not return off-screen rows/columns") {
                    let rect = CGRect(
                        x: stubDelegate.columnWidth,
                        y: stubDelegate.rowHeight,
                        width: 2 * stubDelegate.columnWidth,
                        height: dataGridView.columnHeaderHeight + 2 * stubDelegate.rowHeight
                    )
                    ensure(items: [1, 2], sections: [1, 2], columnHeader: true, rowHeader: false, inRect: rect)
                }

                it("should return half-on-screen rows&columns") {
                    let rect = CGRect(
                        x: stubDelegate.columnWidth / 2,
                        y: stubDelegate.rowHeight / 2,
                        width: 2 * stubDelegate.columnWidth,
                        height: dataGridView.columnHeaderHeight + 2 * stubDelegate.rowHeight
                    )
                    ensure(items: [0, 1, 2], sections: [0, 1, 2], columnHeader: true, rowHeader: false, inRect: rect)
                }

                it("should return veeery wide rows") {
                    stubDelegate.columnWidth = 300
                    let rect = CGRect(
                        x: 350,
                        y: 0,
                        width: 100,
                        height: dataGridView.columnHeaderHeight + 2 * stubDelegate.rowHeight
                    )

                    ensure(items: [1], sections: [0, 1], columnHeader: true, rowHeader: false, inRect: rect)
                }

                it("should return veeeeery tall columns") {
                    stubDelegate.rowHeight = 300
                    let rect = CGRect(
                        x: 0,
                        y: 325,
                        width: 2 * stubDelegate.columnWidth,
                        height: 100
                    )
                    ensure(items: [0, 1], sections: [1], columnHeader: true, rowHeader: false, inRect: rect)
                }

                it("should return floating columns") {
                    stubDelegate.floatingColumns = [0, 2]
                    let rect = CGRect(
                        x: 4*stubDelegate.columnWidth,
                        y: 0,
                        width: 3*stubDelegate.columnWidth,
                        height: stubDelegate.rowHeight + dataGridView.columnHeaderHeight
                    )
                    ensure(items: [0, 2, 4, 5, 6], sections: [0], columnHeader: true, rowHeader: false, inRect: rect)
                }
            }
        }

        describe("cells sizes") {
            describe("heightForRow") {
                it("should return delegate's dataGrid:heightForRow if present") {
                    expect(sut.heightForRow(0)) == stubDelegate.rowHeight
                }

                it("should return dataGridView.rowHeight if delegate missing/not implements method") {
                    dataGridView.delegate = nil
                    dataGridView.rowHeight = 120
                    expect(sut.heightForRow(0)) == 120
                }
            }

            describe("widthForColumn:") {
                it("should return delegate's dataGrid:widthForColumn:inSection: if present") {
                    expect(sut.widthForColumn(0)) == stubDelegate.columnWidth
                }
                it("should return equal widths for columns if delegate missing/not implements method") {
                    dataGridView.dataSource = stubDataSource
                    dataGridView.delegate = nil
                    stubDataSource.numberOfColumns = 5

                    expect(sut.widthForColumn(0)) == 55
                    expect(sut.widthForColumn(1)) == 55
                    expect(sut.widthForColumn(2)) == 56
                    expect(sut.widthForColumn(3)) == 55
                    expect(sut.widthForColumn(4)) == 55

                    stubDataSource.numberOfColumns = 7

                    expect(sut.widthForColumn(0)) == 39
                    expect(sut.widthForColumn(1)) == 40
                    expect(sut.widthForColumn(2)) == 39
                    expect(sut.widthForColumn(3)) == 40
                    expect(sut.widthForColumn(4)) == 39
                    expect(sut.widthForColumn(5)) == 40
                    expect(sut.widthForColumn(6)) == 39

                }
                it("should return zero if delegate and dataSource are not set") {
                    dataGridView.dataSource = nil
                    dataGridView.delegate = nil
                    expect(sut.widthForColumn(0)) == 0
                }
            }

            describe("heightForHeaderInSection") {
                it("should return dataGridView.columnHeaderHeight if delegate missing/not implements method") {
                    dataGridView.delegate = nil
                    dataGridView.columnHeaderHeight = 120
                    expect(sut.heightForSectionHeader()) == 120
                }
            }
        }

        describe("shouldInvalidateLayoutForBoundsChange") {
            it("should return always true") {
                let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
                let res = sut.shouldInvalidateLayout(forBoundsChange: rect)
                expect(res).to(beTrue())
            }
        }

        describe("collectionViewContentSize") {
            it("should return sum width for all columns and sum height for all rows and header") {
                let size = sut.collectionViewContentSize
                expect(size.width) == Array(0..<dataGridView.numberOfColumns()).reduce(CGFloat(sut.widthForRowHeader())) { $0 + sut.widthForColumn($1) }
                expect(size.height) == Array(0..<dataGridView.numberOfRows()).reduce(sut.heightForSectionHeader()) { $0 + sut.heightForRow($1) }
            }
        }
    }
}
