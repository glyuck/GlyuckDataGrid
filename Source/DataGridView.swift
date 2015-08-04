//
//  DataGridView.swift
//  Pods
//
//  Created by Vladimir Lyukov on 30/07/15.
//
//

import UIKit


@objc public protocol DataGridViewDataSource {
    func numberOfColumnsInDataGridView(dataGridView: DataGridView) -> Int
    func numberOfRowsInDataGridView(dataGridView: DataGridView) -> Int
    func dataGridView(dataGridView: DataGridView, titleForHeaderForColumn column: Int) -> String
    func dataGridView(dataGridView: DataGridView, textForColumn column: Int, atRow row: Int) -> String
}


@objc public protocol DataGridViewDelegate {
    optional func sectionHeaderHeightForDataGridView(dataGridView: DataGridView) -> CGFloat
    optional func dataGridView(dataGridView: DataGridView, widthForColumn column: Int) -> CGFloat
    optional func dataGridView(dataGridView: DataGridView, heightForRow row: Int) -> CGFloat
}


public class DataGridView: UIView {
    private(set) public lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.frame, collectionViewLayout: self.layout)
        collectionView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        collectionView.registerClass(DataGridViewHeaderCell.classForCoder(), forCellWithReuseIdentifier: "DataGridViewHeaderCell")
        collectionView.registerClass(DataGridViewContentCell.classForCoder(), forCellWithReuseIdentifier: "DataGridViewContentCell")
        self.addSubview(collectionView)
        return collectionView
    }()

    private(set) public lazy var layout: DataGridViewLayout = {
        return DataGridViewLayout(dataGridView: self)
    }()

    private(set) public var dataSourceWrapper: DataGridDataSourceWrapper?
    public weak var dataSource: DataGridViewDataSource? {
        set {
            if let newValue = newValue {
                dataSourceWrapper = DataGridDataSourceWrapper(dataGridView: self, dataGridDataSource: newValue)
            } else {
                dataSourceWrapper = nil
            }
            collectionView.dataSource = dataSourceWrapper
        }
        get {
            return dataSourceWrapper?.dataGridDataSource
        }
    }

    private(set) public var delegateWrapper: DataGridDelegateWrapper?
    public weak var delegate: DataGridViewDelegate? {
        set {
            if let newValue = newValue {
                delegateWrapper = DataGridDelegateWrapper(dataGridView: self, dataGridDelegate: newValue)
            } else {
                delegateWrapper = nil
            }
            collectionView.delegate = delegateWrapper
        }
        get {
            return delegateWrapper?.dataGridDelegate
        }
    }

    public func numberOfColumns() -> Int {
        return dataSource?.numberOfColumnsInDataGridView(self) ?? 0
    }

    public func numberOfRows() -> Int {
        return dataSource?.numberOfRowsInDataGridView(self) ?? 0
    }

    // UIScrollView

    public var contentOffset: CGPoint {
        set { collectionView.contentOffset = newValue }
        get { return collectionView.contentOffset }
    }

    public func setContentOffset(contentOffset: CGPoint, animated: Bool) {
        collectionView.setContentOffset(contentOffset, animated: animated)
    }
}
