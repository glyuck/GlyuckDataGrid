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
        let dataGridView = DataGridView()
        let stubDataSource = StubDataGridViewDataSource()
        var dataSourceWrapper: DataGridDataSourceWrapper!

        beforeEach {
            dataSourceWrapper = DataGridDataSourceWrapper(dataGridDataSource: stubDataSource)
        }

        describe("numberOfSectionsInCollectionView:") {
            it("should return 0 if there is no dataSource") {
                dataSourceWrapper.dataGridDataSource = nil
                expect(dataSourceWrapper.numberOfSectionsInCollectionView(dataGridView)) == 0
            }
            it("should return dataSource.numberOfRowsInDataGridView + 1") {
                stubDataSource.numberOfRows = 10
                expect(dataSourceWrapper.numberOfSectionsInCollectionView(dataGridView)) == 11
            }
        }

        describe("collectionView:numberOfItemsInSection:") {
            it("should return 0 if there is no dataSource") {
                dataSourceWrapper.dataGridDataSource = nil
                expect(dataSourceWrapper.collectionView(dataGridView, numberOfItemsInSection: 0)) == 0
            }
            it("should return dataSource.numberOfColumnsInDataGrid + 1") {
                stubDataSource.numberOfColumns = 10
                expect(dataSourceWrapper.collectionView(dataGridView, numberOfItemsInSection: 0)) == 10
            }
        }

        describe("collectionView:cellForItemAtIndexPath:") {
            context("for headers") {
                it("should return DataGridViewHeaderCell for 0 section") {
                    let cell = dataSourceWrapper.collectionView(dataGridView, cellForItemAtIndexPath: NSIndexPath(forItem: 0, inSection: 0))
                    expect(cell).to(beAKindOf(DataGridViewHeaderCell.self))
                }

                it("should configure first header cell with corresponding text") {
                    let cell = dataSourceWrapper.collectionView(dataGridView, cellForItemAtIndexPath: NSIndexPath(forItem: 0, inSection: 0)) as! DataGridViewHeaderCell
                    expect(cell.textLabel.text) == "Title for column 0"
                }

                it("should configure second header cell with corresponding text") {
                    let cell = dataSourceWrapper.collectionView(dataGridView, cellForItemAtIndexPath: NSIndexPath(forItem: 1, inSection: 0)) as! DataGridViewHeaderCell
                    expect(cell.textLabel.text) == "Title for column 1"
                }
            }

            context("for content cells") {
                it("should return DataGridViewContentCell for 1 section") {
                    let cell = dataSourceWrapper.collectionView(dataGridView, cellForItemAtIndexPath: NSIndexPath(forItem: 0, inSection: 1))
                    expect(cell).to(beAKindOf(DataGridViewContentCell.self))
                }

                it("should configure cell 0,0 with corresponding text") {
                    let cell = dataSourceWrapper.collectionView(dataGridView, cellForItemAtIndexPath: NSIndexPath(forItem: 0, inSection: 1)) as! DataGridViewContentCell
                    expect(cell.textLabel.text) == "Text for cell 0x0"
                }

                it("should configure cell 1,2 with corresponding text") {
                    let cell = dataSourceWrapper.collectionView(dataGridView, cellForItemAtIndexPath: NSIndexPath(forItem: 1, inSection: 3)) as! DataGridViewContentCell
                    expect(cell.textLabel.text) == "Text for cell 1x2"
                }
            }
        }
    }
}
