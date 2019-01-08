//
//  DataGridViewLayout.swift
//  Pods
//
//  Created by Vladimir Lyukov on 30/07/15.
//
//

import UIKit


/**
 Custom UICollectionViewLayout implementing data grid view layout. Implements layout for single-section table with floating header and columns. You should not use this class directly.
*/
open class DataGridViewLayout: UICollectionViewLayout {
    fileprivate(set) open var dataGridView: DataGridView!

    public init(dataGridView: DataGridView) {
        self.dataGridView = dataGridView
        super.init()
    }

    public override init() {
        fatalError("init() has not been implemented")
    }

    public required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    open func heightForRow(_ row: Int) -> CGFloat {
        return dataGridView?.delegate?.dataGridView?(dataGridView!, heightForRow: row) ?? dataGridView.rowHeight
    }

    open func widthForColumn(_ column: Int) -> CGFloat {
        if let width = dataGridView?.delegate?.dataGridView?(dataGridView!, widthForColumn: column) {
            return width
        }
        if let dataGridView = dataGridView, let dataSource = dataGridView.dataSource {
            let exactWidth = (dataGridView.frame.width - dataGridView.rowHeaderWidth) / CGFloat(dataSource.numberOfColumnsInDataGridView(dataGridView))
            let exactStart = Array(0..<column).reduce(0) { x, column in x + exactWidth }
            let exactEnd = exactStart + exactWidth
            return round(exactEnd) - round(exactStart)
        }
        return 0
    }

    open func widthForRowHeader() -> CGFloat {
        return dataGridView.rowHeaderWidth
    }

    open func heightForSectionHeader() -> CGFloat {
        return dataGridView.columnHeaderHeight
    }

    // MARK: UICollectionViewLayout

    open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        let x = Array(0..<(indexPath as NSIndexPath).row).reduce(widthForRowHeader()) { $0 + widthForColumn($1)}
        let y = Array(0..<(indexPath as NSIndexPath).section).reduce(heightForSectionHeader()) { $0 + heightForRow($1)}
        let width = widthForColumn((indexPath as NSIndexPath).row)
        let height = heightForRow((indexPath as NSIndexPath).section)
        attributes.frame = CGRect(
            x: max(0, x),
            y: max(0, y),
            width: width,
            height: height
        )
        if dataGridView?.delegate?.dataGridView?(dataGridView!, shouldFloatColumn: (indexPath as NSIndexPath).row) == true {
            let scrollOffsetX = dataGridView.collectionView.contentOffset.x + collectionView!.contentInset.left
            let floatWidths = Array(0..<(indexPath as NSIndexPath).row).reduce(CGFloat(0)) {
                if dataGridView?.delegate?.dataGridView?(dataGridView!, shouldFloatColumn: $1) == true {
                    return $0 + widthForColumn($1)
                } else {
                    return $0
                }
            }
            attributes.frame.origin.x = max(scrollOffsetX + floatWidths, attributes.frame.origin.x)
            attributes.zIndex += 1
        }

