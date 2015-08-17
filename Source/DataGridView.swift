//
//  DataGridView.swift
//  Pods
//
//  Created by Vladimir Lyukov on 30/07/15.
//
//

import UIKit


private var setupAppearanceDispatchTocken = dispatch_once_t()


@objc public protocol DataGridViewDataSource {
    func numberOfColumnsInDataGridView(dataGridView: DataGridView) -> Int
    func numberOfRowsInDataGridView(dataGridView: DataGridView) -> Int
    func dataGridView(dataGridView: DataGridView, titleForHeaderForColumn column: Int) -> String
    func dataGridView(dataGridView: DataGridView, textForColumn column: Int, atRow row: Int) -> String
    optional func dataGridView(dataGridView: DataGridView, configureHeaderCell cell:DataGridViewHeaderCell, atColumn column: Int)
    optional func dataGridView(dataGridView: DataGridView, configureContentCell cell:DataGridViewContentCell, atColumn column:Int, row: Int)
}


@objc public protocol DataGridViewDelegate {
    optional func sectionHeaderHeightForDataGridView(dataGridView: DataGridView) -> CGFloat
    optional func dataGridView(dataGridView: DataGridView, widthForColumn column: Int) -> CGFloat
    optional func dataGridView(dataGridView: DataGridView, heightForRow row: Int) -> CGFloat
    optional func dataGridView(dataGridView: DataGridView, shouldFloatColumn column: Int) -> Bool
}


public class DataGridView: UIView {
    private(set) public lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.frame, collectionViewLayout: self.layout)
        collectionView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
        collectionView.registerClass(DataGridViewHeaderCell.classForCoder(), forCellWithReuseIdentifier: "DataGridViewHeaderCell")
        collectionView.registerClass(DataGridViewContentCell.classForCoder(), forCellWithReuseIdentifier: "DataGridViewContentCell")
        collectionView.backgroundColor = UIColor.clearColor()
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

    public dynamic var row1BackgroundColor: UIColor?
    public dynamic var row2BackgroundColor: UIColor?

    public func numberOfColumns() -> Int {
        return dataSource?.numberOfColumnsInDataGridView(self) ?? 0
    }

    public func numberOfRows() -> Int {
        return dataSource?.numberOfRowsInDataGridView(self) ?? 0
    }

    public override static func initialize() {
        super.initialize()
        dispatch_once(&setupAppearanceDispatchTocken) {
            let appearance = self.appearance()
            appearance.row1BackgroundColor = UIColor(white: 0.95, alpha: 1)
            appearance.row2BackgroundColor = UIColor.whiteColor()
        }
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
