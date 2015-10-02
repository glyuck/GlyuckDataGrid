//
//  DataGridViewDelegateSpec.swift
//
//  Created by Vladimir Lyukov on 17/08/15.
//

import Foundation

import Quick
import Nimble
import GlyuckDataGrid


class DataGridDataDelegateWrapperSpec: QuickSpec {
    override func spec() {
        var dataGridView: DataGridView!
        var stubDataSource: StubDataGridViewDataSource!
        var stubDelegate: StubDataGridViewDelegate!

        var sut: DataGridDelegateWrapper!

        beforeEach {
            dataGridView = DataGridView(frame: CGRect(x: 0, y: 0, width: 400, height: 400))
            stubDataSource = StubDataGridViewDataSource()
            stubDelegate = StubDataGridViewDelegate()
            dataGridView.dataSource = stubDataSource
            dataGridView.delegate = stubDelegate

            sut = dataGridView.delegateWrapper
        }

        describe("collectionView:shouldSelectItemAtIndexPath:") {
            context("for header") {
                it("should return delegate's dataGridView:shouldSortByColumn:") {
                    stubDelegate.shouldSortByColumnBlock = { (column) in return column == 1 }

                    expect(sut.collectionView(dataGridView.collectionView, shouldSelectItemAtIndexPath:NSIndexPath(forItem: 0, inSection: 0))).to(beFalse())
                    expect(sut.collectionView(dataGridView.collectionView, shouldSelectItemAtIndexPath:NSIndexPath(forItem: 1, inSection: 0))).to(beTrue())
                }

                it("should return false if delegate doesn't implement methods") {
                    let stubMinimumDelegate = StubMinimumDataGridViewDelegate()
                    dataGridView.delegate = stubMinimumDelegate
                    sut = dataGridView.delegateWrapper

                    expect(sut.collectionView(dataGridView.collectionView, shouldSelectItemAtIndexPath: NSIndexPath(forItem: 0, inSection: 0))).to(beFalse())
                    expect(sut.collectionView(dataGridView.collectionView, shouldSelectItemAtIndexPath: NSIndexPath(forItem: 1, inSection: 0))).to(beFalse())
                }
            }
        }

        describe("collectionView:shouldSelectItemAtIndexPath:") {
            context("for header") {
                it("should change dataGridView.sortColumn and sortAscending") {
                    stubDelegate.shouldSortByColumnBlock = { (column) in return true }
                    expect(dataGridView.sortColumn).to(beNil())

                    // when
                    sut.collectionView(dataGridView.collectionView, didSelectItemAtIndexPath: NSIndexPath(forItem: 0, inSection: 0))
                    // then
                    expect(dataGridView.sortColumn) == 0
                    expect(dataGridView.sortAscending).to(beTrue())

                    // when
                    sut.collectionView(dataGridView.collectionView, didSelectItemAtIndexPath: NSIndexPath(forItem: 1, inSection: 0))
                    // then
                    expect(dataGridView.sortColumn) == 1
                    expect(dataGridView.sortAscending).to(beTrue())

                    // when
                    sut.collectionView(dataGridView.collectionView, didSelectItemAtIndexPath: NSIndexPath(forItem: 1, inSection: 0))
                    // then
                    expect(dataGridView.sortColumn) == 1
                    expect(dataGridView.sortAscending).to(beFalse())
                }

                it("should deselect row immediately") {
                    let indexPath = NSIndexPath(forItem: 0, inSection: 0)
                    dataGridView.collectionView.selectItemAtIndexPath(indexPath, animated: false, scrollPosition: UICollectionViewScrollPosition.None)
                    sut.collectionView(dataGridView.collectionView, didSelectItemAtIndexPath: indexPath)
                    expect(dataGridView.collectionView.indexPathsForSelectedItems()).to(beEmpty())
                }
            }
        }
    }
}
