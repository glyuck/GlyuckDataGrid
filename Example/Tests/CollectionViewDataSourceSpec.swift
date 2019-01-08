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
                expect(sut.numberOfSections(in: dataGridView.collectionView)) == 0
            }
            it("should return dataSource.numberOfRowsInDataGridView") {
                stubDataSource.numberOfRows = 10
                expect(sut.numberOfSections(in: dataGridView.collectionView)) == 10
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
            context("for column headers") {
                func headerCell(forColumn column: Int) -> DataGridViewColumnHeaderCell? {
                    let indexPath = IndexPath(index: column)
                    let view = sut.collectionView(dataGridView.collectionView, viewForSupplementaryElementOfKind: DataGridView.SupplementaryViewKind.ColumnHeader.rawValue, at: indexPath)
                    return view as? DataGridViewColumnHeaderCell
                }

                context("when dataGridView:viewForHeaderForColumn: is implemented") {
                    var stubDataSourceCustomCell: StubDataGridViewDataSourceCustomCell!
                    beforeEach {
                        stubDataSourceCustomCell = StubDataGridViewDataSourceCustomCell()
                        dataGridView.dataSource = stubDataSourceCustomCell
                        dataGridView.reloadData()
                        dataGridView.layoutIfNeeded()
                    }

                    it("should return view created by delegate") {
                        // given
                        let expectedView = dataGridView.dequeueReusableHeaderViewWithReuseIdentifier(DataGridView.ReuseIdentifiers.defaultColumnHeader, forColumn: 1)
                        stubDataSourceCustomCell.viewForColumnHeaderBlock = { (arg) in
                            
                            let (dataGridView, column) = arg
                            expectedView.tag = column
                            return expectedView
                        }
                        // when
                        let view = headerCell(forColumn: 1)
                        // then
                        expect(view) == expectedView
                        expect(view?.tag) == 1
                    }
                }

                it("should return DataGridViewColumnHeaderCell for 0 section") {
                    let cell = headerCell(forColumn: 0)
                    expect(cell).to(beAKindOf(DataGridViewColumnHeaderCell.self))
                }

                it("should configure first header cell with corresponding text") {
                    let cell = headerCell(forColumn: 0)
                    expect(cell?.title) == "Title for column 0"
                }

                it("should configure second header cell with corresponding text") {
                    let cell = headerCell(forColumn: 1)
                    expect(cell?.title) == "Title for column 1"
                }
            }

            context("for row headers") {
                func headerCell(forRow row: Int) -> DataGridViewRowHeaderCell? {
                    let indexPath = IndexPath(item: 0, section: row)
                    let view = sut.collectionView(dataGridView.collectionView, viewForSupplementaryElementOfKind: DataGridView.SupplementaryViewKind.RowHeader.rawValue, at: indexPath)
                    return view as? DataGridViewRowHeaderCell
                }

                context("when dataGridView:viewForHeaderForRow: is implemented") {
                    var stubDataSourceCustomCell: StubDataGridViewDataSourceCustomCell!
                    beforeEach {
                        stubDataSourceCustomCell = StubDataGridViewDataSourceCustomCell()
                        dataGridView.dataSource = stubDataSourceCustomCell
                        dataGridView.reloadData()
                        dataGridView.layoutIfNeeded()
                    }

                    it("should return view created by delegate") {
                        // given
                        let expectedView = dataGridView.dequeueReusableHeaderViewWithReuseIdentifier(DataGridView.ReuseIdentifiers.defaultRowHeader, forRow: 1)
                        stubDataSourceCustomCell.viewForRowHeaderBlock = { (arg) in
                            
                            let (dataGridView, row) = arg
                            expectedView.tag = row
                            return expectedView
                        }
                        // when
                        let view = headerCell(forRow: 1)
                        // then
                        expect(view) == expectedView
                        expect(view?.tag) == 1
                    }
                }

                it("should return DataGridViewColumnHeaderCell for 0 section") {
                    let cell = headerCell(forRow: 0)
                    expect(cell).to(beAKindOf(DataGridViewRowHeaderCell.self))
                }

                it("should configure first header cell with corresponding text") {
                    let cell = headerCell(forRow: 0)
                    expect(cell?.title) == "Title for row 0"
                }

                it("should configure second header cell with corresponding text") {
                    let cell = headerCell(forRow: 1)
                    expect(cell?.title) == "Title for row 1"
                }
            }
            context("for corner headers") {
                func cornerHeaderCell() -> DataGridViewCornerHeaderCell? {
                    let indexPath = IndexPath(item: 0, section: 0)
                    let view = sut.collectionView(dataGridView.collectionView, viewForSupplementaryElementOfKind: DataGridView.SupplementaryViewKind.CornerHeader.rawValue, at: indexPath)
                    return view as? DataGridViewCornerHeaderCell
                }

                it("should return DataGridViewCornerHeaderCell") {
                    let cell = cornerHeaderCell()
                    expect(cell).to(beAKindOf(DataGridViewCornerHeaderCell.self))
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
                    let expectedCell = dataGridView.dequeueReusableCellWithReuseIdentifier(DataGridView.ReuseIdentifiers.defaultCell, forIndexPath: IndexPath(item: 0, section: 0))
                    stubDataSourceCustomCell.cellForItemBlock = { (arg) in
                        
                        let (dataGridView, indexPath) = arg
                        expectedCell.tag = indexPath.dataGridColumn * 100 + indexPath.dataGridRow
                        return expectedCell
                    }
                    // when
                    let cell = sut.collectionView(dataGridView.collectionView, cellForItemAt: IndexPath(item: 2, section: 1))
                    // then
                    expect(cell) == expectedCell
                    expect(cell.tag) == 201
                }
            }

            context("when dataGridView:cellForItemAtColumn:row: is not implemented") {
                it("should return DataGridViewContentCell for 1 section") {
                    let cell = sut.collectionView(dataGridView.collectionView, cellForItemAt: IndexPath(item: 0, section: 1))
                    expect(cell).to(beAKindOf(DataGridViewContentCell.self))
                }

                it("should configure cell 0,0 with corresponding text") {
                    let cell = sut.collectionView(dataGridView.collectionView, cellForItemAt: IndexPath(item: 0, section: 0)) as! DataGridViewContentCell
                    expect(cell.textLabel.text) == "Text for cell 0x0"
                }

                it("should configure cell 1,2 with corresponding text") {
                    let cell = sut.collectionView(dataGridView.collectionView, cellForItemAt: IndexPath(item: 1, section: 2)) as! DataGridViewContentCell
                    expect(cell.textLabel.text) == "Text for cell 1x2"
                }
            }
        }
    }
}
