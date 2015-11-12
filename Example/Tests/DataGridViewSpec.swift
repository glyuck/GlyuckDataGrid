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

        describe("collectionView") {
            it("should not be nil") {
                expect(sut.collectionView).to(beTruthy())
            }

            it("should be subview of dataGridView") {
                expect(sut.collectionView.superview) === sut
            }

            it("should resize along with dataGridView") {
                sut.collectionView.layoutIfNeeded()  // Ensure text label is initialized when tests are started

                sut.frame = CGRectMake(0, 0, sut.frame.width * 2, sut.frame.height / 2)
                sut.layoutIfNeeded()
                expect(sut.collectionView.frame) == sut.frame
            }

            it("should register supplementary view with reuseIdentifier DataGridViewHeaderCell") {
                let cell: AnyObject = sut.collectionView.dequeueReusableSupplementaryViewOfKind(DataGridView.SupplementaryViewKind.Header.rawValue, withReuseIdentifier: "DataGridViewHeaderCell", forIndexPath: NSIndexPath(forItem: 0, inSection: 0))
                expect(cell).to(beTruthy())
            }

            it("should register cell with reuseIdentifier DataGridViewContentCell") {
                let cell: AnyObject = sut.collectionView.dequeueReusableCellWithReuseIdentifier("DataGridViewContentCell", forIndexPath: NSIndexPath(forItem: 0, inSection: 0))
                expect(cell).to(beTruthy())
            }

            it("should have transparent background") {
                expect(sut.collectionView.backgroundColor) == UIColor.clearColor()
            }

            describe("layout") {
                it("should be instance of DataGridViewLayout") {
                    expect(sut.collectionView.collectionViewLayout).to(beAKindOf(DataGridViewLayout.self))
                }
                it("should have dataGridView set") {
                    expect(sut.layout.dataGridView) === sut
                }
                it("should have collectionView and dataGridView properties set") {
                    let layout = sut.collectionView.collectionViewLayout as? DataGridViewLayout
                    expect(layout).to(beTruthy())
                    if let layout = layout {
                        expect(layout.dataGridView) === sut
                        expect(layout.collectionView) === sut.collectionView
                    }
                }
            }
        }

        describe("dataGridDataSource") {
            it("should assign dataSource to DataGridDataSourceWrapper") {
                let dataSource = StubDataGridViewDataSource()
                sut.dataSource = dataSource
                expect(sut.dataSource).to(beTruthy())
                if let dataSourceWrapper = sut.dataSourceWrapper {
                    expect(dataSourceWrapper.dataGridView) === sut
                    expect(dataSourceWrapper.dataGridDataSource) === dataSource
                }
            }
        }

        describe("dataGridDelegate") {
            it("should assign delegate to DataGridDelegateWrapper") {
                let delegate = StubDataGridViewDelegate()
                sut.delegate = delegate
                expect(sut.delegate).to(beTruthy())
                if let delegateWrapper = sut.delegateWrapper {
                    expect(delegateWrapper.dataGridView) === sut
                    expect(delegateWrapper.dataGridDelegate) === delegate
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

                expect(sut.collectionView.indexPathsForSelectedItems()?.count) == sut.numberOfColumns()
                for i in 0..<sut.numberOfColumns() {
                    let indexPath = NSIndexPath(forItem: i, inSection: row)
                    expect(sut.collectionView.indexPathsForSelectedItems()).to(contain(indexPath))
                }
            }
            it("should deselect previously selected row") {
                let row = 1
                sut.selectRow(0, animated: false)
                sut.selectRow(row, animated: false)

                expect(sut.collectionView.indexPathsForSelectedItems()?.count) == sut.numberOfColumns()
                for i in 0..<sut.numberOfColumns() {
                    let indexPath = NSIndexPath(forItem: i, inSection: row)
                    expect(sut.collectionView.indexPathsForSelectedItems()).to(contain(indexPath))
                }
            }
        }

        describe("deselectRow:animated:") {
            it("should deselect all items in corresponding section") {
                let row = 1
                sut.selectRow(row, animated: false)
                sut.deselectRow(row, animated: false)

                expect(sut.collectionView.indexPathsForSelectedItems()?.count) == 0
            }
        }
    }
}
