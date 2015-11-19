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
public class DataGridViewLayout: UICollectionViewLayout {
    private(set) public var dataGridView: DataGridView!

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

    public func heightForRow(row: Int) -> CGFloat {
        return dataGridView?.delegate?.dataGridView?(dataGridView!, heightForRow: row) ?? dataGridView.rowHeight
    }

    public func widthForColumn(column: Int) -> CGFloat {
        if let width = dataGridView?.delegate?.dataGridView?(dataGridView!, widthForColumn: column) {
            return width
        }
        if let dataGridView = dataGridView, dataSource = dataGridView.dataSource {
            let exactWidth = dataGridView.frame.width / CGFloat(dataSource.numberOfColumnsInDataGridView(dataGridView))
            return column == 0 ? ceil(exactWidth) : floor(exactWidth)
        }
        return 0
    }

    public func heightForSectionHeader() -> CGFloat {
        return dataGridView.columnHeaderHeight
    }

    // MARK: UICollectionViewLayout

    public override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        let x = Array(0..<indexPath.row).reduce(0) { $0 + widthForColumn($1)}
        let y = Array(0..<indexPath.section).reduce(heightForSectionHeader()) { $0 + heightForRow($1)}
        let width = widthForColumn(indexPath.row)
        let height = heightForRow(indexPath.section)
        attributes.frame = CGRect(
            x: max(0, x),
            y: max(0, y),
            width: width,
            height: height
        )
        if dataGridView?.delegate?.dataGridView?(dataGridView!, shouldFloatColumn: indexPath.row) == true {
            let scrollOffsetX = dataGridView.collectionView.contentOffset.x + collectionView!.contentInset.left
            let floatWidths = Array(0..<indexPath.row).reduce(CGFloat(0)) {
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

    public override func layoutAttributesForSupplementaryViewOfKind(elementKind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        guard indexPath.section == 0 && elementKind == DataGridView.SupplementaryViewKind.Header.rawValue else {
            return nil
        }
        let attributes = UICollectionViewLayoutAttributes(forSupplementaryViewOfKind: elementKind, withIndexPath: indexPath)
        let x = Array(0..<indexPath.row).reduce(0) { $0 + widthForColumn($1)}
        let y = dataGridView.collectionView.contentOffset.y + collectionView!.contentInset.top
        let width = widthForColumn(indexPath.row)
        let height = heightForSectionHeader()
        attributes.frame = CGRect(
                x: max(0, x),
                y: max(0, y),
                width: width,
                height: height
            )
        attributes.zIndex = 2
        if dataGridView?.delegate?.dataGridView?(dataGridView!, shouldFloatColumn: indexPath.row) == true {
            let scrollOffsetX = dataGridView.collectionView.contentOffset.x + collectionView!.contentInset.left
            let floatWidths = Array(0..<indexPath.row).reduce(CGFloat(0)) {
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

    public override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var items = [Int]()
        var sections = [Int]()

        var x:CGFloat = 0
        for i in (0..<dataGridView.numberOfColumns()) {
            if x >= rect.maxX {
                break
            }

            let nextX = x + widthForColumn(i)
            if x >= rect.minX || nextX > rect.minX ||
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
        for item in items {
            let headerIndexPath = NSIndexPath(forItem: item, inSection: 0)
            if let headerAttributes = layoutAttributesForSupplementaryViewOfKind(DataGridView.SupplementaryViewKind.Header.rawValue, atIndexPath: headerIndexPath) {
                result.append(headerAttributes)
            }
            for section in sections {
                let indexPath = NSIndexPath(forItem: item, inSection: section)
                result.append(layoutAttributesForItemAtIndexPath(indexPath)!)
            }
        }

        return result
    }

    public override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }

    public override func collectionViewContentSize() -> CGSize {
        let width = Array(0..<dataGridView.numberOfColumns()).reduce(0) { $0 + widthForColumn($1) }
        let height = Array(0..<dataGridView.numberOfRows()).reduce(heightForSectionHeader()) { $0 + heightForRow($1) }
        return CGSize(width: width, height: height)
    }
}
