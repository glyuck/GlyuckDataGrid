//
//  DataGridViewSpec.swift
//
//  Created by Vladimir Lyukov on 30/07/15.
//

import Quick
import Nimble
import GlyuckDataGrid


class DataGridViewSpec: QuickSpec {
    override func spec() {
        var sut: DataGridView!
        var stubDataSource: StubDataGridViewDataSource!

        beforeEach {
            stubDataSource = StubDataGridViewDataSource()
            sut = DataGridView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
            sut.dataSource = stubDataSource
            sut.collectionView.layoutIfNeeded()
        }

        describe("Registering/dequeuing cells") {
            context("zebra-striped tables") {
                it("should return transparent cells when row1BackgroundColor and row2BackgroundColor are nil") {
                    let cell1 = sut.dequeueReusableCellWithReuseIdentifier(DataGridView.ReuseIdentifiers.defaultCell, forIndexPath: IndexPath(forColumn: 1, row: 0))
                    let cell2 = sut.dequeueReusableCellWithReuseIdentifier(DataGridView.ReuseIdentifiers.defaultCell, forIndexPath: IndexPath(forColumn: 1, row: 1))
                    expect(cell1.backgroundColor).to(beNil())
                    expect(cell2.backgroundColor).to(beNil())
                }

                it("should return row1BackgroundColor for odd rows and row2BackgroundColor for even rows") {
                    sut.row1BackgroundColor = UIColor.red
                    sut.row2BackgroundColor = UIColor.green
                    let cell1 = sut.dequeueReusableCellWithReuseIdentifier(DataGridView.ReuseIdentifiers.defaultCell, forIndexPath: IndexPath(forColumn: 1, row: 0))
                    let cell2 = sut.dequeueReusableCellWithReuseIdentifier(DataGridView.ReuseIdentifiers.defaultCell, forIndexPath: IndexPath(forColumn: 1, row: 1))
                    expect(cell1.backgroundColor) == sut.row1BackgroundColor
                    expect(cell2.backgroundColor) == sut.row2BackgroundColor
                }
            }

            it("should register and dequeue cells") {
                sut.registerClass(DataGridViewContentCell.self, forCellWithReuseIdentifier: "MyIdentifier")

                let cell = sut.dequeueReusableCellWithReuseIdentifier("MyIdentifier", forIndexPath: IndexPath(forColumn: 0, row: 0))

                expect(cell).notTo(beNil())
            }

            it("should register and dequeue column headers") {
                sut.registerClass(DataGridViewColumnHeaderCell.self, forHeaderOfKind: .ColumnHeader, withReuseIdentifier: "MyIdentifier")

                let cell = sut.dequeueReusableHeaderViewWithReuseIdentifier("MyIdentifier", forColumn: 1)

                expect(cell).notTo(beNil())
                expect(cell.dataGridView) == sut
                expect(cell.indexPath) == IndexPath(index: 1)
            }

            it("should register and dequeue row headers") {
                sut.registerClass(DataGridViewRowHeaderCell.self, forHeaderOfKind: .RowHeader, withReuseIdentifier: "MyIdentifier")

                let cell = sut.dequeueReusableHeaderViewWithReuseIdentifier("MyIdentifier", forRow: 1)

                expect(cell).notTo(beNil())
                expect(cell.dataGridView) == sut
                expect(cell.indexPath) == IndexPath(index: 1)
            }

            it("should register and dequeue corner headers") {
                sut.registerClass(DataGridViewCornerHeaderCell.self, forHeaderOfKind: .CornerHeader, withReuseIdentifier: "MyIdentifier")

                let cell = sut.dequeueReusableCornerHeaderViewWithReuseIdentifier("MyIdentifier")

                expect(cell).notTo(beNil())
                expect(cell.dataGridView) == sut
                expect(cell.indexPath) == IndexPath(index: 0)
            }
        }

        describe("collectionView") {
            it("should not be nil") {
                expect(sut.collectionView).notTo(beNil())
            }

            it("should be subview of dataGridView") {
                expect(sut.collectionView.superview) === sut
            }

            it("should resize along with dataGridView") {
                sut.collectionView.layoutIfNeeded()  // Ensure text label is initialized when tests are started

                sut.frame = CGRect(x: 0, y: 0, width: sut.frame.width * 2, height: sut.frame.height / 2)
                sut.layoutIfNeeded()
                expect(sut.collectionView.frame) == sut.frame
            }

            it("should register DataGridViewContentCell as default cell") {
                let cell = sut.dequeueReusableCellWithReuseIdentifier(DataGridView.ReuseIdentifiers.defaultCell, forIndexPath: IndexPath(forColumn: 0, row: 0)) as? DataGridViewContentCell
                expect(cell).notTo(beNil())
            }

            it("should register DataGridViewColumnHeaderCell as default column header") {
                let header = sut.dequeueReusableHeaderViewWithReuseIdentifier(DataGridView.ReuseIdentifiers.defaultColumnHeader, forColumn: 0)
                expect(header).notTo(beNil())
            }

            it("should set isSorted and iSortedAsc for column headers") {
                let header1 = sut.dequeueReusableHeaderViewWithReuseIdentifier(DataGridView.ReuseIdentifiers.defaultColumnHeader, forColumn: 0)
                expect(header1.isSorted).to(beFalse())

                sut.setSortColumn(0, ascending: false)

                let header2 = sut.dequeueReusableHeaderViewWithReuseIdentifier(DataGridView.ReuseIdentifiers.defaultColumnHeader, forColumn: 0)
                expect(header2.isSorted).to(beTrue())
                expect(header2.isSortedAsc).to(beFalse())
            }

            it("should register DataGridViewRowHeaderCell as default row header") {
                let header = sut.dequeueReusableHeaderViewWithReuseIdentifier(DataGridView.ReuseIdentifiers.defaultRowHeader, forRow: 0)
                expect(header).notTo(beNil())
            }

            it("should register DataGridViewCornerHeaderCell as default row header") {
                let header = sut.dequeueReusableCornerHeaderViewWithReuseIdentifier(DataGridView.ReuseIdentifiers.defaultCornerHeader)
                expect(header).notTo(beNil())
            }

            it("should have CollectionViewDataSource as dataSource") {
                let dataSource = sut.collectionView.dataSource as? CollectionViewDataSource
                expect(dataSource).notTo(beNil())
                expect(dataSource) == sut.collectionViewDataSource
                expect(dataSource?.dataGridView) == sut
            }

            it("should have CollectionViewDelegate as delegate") {
                let delegate = sut.collectionView.delegate as? CollectionViewDelegate
                expect(delegate).notTo(beNil())
                expect(delegate) == sut.collectionViewDelegate
                expect(delegate?.dataGridView) == sut
            }

            it("should have transparent background") {
                expect(sut.collectionView.backgroundColor) == UIColor.clear
            }

            describe("layout") {
                it("should be instance of DataGridViewLayout") {
                    expect(sut.collectionView.collectionViewLayout).to(beAKindOf(DataGridViewLayout.self))
                }
                it("should have dataGridView set") {
                    let layout = sut.collectionView.collectionViewLayout as? DataGridViewLayout
                    expect(layout?.dataGridView) === sut
                }
                it("should have collectionView and dataGridView properties set") {
                    let layout = sut.collectionView.collectionViewLayout as? DataGridViewLayout
                    expect(layout).notTo(beNil())
                    if let layout = layout {
                        expect(layout.dataGridView) === sut
                        expect(layout.collectionView) === sut.collectionView
                    }
                }
            }
        }

        describe("numberOfColumns") {
            it("should return value provided by dataSource") {
                stubDataSource.numberOfColumns = 7
                sut.dataSource = stubDataSource
                expect(sut.numberOfColumns()) == stubDataSource.numberOfColumns
            }
            it("should return 0 if dataSource is nil") {
                sut.dataSource = nil
                expect(sut.numberOfColumns()) == 0
            }
        }

        describe("numberOfRows") {
            it("should return value provided by dataSource") {
                stubDataSource.numberOfRows = 7
                sut.dataSource = stubDataSource
                expect(sut.numberOfRows()) == stubDataSource.numberOfRows
            }
            it("should return 0 if dataSource is nil") {
                sut.dataSource = nil
                expect(sut.numberOfRows()) == 0
            }
        }

        describe("selectRow:animated:") {
            it("should select all items in corresponding section") {
                let row = 1
                sut.selectRow(row, animated: false)

                expect(sut.collectionView.indexPathsForSelectedItems?.count) == sut.numberOfColumns()
                for i in 0..<sut.numberOfColumns() {
                    let indexPath = IndexPath(item: i, section: row)
                    expect(sut.collectionView.indexPathsForSelectedItems).to(contain(indexPath))
                }
            }
            it("should deselect previously selected row") {
                let row = 1
                sut.selectRow(0, animated: false)
                sut.selectRow(row, animated: false)

                expect(sut.collectionView.indexPathsForSelectedItems?.count) == sut.numberOfColumns()
                for i in 0..<sut.numberOfColumns() {
                    let indexPath = IndexPath(item: i, section: row)
                    expect(sut.collectionView.indexPathsForSelectedItems).to(contain(indexPath))
                }
            }
        }

        describe("deselectRow:animated:") {
            it("should deselect all items in corresponding section") {
                let row = 1
                sut.selectRow(row, animated: false)
                sut.deselectRow(row, animated: false)

                expect(sut.collectionView.indexPathsForSelectedItems?.count) == 0
            }
        }
    }
}