        return attributes
    }

    open override func layoutAttributesForSupplementaryView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let elementKind = DataGridView.SupplementaryViewKind(rawValue: elementKind) else {
            return nil
        }
        return layoutAttributesForSupplementaryViewOfKind(elementKind, atIndexPath: indexPath)
    }

    open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var items = [Int]()
        var sections = [Int]()

        var x:CGFloat = widthForRowHeader()
        for i in (0..<dataGridView.numberOfColumns()) {
            if x >= rect.maxX {
                break
            }

            let nextX = x + widthForColumn(i)
            if x - widthForRowHeader() >= rect.minX || nextX - widthForRowHeader() > rect.minX ||
                    dataGridView?.delegate?.dataGridView?(dataGridView!, shouldFloatColumn: i) == true {
                items.append(i)
            }
            x = nextX
        }

        let headerHeight = heightForSectionHeader()
        var y: CGFloat = heightForSectionHeader()
        for i in (0..<dataGridView.numberOfRows()) {
            if y >= rect.maxY {
                break
            }

            let nextY = y + heightForRow(0)
            if y - headerHeight >= rect.minY || nextY - headerHeight > rect.minY {
                sections.append(i)
            }
            y = nextY
        }

        var result = [UICollectionViewLayoutAttributes]()
        // Cells
        for item in items {
            for section in sections {
                let indexPath = IndexPath(item: item, section: section)
                result.append(layoutAttributesForItem(at: indexPath)!)
            }
        }
        // Column headers
        for item in items {
            let headerIndexPath = IndexPath(index: item)
            if let headerAttributes = layoutAttributesForSupplementaryViewOfKind(.ColumnHeader, atIndexPath: headerIndexPath) {
                result.append(headerAttributes)
            }
        }
        // Row headers
        if widthForRowHeader() > 0 {
            for section in sections {
                let rowHeaderIndexPath = IndexPath(index: section)
                if let rowHeaderAttributes = layoutAttributesForSupplementaryViewOfKind(.RowHeader, atIndexPath: rowHeaderIndexPath) {
                    result.append(rowHeaderAttributes)
                }
            }
        }
        // Corner header
        if widthForRowHeader() > 0 && heightForSectionHeader() > 0 {
            let cornerHeaderIndexPath = IndexPath(index: 0)
            if let cornerHeaderAttributes = layoutAttributesForSupplementaryViewOfKind(.CornerHeader, atIndexPath: cornerHeaderIndexPath) {
                result.append(cornerHeaderAttributes)
            }
        }

        return result
    }

    open override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }

    open override var collectionViewContentSize : CGSize {
        let width = Array(0..<dataGridView.numberOfColumns()).reduce(widthForRowHeader()) { $0 + widthForColumn($1) }
        let height = Array(0..<dataGridView.numberOfRows()).reduce(heightForSectionHeader()) { $0 + heightForRow($1) }
        return CGSize(width: width, height: height)
    }

    // MARK: - Functions for providing supplementary views (row headers / columns headers / etc)
    func layoutAttributesForSupplementaryViewOfKind(_ elementKind: DataGridView.SupplementaryViewKind, atIndexPath indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        switch elementKind {
        case .ColumnHeader: return layoutAttributesForColumnHeaderViewAtIndexPath(indexPath)
        case .RowHeader: return layoutAttributesForRowHeaderViewAtIndexPath(indexPath)
        case .CornerHeader: return layoutAttributesForCornerHeaderViewAtIndexPath(indexPath)
        }
    }

    open func layoutAttributesForColumnHeaderViewAtIndexPath(_ indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: DataGridView.SupplementaryViewKind.ColumnHeader.rawValue, with: indexPath)
        let x = Array(0..<indexPath.index).reduce(dataGridView.rowHeaderWidth) { $0 + widthForColumn($1)}
        let y = dataGridView.collectionView.contentOffset.y + collectionView!.contentInset.top
        let width = widthForColumn(indexPath.index)
        let height = heightForSectionHeader()
        attributes.frame = CGRect(
            x: max(0, x),
            y: max(0, y),
            width: width,
            height: height
        )
        attributes.zIndex = 2
        if dataGridView?.delegate?.dataGridView?(dataGridView!, shouldFloatColumn: indexPath.index) == true {
            let scrollOffsetX = dataGridView.collectionView.contentOffset.x + collectionView!.contentInset.left
            let floatWidths = Array(0..<indexPath.index).reduce(CGFloat(0)) {
                if dataGridView?.delegate?.dataGridView?(dataGridView!, shouldFloatColumn: $1) == true {
                    return $0 + widthForColumn($1)
                } else {
                    return $0
                }
            }
            attributes.frame.origin.x = max(scrollOffsetX + floatWidths, attributes.frame.origin.x)
            attributes.zIndex += 1
        }
        return attributes
    }

    open func layoutAttributesForRowHeaderViewAtIndexPath(_ indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: DataGridView.SupplementaryViewKind.RowHeader.rawValue, with: indexPath)
        let x = collectionView!.contentInset.left + dataGridView.collectionView.contentOffset.x
        let y = Array(0..<indexPath.index).reduce(heightForSectionHeader()) { $0 + heightForRow($1)}
        let width = widthForRowHeader()
        let height = heightForRow(indexPath.index)
        attributes.frame = CGRect(
            x: max(0, x),
            y: max(0, y),
            width: width,
            height: height
        )
        attributes.zIndex = 2
        return attributes
    }

    open func layoutAttributesForCornerHeaderViewAtIndexPath(_ indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: DataGridView.SupplementaryViewKind.CornerHeader.rawValue, with: indexPath)
        let x = collectionView!.contentInset.left + dataGridView.collectionView.contentOffset.x
        let y = collectionView!.contentInset.top + dataGridView.collectionView.contentOffset.y
        let width = widthForRowHeader()
        let height = heightForSectionHeader()
        attributes.frame = CGRect(
            x: max(0, x),
            y: max(0, y),
            width: width,
            height: height
        )
        attributes.zIndex = 5
        return attributes
    }
}
