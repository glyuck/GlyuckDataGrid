//
//  DataGridDataSourceWrapperSpec.swift
//
//  Created by Vladimir Lyukov on 03/08/15.
//

import Quick
import Nimble
import GlyuckDataGrid


class DataGridDataSourceWrapperSpec: QuickSpec {
    override func spec() {
        var dataGridView: DataGridView!
        var stubDataSource: StubDataGridViewDataSource!
        var dataSourceWrapper: DataGridDataSourceWrapper!

        beforeEach {
            dataGridView = DataGridView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
            stubDataSource = StubDataGridViewDataSource()
            dataGridView.dataSource = stubDataSource
            dataSourceWrapper = dataGridView.dataSourceWrapper
        }

        describe("numberOfSectionsInCollectionView:") {
            it("should return 0 if there is no dataSource") {
                dataSourceWrapper.dataGridDataSource = nil
                expect(dataSourceWrapper.numberOfSectionsInCollectionView(dataGridView.collectionView)) == 0
            }
            it("should return dataSource.numberOfRowsInDataGridView + 1") {
                stubDataSource.numberOfRows = 10
                expect(dataSourceWrapper.numberOfSectionsInCollectionView(dataGridView.collectionView)) == 11
            }
        }

        describe("collectionView:numberOfItemsInSection:") {
            it("should return 0 if there is no dataSource") {
                dataSourceWrapper.dataGridDataSource = nil
                expect(dataSourceWrapper.collectionView(dataGridView.collectionView, numberOfItemsInSection: 0)) == 0
            }
            it("should return dataSource.numberOfColumnsInDataGrid + 1") {
                stubDataSource.numberOfColumns = 10
                expect(dataSourceWrapper.collectionView(dataGridView.collectionView, numberOfItemsInSection: 0)) == 10
            }
        }

        describe("collectionView:cellForItemAtIndexPath:") {
            context("for headers") {
                it("should return DataGridViewHeaderCell for 0 section") {
                    let cell = dataSourceWrapper.collectionView(dataGridView.collectionView, cellForItemAtIndexPath: NSIndexPath(forItem: 0, inSection: 0))
                    expect(cell).to(beAKindOf(DataGridViewHeaderCell.self))
                }

                it("should configure first header cell with corresponding text") {
                    let cell = dataSourceWrapper.collectionView(dataGridView.collectionView, cellForItemAtIndexPath: NSIndexPath(forItem: 0, inSection: 0)) as! DataGridViewHeaderCell
                    expect(cell.textLabel.text) == "Title for column 0"
                }

                it("should configure second header cell with corresponding text") {
                    let cell = dataSourceWrapper.collectionView(dataGridView.collectionView, cellForItemAtIndexPath: NSIndexPath(forItem: 1, inSection: 0)) as! DataGridViewHeaderCell
                    expect(cell.textLabel.text) == "Title for column 1"
                }

                it("should call dataSource.dataGridView:configureHeaderCell:atColumn:") {
                    stubDataSource.configureHeaderCellBlock = { (cell, column) in cell.tag = 100 + column }

                    let cell = dataSourceWrapper.collectionView(dataGridView.collectionView, cellForItemAtIndexPath: NSIndexPath(forItem: 1, inSection: 0)) as! DataGridViewHeaderCell
                    expect(cell.tag) == 101
                }

                it("should add sorting symbol when dataGridView is sorted by this column ascending") {
                    dataGridView.setSortColumn(0, ascending: true)

                    let cell = dataSourceWrapper.collectionView(dataGridView.collectionView, cellForItemAtIndexPath: NSIndexPath(forItem: 0, inSection: 0)) as! DataGridViewHeaderCell
                    expect(cell.textLabel.text) == "Title for column 0 ↑"
                }

                it("should add sorting symbol when dataGridView is sorted by this column descending") {
                    dataGridView.setSortColumn(0, ascending: false)

                    let cell = dataSourceWrapper.collectionView(dataGridView.collectionView, cellForItemAtIndexPath: NSIndexPath(forItem: 0, inSection: 0)) as! DataGridViewHeaderCell
                    expect(cell.textLabel.text) == "Title for column 0 ↓"
                }
            }

            context("for content cells") {
                it("should return DataGridViewContentCell for 1 section") {
                    let cell = dataSourceWrapper.collectionView(dataGridView.collectionView, cellForItemAtIndexPath: NSIndexPath(forItem: 0, inSection: 1))
                    expect(cell).to(beAKindOf(DataGridViewContentCell.self))
                }

                it("should configure cell 0,0 with corresponding text") {
                    let cell = dataSourceWrapper.collectionView(dataGridView.collectionView, cellForItemAtIndexPath: NSIndexPath(forItem: 0, inSection: 1)) as! DataGridViewContentCell
                    expect(cell.textLabel.text) == "Text for cell 0x0"
                }

                it("should configure cell 1,2 with corresponding text") {
                    let cell = dataSourceWrapper.collectionView(dataGridView.collectionView, cellForItemAtIndexPath: NSIndexPath(forItem: 1, inSection: 3)) as! DataGridViewContentCell
                    expect(cell.textLabel.text) == "Text for cell 1x2"
                }

                it("should call dataSource.dataGridView:configureContentCell:atColumn:") {
                    stubDataSource.configureContentCellBlock = { (cell, column, row) in cell.tag = column * 100 + row }

                    let cell = dataSourceWrapper.collectionView(dataGridView.collectionView, cellForItemAtIndexPath: NSIndexPath(forItem: 2, inSection: 2)) as! DataGridViewContentCell
                    expect(cell.tag) == 201
                }

                context("zebra-striped tables") {
                    it("should return transparent cells when row1BackgroundColor and row2BackgroundColor are nil") {
                        let cell1 = dataSourceWrapper.collectionView(dataGridView.collectionView, cellForItemAtIndexPath: NSIndexPath(forItem: 1, inSection: 1)) as! DataGridViewContentCell
                        let cell2 = dataSourceWrapper.collectionView(dataGridView.collectionView, cellForItemAtIndexPath: NSIndexPath(forItem: 1, inSection: 2)) as! DataGridViewContentCell
                        expect(cell1.backgroundColor).to(beNil())
                        expect(cell2.backgroundColor).to(beNil())
                    }

                    it("should return row1BackgroundColor for odd rows and row2BackgroundColor for even rows") {
                        dataGridView.row1BackgroundColor = UIColor.redColor()
                        dataGridView.row2BackgroundColor = UIColor.greenColor()
                        let cell1 = dataSourceWrapper.collectionView(dataGridView.collectionView, cellForItemAtIndexPath: NSIndexPath(forItem: 1, inSection: 1)) as! DataGridViewContentCell
                        let cell2 = dataSourceWrapper.collectionView(dataGridView.collectionView, cellForItemAtIndexPath: NSIndexPath(forItem: 1, inSection: 2)) as! DataGridViewContentCell
                        expect(cell1.backgroundColor) == dataGridView.row1BackgroundColor
                        expect(cell2.backgroundColor) == dataGridView.row2BackgroundColor
                    }
                }
            }
        }
    }
}
