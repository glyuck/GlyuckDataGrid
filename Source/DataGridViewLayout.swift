//
//  DataGridViewLayout.swift
//  Pods
//
//  Created by Vladimir Lyukov on 30/07/15.
//
//

import UIKit

public class DataGridViewLayout: UICollectionViewLayout {
    private(set) public var dataGridView: DataGridView!

    public var rowHeight: CGFloat = 44
    public var sectionHeaderHeight: CGFloat = 44

    public init(dataGridView: DataGridView) {
        self.dataGridView = dataGridView
        super.init()
    }

    public override init() {
        fatalError("init() has not been implemented")
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func heightForRow(row: Int) -> CGFloat {
        return dataGridView?.delegate?.dataGridView?(dataGridView!, heightForRow: row) ?? rowHeight
    }

    public func widthForColumn(column: Int) -> CGFloat {
        guard let width = dataGridView?.delegate?.dataGridView?(dataGridView!, widthForColumn: column) else {
            if let dataGridView = dataGridView, dataSource = dataGridView.dataSource {
                let exactWidth = dataGridView.frame.width / CGFloat(dataSource.numberOfColumnsInDataGridView(dataGridView))
                return column == 0 ? ceil(exactWidth) : floor(exactWidth)
            }
            return 0
        }
        return width
    }

    public func heightForSectionHeader() -> CGFloat {
        return dataGridView?.delegate?.sectionHeaderHeightForDataGridView?(dataGridView!) ?? sectionHeaderHeight
    }

    // MARK: UICollectionViewLayout

    public override func layoutAttributesForItemAtIndexPath(indexPath: NSIndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWithIndexPath: indexPath)
        let x = Array(0..<indexPath.row).reduce(0) { $0 + widthForColumn($1)}
        let y = indexPath.section == 0 ? dataGridView.collectionView.contentOffset.y : Array(0..<indexPath.section-1).reduce(heightForSectionHeader()) { $0 + heightForRow($1)}
        let width = widthForColumn(indexPath.row)
        let height = indexPath.section == 0 ? heightForSectionHeader() : heightForRow(indexPath.section - 1)
        attributes.frame = CGRect(
            x: x,
            y: y + collectionView!.contentInset.top,
            width: width,
            height: height
        )

        return attributes
    }

    public override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var items = [Int]()
        var sections = [0]

        var x:CGFloat = 0
        for i in (0..<dataGridView.numberOfColumns()) {
            if x >= rect.maxX {
                break
            }

            let nextX = x + widthForColumn(i)
            if x >= rect.minX || nextX > rect.minX {
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
                sections.append(i+1)
            }
            y = nextY
        }

        var result = [UICollectionViewLayoutAttributes]()
        for item in items {
            for section in sections {
                result.append(layoutAttributesForItemAtIndexPath(NSIndexPath(forItem: item, inSection: section))!)
            }
        }

        return result
    }

}
