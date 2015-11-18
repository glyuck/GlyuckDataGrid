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
    optional func dataGridView(dataGridView: DataGridView, viewForHeaderForColumn column: Int) -> DataGridViewHeaderCell
    optional func dataGridView(dataGridView: DataGridView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    optional func dataGridView(dataGridView: DataGridView, textForCellAtIndexPath indexPath: NSIndexPath) -> String
}


@objc public protocol DataGridViewDelegate {
    optional func sectionHeaderHeightForDataGridView(dataGridView: DataGridView) -> CGFloat
    optional func dataGridView(dataGridView: DataGridView, widthForColumn column: Int) -> CGFloat
    optional func dataGridView(dataGridView: DataGridView, heightForRow row: Int) -> CGFloat
    optional func dataGridView(dataGridView: DataGridView, shouldFloatColumn column: Int) -> Bool
    optional func dataGridView(dataGridView: DataGridView, shouldSortByColumn column: Int) -> Bool
    optional func dataGridView(dataGridView: DataGridView, didSortByColumn column: Int, ascending: Bool)
    optional func dataGridView(dataGridView: DataGridView, shouldSelectRow row: Int) -> Bool
    optional func dataGridView(dataGridView: DataGridView, didSelectRow row: Int)
}


public class DataGridView: UIView {
    public enum ReuseIdentifiers {
        public static let defaultHeader = "DataGridViewHeaderCell"
        public static let defaultCell = "DataGridViewHeaderCell"
    }
    public enum SupplementaryViewKind: String {
        case Header = "Header"
    }

    private(set) public lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: self.layout)
        collectionView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        collectionView.backgroundColor = UIColor.clearColor()
        collectionView.allowsMultipleSelection = true
        collectionView.dataSource = self.collectionViewDataSource
        collectionView.delegate = self.collectionViewDelegate
        self.addSubview(collectionView)
        return collectionView
    }()

    private(set) public lazy var layout: DataGridViewLayout = {
        return DataGridViewLayout(dataGridView: self)
    }()

    public lazy var collectionViewDataSource: CollectionViewDataSource = {
        return CollectionViewDataSource(dataGridView: self)
    }()
    public lazy var collectionViewDelegate: CollectionViewDelegate = {
        return CollectionViewDelegate(dataGridView: self)
    }()

    public weak var dataSource: DataGridViewDataSource?
    public weak var delegate: DataGridViewDelegate?

    public dynamic var row1BackgroundColor: UIColor?
    public dynamic var row2BackgroundColor: UIColor?

    private(set) public var sortColumn: Int?
    private(set) public var sortAscending = true

    public func setSortColumn(column: Int, ascending: Bool) {
        sortColumn = column
        sortAscending = ascending
        delegate?.dataGridView?(self, didSortByColumn: column, ascending: ascending)
        reloadData()
    }

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

    public func setupDataGridView() {
        registerClass(DataGridViewContentCell.self, forCellWithReuseIdentifier: ReuseIdentifiers.defaultCell)
        registerClass(DataGridViewHeaderCell.self, forHeaderWithReuseIdentifier: ReuseIdentifiers.defaultHeader)
    }

    public func reloadData() {
        collectionView.reloadData()
    }

    public func highlightRow(row: Int) {
        for column in 0..<numberOfColumns() {
            let indexPath = NSIndexPath(forItem: column, inSection: row)
            if let cell = collectionView.cellForItemAtIndexPath(indexPath) {
                cell.highlighted = true
            }
        }
    }

    public func unhighlightRow(row: Int) {
        for column in 0..<numberOfColumns() {
            let indexPath = NSIndexPath(forItem: column, inSection: row)
            if let cell = collectionView.cellForItemAtIndexPath(indexPath) {
                cell.highlighted = false
            }
        }
    }

    public func selectRow(row: Int, animated: Bool) {
        collectionView.indexPathsForSelectedItems()?.forEach { collectionView.deselectItemAtIndexPath($0, animated: animated) }
        for column in 0..<numberOfColumns() {
            let indexPath = NSIndexPath(forItem: column, inSection: row)
            collectionView.selectItemAtIndexPath(indexPath, animated: animated, scrollPosition: .None)
        }
    }

    public func deselectRow(row: Int, animated: Bool) {
        for column in 0..<numberOfColumns() {
            let indexPath = NSIndexPath(forItem: column, inSection: row)
            collectionView.deselectItemAtIndexPath(indexPath, animated: animated)
        }
    }

    public func registerNib(nib: UINib, forCellWithReuseIdentifier identifier: String) {
        collectionView.registerNib(nib, forCellWithReuseIdentifier: identifier)
    }

    public func registerClass(cellClass: DataGridViewContentCell.Type, forCellWithReuseIdentifier identifier: String) {
        collectionView.registerClass(cellClass, forCellWithReuseIdentifier: identifier)
    }

    public func dequeueReusableCellWithReuseIdentifier(identifier: String, forIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(identifier, forIndexPath: indexPath)
        if indexPath.dataGridRow % 2 == 0 {
            cell.backgroundColor = row1BackgroundColor
        } else {
            cell.backgroundColor = row2BackgroundColor
        }
        return cell
    }

    public func registerNib(nib: UINib, forHeaderWithReuseIdentifier identifier: String) {
        collectionView.registerNib(nib, forSupplementaryViewOfKind: SupplementaryViewKind.Header.rawValue, withReuseIdentifier: identifier)
    }

    public func registerClass(cellClass: DataGridViewHeaderCell.Type, forHeaderWithReuseIdentifier identifier: String) {
        collectionView.registerClass(cellClass, forSupplementaryViewOfKind: SupplementaryViewKind.Header.rawValue, withReuseIdentifier: identifier)
    }

    public func dequeueReusableHeaderViewWithReuseIdentifier(identifier: String, forColumn column: NSInteger) -> DataGridViewHeaderCell {
        let indexPath = NSIndexPath(forItem: column, inSection: 0)
        let cell = collectionView.dequeueReusableSupplementaryViewOfKind(SupplementaryViewKind.Header.rawValue, withReuseIdentifier: identifier, forIndexPath: indexPath)
        guard let headerCell = cell as? DataGridViewHeaderCell else {
            fatalError("Error in dequeueReusableHeaderViewWithReuseIdentifier(\(identifier), forColumn:\(column)): expected to receive object of DataGridViewHeaderCell class, got \(_stdlib_getDemangledTypeName(cell)) instead")
        }
        headerCell.configureForDataGridView(self, indexPath: indexPath)
        return headerCell
    }

    // UIView

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupDataGridView()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupDataGridView()
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
