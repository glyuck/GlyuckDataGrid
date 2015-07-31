//
//  DataGridViewSpec.swift
//
//  Created by Vladimir Lyukov on 30/07/15.
//

import Quick
import Nimble
import GlyuckDataGrid


class MockDataSource: NSObject, UICollectionViewDataSource {
    @objc internal func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }

    @objc internal func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
}

class MockDataGridViewDataSource: NSObject, DataGridViewDataSource {
}

class MockDelegate: NSObject, UICollectionViewDelegate {
}

class MockDataGridViewDelegate: NSObject, DataGridViewDelegate {

}
class DataGridViewSpec: QuickSpec {
    override func spec() {
        var dataGridView: DataGridView!

        beforeEach {
            dataGridView = DataGridView(frame: CGRect(x: 0, y: 0, width: 320, height: 480))
        }

        describe("dataGridDataSource") {
            it("should assign dataSource to DataGridDataSourceWrapper") {
                let dataSource = MockDataGridViewDataSource()
                dataGridView.dataGridDataSource = dataSource
                expect(dataGridView.dataSource).to(beTruthy())
                let dataSourceWrapper = dataGridView.dataSource as! DataGridDataSourceWrapper
                expect(dataSourceWrapper.dataGridDataSource) === dataSource
            }
        }

        describe("dataGridDelegate") {
            it("should assign delegate to DataGridDelegateWrapper") {
                let delegate = MockDataGridViewDelegate()
                dataGridView.dataGridDelegate = delegate
                expect(dataGridView.delegate).to(beTruthy())
                let delegateWrapper = dataGridView.delegate as! DataGridDelegateWrapper
                expect(delegateWrapper.dataGridDelegate) === delegate
            }
        }

        describe("layout") {
            it("should be instance of DataGridViewLayout") {
                expect(dataGridView.collectionViewLayout).to(beAKindOf(DataGridViewLayout.self))
            }
        }
    }
}
