//
//  CollectionViewDataSourceSpec.swift
//
//  Created by Vladimir Lyukov on 03/08/15.
//

import UIKit
import Quick
import Nimble
import GlyuckDataGrid


class CollectionViewDataSourceSpec: QuickSpec {
    override func spec() {
        var dataGridView: DataGridView!
        var stubDataSource: StubDataGridViewDataSource!
        var sut: CollectionViewDataSource!

        beforeEach {
            dataGridView = DataGridView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
            stubDataSource = StubDataGridViewDataSource()
            dataGridView.dataSource = stubDataSource
            sut = dataGridView.collectionViewDataSource

            dataGridView.collectionView.layoutIfNeeded()
        }

        describe("numberOfSectionsInCollectionView:") {
            it("should return 0 if there is no collectionView.dataSource") {
                dataGridView.dataSource = nil
                expect(sut.numberOfSectionsInCollectionView(dataGridView.collectionView)) == 0
            }
            it("should return dataSource.numberOfRowsInDataGridView") {
                stubDataSource.numberOfRows = 10
                expect(sut.numberOfSectionsInCollectionView(dataGridView.collectionView)) == 10
            }
        }

        describe("collectionView:numberOfItemsInSection:") {
            it("should return 0 if there is no dataSource") {
                dataGridView.dataSource = nil
                expect(sut.collectionView(dataGridView.collectionView, numberOfItemsInSection: 0)) == 0
            }
            it("should return dataSource.numberOfColumnsInDataGrid") {
                stubDataSource.numberOfColumns = 10
                expect(sut.collectionView(dataGridView.collectionView, numberOfItemsInSection: 0)) == 10
            }
        }

        describe("collectionView:viewForSupplementaryElementOfKind:atIndexPath:") {
            context("for headers") {
                func headerCellForColumn(column: Int) -> DataGridViewHeaderCell? {
                    let indexPath = NSIndexPath(forItem: column, inSection: 0)
                    let view = sut.collectionView(dataGridView.collectionView, viewForSupplementaryElementOfKind: DataGridView.SupplementaryViewKind.Header.rawValue, atIndexPath: indexPath)
                    return view as? DataGridViewHeaderCell
                }

                it("should return DataGridViewHeaderCell for 0 section") {
                    let cell = headerCellForColumn(0)
                    expect(cell).to(beAKindOf(DataGridViewHeaderCell.self))
                }

                it("should configure first header cell with corresponding text") {
                    let cell = headerCellForColumn(0)
                    expect(cell?.textLabel.text) == "Title for column 0"
                }

                it("should return nil when kind != header") {
                    let cell = headerCellForColumn(1)
                    expect(cell?.textLabel.text) == "Title for column 1"
                }

                it("should call dataSource.dataGridView:configureHeaderCell:atColumn:") {
                    stubDataSource.configureHeaderCellBlock = { (cell, column) in cell.tag = 100 + column }

                    let cell = headerCellForColumn(1)
                    expect(cell?.tag) == 101
                }

                it("should add sorting symbol when dataGridView is sorted by this column ascending") {
                    dataGridView.setSortColumn(0, ascending: true)

                    let cell = headerCellForColumn(0)
                    expect(cell?.textLabel.text) == "Title for column 0 ↑"
                }

                it("should add sorting symbol when dataGridView is sorted by this column descending") {
                    dataGridView.setSortColumn(0, ascending: false)

                    let cell = headerCellForColumn(0)
                    expect(cell?.textLabel.text) == "Title for column 0 ↓"
                }

                it("should set cell.isSorted when sorted by this column") {
                    dataGridView.setSortColumn(0, ascending: false)

                    let cell = headerCellForColumn(0)
                    expect(cell?.isSorted).to(beTrue())
                }

                it("should not set cell.isSoretd unless sorted by this column") {
                    dataGridView.setSortColumn(0, ascending: false)

                    let cell = headerCellForColumn(1)
                    expect(cell?.isSorted).to(beFalse())
                }
            }
        }

        describe("collectionView:cellForItemAtIndexPath:") {
            context("when dataGridView:cellForItemAtColumn:row: is implemented") {
                var stubDataSourceCustomCell: StubDataGridViewDataSourceCustomCell!
                beforeEach {
                    stubDataSourceCustomCell = StubDataGridViewDataSourceCustomCell()
                    dataGridView.dataSource = stubDataSourceCustomCell
                    dataGridView.reloadData()
                    dataGridView.layoutIfNeeded()
                }

                it("should return view created by delegate") {
                    // given
                    let expectedCell = dataGridView.dequeueReusableCellWithReuseIdentifier(DataGridView.ReuseIdentifiers.defaultCell, forIndexPath: NSIndexPath(forItem: 0, inSection: 0))
                    stubDataSourceCustomCell.cellForItemBlock = { dataGridView, indexPath in
                        expectedCell.tag = indexPath.dataGridColumn * 100 + indexPath.dataGridRow
                        return expectedCell
                    }
                    // when
                    let cell = sut.collectionView(dataGridView.collectionView, cellForItemAtIndexPath: NSIndexPath(forItem: 2, inSection: 1))
                    // then
                    expect(cell) == expectedCell
                    expect(cell.tag) == 201
                }
            }

            context("when dataGridView:cellForItemAtColumn:row: is not implemented") {
                it("should return DataGridViewContentCell for 1 section") {
                    let cell = sut.collectionView(dataGridView.collectionView, cellForItemAtIndexPath: NSIndexPath(forItem: 0, inSection: 1))
                    expect(cell).to(beAKindOf(DataGridViewContentCell.self))
                }

                it("should configure cell 0,0 with corresponding text") {
                    let cell = sut.collectionView(dataGridView.collectionView, cellForItemAtIndexPath: NSIndexPath(forItem: 0, inSection: 0)) as! DataGridViewContentCell
                    expect(cell.textLabel.text) == "Text for cell 0x0"
                }

                it("should configure cell 1,2 with corresponding text") {
                    let cell = sut.collectionView(dataGridView.collectionView, cellForItemAtIndexPath: NSIndexPath(forItem: 1, inSection: 2)) as! DataGridViewContentCell
                    expect(cell.textLabel.text) == "Text for cell 1x2"
                }

                it("should call dataSource.dataGridView:configureContentCell:atColumn:") {
                    stubDataSource.configureContentCellBlock = { (cell, indexPath) in cell.tag = indexPath.dataGridColumn * 100 + indexPath.dataGridRow }

                    let cell = sut.collectionView(dataGridView.collectionView, cellForItemAtIndexPath: NSIndexPath(forItem: 2, inSection: 1)) as! DataGridViewContentCell
                    expect(cell.tag) == 201
                }

                context("zebra-striped tables") {
                    it("should return transparent cells when row1BackgroundColor and row2BackgroundColor are nil") {
                        let cell1 = sut.collectionView(dataGridView.collectionView, cellForItemAtIndexPath: NSIndexPath(forItem: 1, inSection: 0)) as! DataGridViewContentCell
                        let cell2 = sut.collectionView(dataGridView.collectionView, cellForItemAtIndexPath: NSIndexPath(forItem: 1, inSection: 1)) as! DataGridViewContentCell
                        expect(cell1.backgroundColor).to(beNil())
                        expect(cell2.backgroundColor).to(beNil())
                    }

                    it("should return row1BackgroundColor for odd rows and row2BackgroundColor for even rows") {
                        dataGridView.row1BackgroundColor = UIColor.redColor()
                        dataGridView.row2BackgroundColor = UIColor.greenColor()
                        let cell1 = sut.collectionView(dataGridView.collectionView, cellForItemAtIndexPath: NSIndexPath(forItem: 1, inSection: 0)) as! DataGridViewContentCell
                        let cell2 = sut.collectionView(dataGridView.collectionView, cellForItemAtIndexPath: NSIndexPath(forItem: 1, inSection: 1)) as! DataGridViewContentCell
                        expect(cell1.backgroundColor) == dataGridView.row1BackgroundColor
                        expect(cell2.backgroundColor) == dataGridView.row2BackgroundColor
                    }
                }
            }
        }
    }
}
