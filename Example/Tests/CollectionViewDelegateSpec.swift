//
//  CollectionViewDelegateSpec.swift
//
//  Created by Vladimir Lyukov on 17/08/15.
//

import Foundation

import Quick
import Nimble
import GlyuckDataGrid


class CollectionViewDelegateSpec: QuickSpec {
    override func spec() {
        var dataGridView: DataGridView!
        var stubDataSource: StubDataGridViewDataSource!
        var stubDelegate: StubDataGridViewDelegate!

        var sut: CollectionViewDelegate!

        beforeEach {
            dataGridView = DataGridView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
            stubDataSource = StubDataGridViewDataSource()
            stubDelegate = StubDataGridViewDelegate()
            dataGridView.dataSource = stubDataSource
            dataGridView.delegate = stubDelegate

            sut = dataGridView.collectionViewDelegate
        }

        describe("collectionView:didTapHeaderForColumn:") {
            it("should change dataGridView.sortColumn and sortAscending when sorting enabled") {
                stubDelegate.shouldSortByColumnBlock = { (column) in return true }
                expect(dataGridView.sortColumn).to(beNil())

                // when
                sut.collectionView(dataGridView.collectionView, didTapHeaderForColumn: 0)
                // then
                expect(dataGridView.sortColumn) == 0
                expect(dataGridView.sortAscending).to(beTrue())

                // when
                sut.collectionView(dataGridView.collectionView, didTapHeaderForColumn: 1)
                // then
                expect(dataGridView.sortColumn) == 1
                expect(dataGridView.sortAscending).to(beTrue())

                // when
                sut.collectionView(dataGridView.collectionView, didTapHeaderForColumn: 1)
                // then
                expect(dataGridView.sortColumn) == 1
                expect(dataGridView.sortAscending).to(beFalse())
            }

            it("should do nothing when sorting is disabled") {
                expect(dataGridView.sortColumn).to(beNil())

                // given
                stubDelegate.shouldSortByColumnBlock = { (column) in return false }
                // when
                sut.collectionView(dataGridView.collectionView, didTapHeaderForColumn: 0)
                // then
                expect(dataGridView.sortColumn).to(beNil())
            }

            it("should do nothing when delegate doesnt implement shouldSortByColumn:") {
                // given
                dataGridView.delegate = nil
                // when
                sut.collectionView(dataGridView.collectionView, didTapHeaderForColumn: 0)
                // then
                expect(dataGridView.sortColumn).to(beNil())
            }
        }

        describe("collectionView:didHighlightItemAtIndexPath:") {
            it("should highlight whole row") {
                let row = 1
                let indexPath = NSIndexPath(forItem: 2, inSection: row + 1)
                let collectionView = dataGridView.collectionView
                collectionView.layoutSubviews()  // Otherwise collectionView.cellForItemAtIndexPath won't work
                // when
                sut.collectionView(collectionView, didHighlightItemAtIndexPath: indexPath)

                // then
                for i in 0..<stubDataSource.numberOfColumns {
                    let indexPath = NSIndexPath(forItem: i, inSection: row + 1)
                    if let cell = collectionView.cellForItemAtIndexPath(indexPath) {
                        expect(cell.highlighted).to(beTrue())
                    }
                }
            }
        }

        describe("collectionView:didUnhighlightItemAtIndexPath:") {
            it("should unhighlight whole row") {
                let row = 1
                let indexPath = NSIndexPath(forItem: 2, inSection: row + 1)
                let collectionView = dataGridView.collectionView
                collectionView.layoutSubviews()  // Otherwise collectionView.cellForItemAtIndexPath won't work
                // given
                sut.collectionView(collectionView, didHighlightItemAtIndexPath: indexPath)

                // when
                sut.collectionView(collectionView, didUnhighlightItemAtIndexPath: indexPath)

                // then
                for i in 0..<stubDataSource.numberOfColumns {
                    let indexPath = NSIndexPath(forItem: i, inSection: row + 1)
                    if let cell = collectionView.cellForItemAtIndexPath(indexPath) {
                        expect(cell.highlighted).to(beFalse())
                    }
                }
            }
        }

        describe("collectionView:shouldSelectItemAtIndexPath:") {
            it("should return delegate's dataGridView:shouldSelectRowAtIndexPath:") {
                // when
                stubDelegate.shouldSelectRowBlock = { indexPath in indexPath.dataGridRow % 2 == 0 }

                // then
                expect(sut.collectionView(dataGridView.collectionView, shouldSelectItemAtIndexPath: NSIndexPath(forItem: 0, inSection: 0))).to(beTrue())
                expect(sut.collectionView(dataGridView.collectionView, shouldSelectItemAtIndexPath: NSIndexPath(forItem: 0, inSection: 1))).to(beFalse())
            }

            it("should return true if delegate doesn't implement dataGridView:shouldSelectRowAtIndexPath:") {
                // when
                dataGridView.delegate = StubMinimumDataGridViewDelegate()

                // then
                expect(sut.collectionView(dataGridView.collectionView, shouldSelectItemAtIndexPath: NSIndexPath(forItem: 0, inSection: 0))).to(beTrue())
                expect(sut.collectionView(dataGridView.collectionView, shouldSelectItemAtIndexPath: NSIndexPath(forItem: 0, inSection: 1))).to(beTrue())
            }
        }
        
        describe("collectionView:didSelectItemAtIndexPath:") {
            it("should select whole row") {
                let row = 1
                let indexPath = NSIndexPath(forItem: 2, inSection: row)
                let collectionView = dataGridView.collectionView
                collectionView.layoutSubviews()

                // when
                sut.collectionView(collectionView, didSelectItemAtIndexPath: indexPath)
                let selectedIndexes = collectionView.indexPathsForSelectedItems()

                // then
                expect(selectedIndexes?.count) == stubDataSource.numberOfColumns
                for i in 0..<stubDataSource.numberOfColumns {
                    let indexPath = NSIndexPath(forItem: i, inSection: row)
                    expect(selectedIndexes).to(contain(indexPath))
                }
            }

            it("should call delegate's dataGridView:didSelectRow:") {
                let row = 1
                let indexPath = NSIndexPath(forItem: 2, inSection: row)
                let collectionView = dataGridView.collectionView
                var selectedRow: Int?
                // given
                stubDelegate.didSelectRowBlock = { row in
                    selectedRow = row
                }
                // when
                sut.collectionView(collectionView, didSelectItemAtIndexPath: indexPath)
                // then
                expect(selectedRow) == row
            }
        }
    }
}
