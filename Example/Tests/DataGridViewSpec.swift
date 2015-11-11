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
        var dataGridView: DataGridView!
        var stubDataSource: StubDataGridViewDataSource!

        beforeEach {
            stubDataSource = StubDataGridViewDataSource()
            dataGridView = DataGridView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
            dataGridView.dataSource = stubDataSource
            dataGridView.collectionView.layoutIfNeeded()
        }

        describe("collectionView") {
            it("should not be nil") {
                expect(dataGridView.collectionView).to(beTruthy())
            }

            it("should be subview of dataGridView") {
                expect(dataGridView.collectionView.superview) === dataGridView
            }

            it("should resize along with dataGridView") {
                dataGridView.collectionView.layoutIfNeeded()  // Ensure text label is initialized when tests are started

                dataGridView.frame = CGRectMake(0, 0, dataGridView.frame.width * 2, dataGridView.frame.height / 2)
                dataGridView.layoutIfNeeded()
                expect(dataGridView.collectionView.frame) == dataGridView.frame
            }

            it("should register supplementary view with reuseIdentifier DataGridViewHeaderCell") {
                let cell: AnyObject = dataGridView.collectionView.dequeueReusableSupplementaryViewOfKind(DataGridView.SupplementaryViewKind.Header.rawValue, withReuseIdentifier: "DataGridViewHeaderCell", forIndexPath: NSIndexPath(forItem: 0, inSection: 0))
                expect(cell).to(beTruthy())
            }

            it("should register cell with reuseIdentifier DataGridViewContentCell") {
                let cell: AnyObject = dataGridView.collectionView.dequeueReusableCellWithReuseIdentifier("DataGridViewContentCell", forIndexPath: NSIndexPath(forItem: 0, inSection: 0))
                expect(cell).to(beTruthy())
            }

            it("should have transparent background") {
                expect(dataGridView.collectionView.backgroundColor) == UIColor.clearColor()
            }

            describe("layout") {
                it("should be instance of DataGridViewLayout") {
                    expect(dataGridView.collectionView.collectionViewLayout).to(beAKindOf(DataGridViewLayout.self))
                }
                it("should have dataGridView set") {
                    expect(dataGridView.layout.dataGridView) === dataGridView
                }
                it("should have collectionView and dataGridView properties set") {
                    let layout = dataGridView.collectionView.collectionViewLayout as? DataGridViewLayout
                    expect(layout).to(beTruthy())
                    if let layout = layout {
                        expect(layout.dataGridView) === dataGridView
                        expect(layout.collectionView) === dataGridView.collectionView
                    }
                }
            }
        }

        describe("dataGridDataSource") {
            it("should assign dataSource to DataGridDataSourceWrapper") {
                let dataSource = StubDataGridViewDataSource()
                dataGridView.dataSource = dataSource
                expect(dataGridView.dataSource).to(beTruthy())
                if let dataSourceWrapper = dataGridView.dataSourceWrapper {
                    expect(dataSourceWrapper.dataGridView) === dataGridView
                    expect(dataSourceWrapper.dataGridDataSource) === dataSource
                }
            }
        }

        describe("dataGridDelegate") {
            it("should assign delegate to DataGridDelegateWrapper") {
                let delegate = StubDataGridViewDelegate()
                dataGridView.delegate = delegate
                expect(dataGridView.delegate).to(beTruthy())
                if let delegateWrapper = dataGridView.delegateWrapper {
                    expect(delegateWrapper.dataGridView) === dataGridView
                    expect(delegateWrapper.dataGridDelegate) === delegate
                }
            }
        }

        describe("numberOfColumns") {
            it("should return value provided by dataSource") {
                stubDataSource.numberOfColumns = 7
                dataGridView.dataSource = stubDataSource
                expect(dataGridView.numberOfColumns()) == stubDataSource.numberOfColumns
            }
            it("should return 0 if dataSource is nil") {
                dataGridView.dataSource = nil
                expect(dataGridView.numberOfColumns()) == 0
            }
        }

        describe("numberOfRows") {
            it("should return value provided by dataSource") {
                stubDataSource.numberOfRows = 7
                dataGridView.dataSource = stubDataSource
                expect(dataGridView.numberOfRows()) == stubDataSource.numberOfRows
            }
            it("should return 0 if dataSource is nil") {
                dataGridView.dataSource = nil
                expect(dataGridView.numberOfRows()) == 0
            }
        }

        describe("selectRow:animated:") {
            it("should select all items in corresponding section") {
                let row = 1
                dataGridView.selectRow(row, animated: false)

                expect(dataGridView.collectionView.indexPathsForSelectedItems()?.count) == dataGridView.numberOfColumns()
                for i in 0..<dataGridView.numberOfColumns() {
                    let indexPath = NSIndexPath(forItem: i, inSection: row)
                    expect(dataGridView.collectionView.indexPathsForSelectedItems()).to(contain(indexPath))
                }
            }
            it("should deselect previously selected row") {
                let row = 1
                dataGridView.selectRow(0, animated: false)
                dataGridView.selectRow(row, animated: false)

                expect(dataGridView.collectionView.indexPathsForSelectedItems()?.count) == dataGridView.numberOfColumns()
                for i in 0..<dataGridView.numberOfColumns() {
                    let indexPath = NSIndexPath(forItem: i, inSection: row)
                    expect(dataGridView.collectionView.indexPathsForSelectedItems()).to(contain(indexPath))
                }
            }
        }

        describe("deselectRow:animated:") {
            it("should deselect all items in corresponding section") {
                let row = 1
                dataGridView.selectRow(row, animated: false)
                dataGridView.deselectRow(row, animated: false)

                expect(dataGridView.collectionView.indexPathsForSelectedItems()?.count) == 0
            }
        }
    }
}
