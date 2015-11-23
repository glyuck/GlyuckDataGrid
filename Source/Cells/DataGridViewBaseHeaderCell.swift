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


public class DataGridViewBaseHeaderCell: DataGridViewBaseCell {
    public dynamic var normalBackgroundColor: UIColor?
    public dynamic var sortedBackgroundColor: UIColor?
    public dynamic var sortAscSuffix: String?
    public dynamic var sortDescSuffix: String?
    public var dataGridView: DataGridView!
    public var indexPath: NSIndexPath!
    public var isSorted: Bool = false {
        didSet {
            backgroundColor = isSorted ? sortedBackgroundColor : normalBackgroundColor
        }
    }

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
