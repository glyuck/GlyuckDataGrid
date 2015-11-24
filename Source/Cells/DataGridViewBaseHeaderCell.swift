//
//  DataGridViewBaseHeaderCell.swift
//  Pods
//
//  Created by Vladimir Lyukov on 20/11/15.
//
//

//
//  DataGridViewColumnHeaderCell.swift
//
//  Created by Vladimir Lyukov on 03/08/15.
//

import UIKit


/// Base class for sortable and tapable headers
public class DataGridViewBaseHeaderCell: DataGridViewBaseCell {
    private var normalBackgroundColor: UIColor? {
        didSet {
            updateSortedBackground()
        }
    }
    /// Background color for sorted state
    public dynamic var sortedBackgroundColor: UIColor? {
        didSet {
            updateSortedBackground()
        }
    }
    public override dynamic var backgroundColor: UIColor? {
        get {
            return super.backgroundColor
        }
        set {
            normalBackgroundColor = newValue
        }
    }
    /// This suffix will be appended to title if column/row is sorted in ascending order.
    public dynamic var sortAscSuffix: String?
    /// This suffix will be appended to title if column/row is sorted in descending order.
    public dynamic var sortDescSuffix: String?
    /// Is this header in sorted state (i.e. has sortedBackgroundColor and sortAscSuffix/sortDescSuffix applied)
    public var isSorted: Bool = false {
        didSet {
            updateSortedBackground()
        }
    }
    /// Is this header in sorted ascending or descending order? Only taken into account if isSorted == true.
    public var isSortedAsc: Bool = true {
        didSet {
            updateSortedBackground()
        }
    }
    public var dataGridView: DataGridView!
    public var indexPath: NSIndexPath!

    // MARK: - UIView

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupDataGridViewHeaderCell()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupDataGridViewHeaderCell()
    }

    // MARK: - Custom methods

    public func updateSortedBackground() {
        if isSorted {
            super.backgroundColor = sortedBackgroundColor
        } else {
            super.backgroundColor = normalBackgroundColor
        }
    }

    public func setupDataGridViewHeaderCell() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "didTap:")
        contentView.addGestureRecognizer(tapGestureRecognizer)
    }

    public func configureForDataGridView(dataGridView: DataGridView, indexPath: NSIndexPath) {
        self.dataGridView = dataGridView
        self.indexPath = indexPath
    }

    public func didTap(gesture: UITapGestureRecognizer) {
        dataGridView.collectionViewDelegate.collectionView(dataGridView.collectionView, didTapHeaderForColumn: indexPath.row)
    }
}
