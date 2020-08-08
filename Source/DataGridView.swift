//
//  DataGridView.swift
//  Pods
//
//  Created by Vladimir Lyukov on 30/07/15.
//
//

import UIKit


/**
 An object that adopts the DataGridViewDataSource protocol is responsible for providing the data and views required by a collection view. Just like UITableViewDataSource or UICollectionView data source.

 At a minimum, all data source objects must implement the numberOfColumnsInDataGridView:, numberOfRowsInDataGridView, dataGridView:titleForHeaderForColumn: and either dataGridView:cellForItemAtIndexPath: or dataGridView:textForCellAtIndexPath: methods. These methods are responsible for returning the number of rows/columns in the data grid view along with the cells.
*/
@objc public protocol DataGridViewDataSource {
     /**
     Asks the data source object for number of columns in specified data grid view.

     - parameter dataGridView: The data grid view requesting information.

     - returns: Number of columns in data grid view.
     */
    func numberOfColumnsInDataGridView(_ dataGridView: DataGridView) -> Int

    /**
     Asks the data source object for number of rows in specified data grid view.

     - parameter dataGridView: The data grid view requesting information.

     - returns: Number of rows in data grid view.
     */
    func numberOfRowsInDataGridView(_ dataGridView: DataGridView) -> Int

    /**
     Asks the data source for title of header of the specified column in data grid view. You should use either this method or dataGridView:viewForHeaderForColumn: to configure header view.

     - parameter dataGridView: The data grid view requesting information.
     - parameter column:       An index number identifying column of data grid view.

     - returns: A string to use as title for column header.
     */
    @objc optional func dataGridView(_ dataGridView: DataGridView, titleForHeaderForColumn column: Int) -> String

    /**
     Asks the data source for a view object to display in the header of the specified column of the data grid view. If implemented, dataGridView:titleForHeaderForColumn: is not called.

     - parameter dataGridView: The data grid view requesting information.
     - parameter column:       An index number identifying column of data grid view.

     - returns: A view object to be displayed in the header of the column.
     */
    @objc optional func dataGridView(_ dataGridView: DataGridView, viewForHeaderForColumn column: Int) -> DataGridViewColumnHeaderCell


    /**
     Asks the data source for title of header of the specified row in data grid view. You should use either this method or dataGridView:viewForHeaderForRow: to configure header view.

     - parameter dataGridView: The data grid view requesting information.
     - parameter row:          An index number identifying row of data grid view.

     - returns: A string to use as title for row header.
     */
    @objc optional func dataGridView(_ dataGridView: DataGridView, titleForHeaderForRow row: Int) -> String

    /**
     Asks the data source for a view object to display in the header of the specified row of the data grid view. If implemented, dataGridView:titleForHeaderForRow: is not called.

     - parameter dataGridView: The data grid view requesting information.
     - parameter column:       An index number identifying row of data grid view.

     - returns: A view object to be displayed in the header of the row.
     */
    @objc optional func dataGridView(_ dataGridView: DataGridView, viewForHeaderForRow row: Int) -> DataGridViewRowHeaderCell

    /**
     Asks the data source for a cell to insert in a particular location of the data grid view.

     You should use either this method or dataGridView:textForCellAtIndexPath: to configure your cells.

     - parameter dataGridView: The data grid view requesting information.
     - parameter indexPath:    An index path locating cell in data grid view. Be sure to use .dataGridColumn and .dataGridRow properties.

     - returns: An object inheriting from UICollectionViewCell that the data grid view can use for the specified row+column.
     */
    @objc optional func dataGridView(_ dataGridView: DataGridView, cellForItemAtIndexPath indexPath: IndexPath) -> UICollectionViewCell

    /**
     Asks the data source for text to be placed in default cell.

     You should use either this method or dataGridView:cellForItemAtIndexPath:

     - parameter dataGridView: The data grid view requesting information.
     - parameter indexPath:    An index path locating cell in data grid view. Be sure to use .dataGridColumn and .dataGridRow properties.

     - returns: A string to us as text for default cell.
     */
    @objc optional func dataGridView(_ dataGridView: DataGridView, textForCellAtIndexPath indexPath: IndexPath) -> String
}


/**
 The DataGridViewDelegate protocol defines methods that allow you to manage the selection and highlighting of cells in a data grid view and to perform actions on those cells. The methods of this protocol are all optional.

 Many methods of this protocol take NSIndexPath objects as parameters. Be sure to use .dataGridColumn and .dataGridRow properties. Multiple sections are not supported.

*/
@objc public protocol DataGridViewDelegate {
    /**
     Asks the delegate for the width to use for the specified column of data grid view.

     - parameter dataGridView: The data grid view requesting information.
     - parameter column:       An index number identifying column of data grid view.

     - returns: A nonnegative floating-point value that specifies the width (in points) of the specified column for data grid view.
     */
    @objc optional func dataGridView(_ dataGridView: DataGridView, widthForColumn column: Int) -> CGFloat

    /**
     Asks the delegate for the height to use for the specified row.

     - parameter dataGridView: The data grid view requesting information.
     - parameter row:          An index number identifying row of data grid view.

     - returns: A nonnegative floating-point value that specifies the height (in points) of the specified row for data grid view.
     */
    @objc optional func dataGridView(_ dataGridView: DataGridView, heightForRow row: Int) -> CGFloat

    /**
     Asks the delegate if specified column should be always kept visible when user scrolls data grid view horizontally.

     - parameter dataGridView: The data grid view requesting information.
     - parameter column:       An index number identifying column of data grid view.

     - returns: true if the row should float or false if it should not.
     */
    @objc optional func dataGridView(_ dataGridView: DataGridView, shouldFloatColumn column: Int) -> Bool

    /**
     Asks the delegate if it accepts sorting by the specified column of data grid view.

     - parameter dataGridView: The data grid view requesting information.
     - parameter column:       An index number identifying column of data grid view.

     - returns: true if the data grid can be sorted by specified column or false if it can not.
     */
    @objc optional func dataGridView(_ dataGridView: DataGridView, shouldSortByColumn column: Int) -> Bool

    /**
     Tells the delegate that user updated sorting column/order of data ggrid view.

     - parameter dataGridView: The data grid view object that is notifying you of the sorting change.
     - parameter column:       An index number identifying new sort column of data grid view.
     - parameter ascending:    Boolean indicating sort direction. True if should sort in ascending order or false if descending order.
     */
    @objc optional func dataGridView(_ dataGridView: DataGridView, didSortByColumn column: Int, ascending: Bool)

    /**
     Asks the delegate if the specified row should be selected.

     - parameter dataGridView: The data grid view requesting information.
     - parameter row:          An index number identifying row of data grid view.

     - returns: true if the row should be selected or false if it should not.
     */
    @objc optional func dataGridView(_ dataGridView: DataGridView, shouldSelectRow row: Int) -> Bool

    /**
     Tells the delegate that the row at the specified index was selected.

     - parameter dataGridView: The data grid view object that is notifying you of the selection change.
     - parameter row:          An index number identifying row that was selected.
     */
    @objc optional func dataGridView(_ dataGridView: DataGridView, didSelectRow row: Int)
}


/**
 An instance of DataGridView (or simply, a data grid view) is a means for displaying and editing data represented in multicolumn tables (or 2-dimension matrices).
*/
open class DataGridView: UIView {
    private static var __once: () = {
            let appearance = DataGridView.appearance()
            appearance.row1BackgroundColor = UIColor(white: 0.95, alpha: 1)
            appearance.row2BackgroundColor = UIColor.white
        }()
    /// Constants for reuse identifiers for default cells.
    public enum ReuseIdentifiers {
        public static let defaultColumnHeader = "DataGridViewColumnHeaderCell"
        public static let defaultRowHeader = "DataGridViewRowHeaderCell"
        public static let defaultCornerHeader = "DataGridViewRowHeaderCell"
        public static let defaultCell = "DataGridViewContentCell"
    }

    /// Constants for supplementary view kinds of internally-used collection view.
    public enum SupplementaryViewKind: String {
        /// Header displayed on top of each column.
        case ColumnHeader = "ColumnHeader"
        /// Header displayed on left of each row.
        case RowHeader = "RowHeader"
        /// One header positioned on top-left corner of data grid view. Only displayed if data grid view has both column and row headers.
        case CornerHeader = "CornerHeader"
    }

    /// Collection view used internally to build up data grid.
    fileprivate(set) open lazy var collectionView: UICollectionView = {
        let layout = DataGridViewLayout(dataGridView: self)
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = UIColor.clear
        collectionView.allowsMultipleSelection = true
        collectionView.dataSource = self.collectionViewDataSource
        collectionView.delegate = self.collectionViewDelegate
        self.addSubview(collectionView)
        return collectionView
    }()

    /// Object incapsulates logic for data source of collection view.
    open lazy var collectionViewDataSource: CollectionViewDataSource = {
        return CollectionViewDataSource(dataGridView: self)
    }()

    /// Object incapsulates logic for data source of collection view.
    open lazy var collectionViewDelegate: CollectionViewDelegate = {
        return CollectionViewDelegate(dataGridView: self)
    }()

    /// The object that provides the data for the data grid view.
    open weak var dataSource: DataGridViewDataSource?
    /// The object that acts as the delegate of the data grid view.
    open weak var delegate: DataGridViewDelegate?

    /// Height for every row in data grid view
    open var rowHeight: CGFloat = 44
    /// Height for header row
    open var columnHeaderHeight: CGFloat = 44
    /// Width for vertical header displayed on left of each row. If zero, vertical headers are not displayed.
    open var rowHeaderWidth: CGFloat = 0
    /// Background color for even rows of zebra-striped tables.
    @objc open dynamic var row1BackgroundColor: UIColor?
    /// Background color for odd rows of zebra-striped tables.
    @objc open dynamic var row2BackgroundColor: UIColor?

    /// Current sort column of data grid view.
    fileprivate(set) open var sortColumn: Int?
    /// Current sort order of data grid view.
    fileprivate(set) open var sortAscending = true

    /**
     Tells data grid view to sort data by specified column in specified order. Will update UI for specified column header (add an arrow indicating sort direction).

     - parameter column:    An index number identifying column of data grid view.
     - parameter ascending: Boolean indicating sort direction. True if should sort in ascending order or false if descending order.
     */
    open func setSortColumn(_ column: Int, ascending: Bool) {
        sortColumn = column
        sortAscending = ascending
        delegate?.dataGridView?(self, didSortByColumn: column, ascending: ascending)
        reloadData()
    }

    /**
     Returns number of columns in data grid view.

     - returns: The number of columns in data grid view.
     */
    open func numberOfColumns() -> Int {
        return dataSource?.numberOfColumnsInDataGridView(self) ?? 0
    }

    /**
     Returns number of rows in data grid view.


     - returns: The number of rows in data grid view.
     */
    open func numberOfRows() -> Int {
        return dataSource?.numberOfRowsInDataGridView(self) ?? 0
    }

    /**
     This function is used to configure data grid view after creation. Register default cells, setup colors, etc.
     */
    open func setupDataGridView() {
        registerClass(DataGridViewContentCell.self, forCellWithReuseIdentifier: ReuseIdentifiers.defaultCell)
        registerClass(DataGridViewColumnHeaderCell.self, forHeaderOfKind: .ColumnHeader, withReuseIdentifier: ReuseIdentifiers.defaultColumnHeader)
        registerClass(DataGridViewRowHeaderCell.self, forHeaderOfKind: .RowHeader, withReuseIdentifier: ReuseIdentifiers.defaultRowHeader)
        registerClass(DataGridViewCornerHeaderCell.self, forHeaderOfKind: .CornerHeader, withReuseIdentifier: ReuseIdentifiers.defaultCornerHeader)
    }

    /**
     Reloads the rows and columns of the data grid view.
     */
    open func reloadData() {
        collectionView.reloadData()
    }

    /**
     Highlights the specified row in the data grid view. Highlights only visible cells.

     - parameter row: An index number identifying row to be highlighted.
     */
    open func highlightRow(_ row: Int) {
        for column in 0..<numberOfColumns() {
            let indexPath = IndexPath(item: column, section: row)
            if let cell = collectionView.cellForItem(at: indexPath) {
                cell.isHighlighted = true
            }
        }
    }

    /**
     Unhighlights the specified row in the data grid view. Unhighlights only visible cells.

     - parameter row: And index number identifying row to be unhighlighted.
     */
    open func unhighlightRow(_ row: Int) {
        for column in 0..<numberOfColumns() {
            let indexPath = IndexPath(item: column, section: row)
            if let cell = collectionView.cellForItem(at: indexPath) {
                cell.isHighlighted = false
            }
        }
    }

    /**
     Selects the whole specified row in the data grid view.

     - parameter row:      An index number identifying row to be selected.
     - parameter animated: true if you want to animate the selection; false if the change should be immediate.
     */
    open func selectRow(_ row: Int, animated: Bool) {
        collectionView.indexPathsForSelectedItems?.forEach { collectionView.deselectItem(at: $0, animated: animated) }
        for column in 0..<numberOfColumns() {
            let indexPath = IndexPath(item: column, section: row)
            collectionView.selectItem(at: indexPath, animated: animated, scrollPosition: UICollectionView.ScrollPosition())
        }
    }

    /**
     Deselectes the whole specified row in the data grid view.

     - parameter row:      An index number identifying row to be deselected.
     - parameter animated: true if you want to animate the selection; false if the change should be immediate.
     */
    open func deselectRow(_ row: Int, animated: Bool) {
        for column in 0..<numberOfColumns() {
            let indexPath = IndexPath(item: column, section: row)
            collectionView.deselectItem(at: indexPath, animated: animated)
        }
    }

    /**
     Register a nib file for use in creating new data grid view cells.

     - parameter nib:        The nib object containing the cell object. The nib file must contain only one top-level object and that object must be of the type UICollectionViewCell.
     - parameter identifier: The reuse identifier for the cell. This parameter must not be nil and must not be an empty string.
     */
    open func registerNib(_ nib: UINib, forCellWithReuseIdentifier identifier: String) {
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
    }

    /**
     Registers a class for use in creating new data grid view cells.

     - parameter cellClass:  The class of a cell that you want to use in the data grid view.
     - parameter identifier: The reuse identifier for the cell. This parameter must not be nil and must not be an empty string.
     */
    open func registerClass(_ cellClass: DataGridViewContentCell.Type, forCellWithReuseIdentifier identifier: String) {
        collectionView.register(cellClass, forCellWithReuseIdentifier: identifier)
    }

    /**
     Returns a reusable data grid view cell object for the specified reuse identifier and adds it to the data grid view.

     - parameter identifier: A string identifying the cell object to be reused. This parameter must not be nil.
     - parameter indexPath:  The index path specifying the location of the cell. The data source receives this information when it is asked for the cell and should just pass it along. This method uses the index path to perform additional configuration based on the cell’s position in the data grid view.

     - returns: A UICollectionView object with the associated reuse identifier. This method always returns a valid cell.
     */
    open func dequeueReusableCellWithReuseIdentifier(_ identifier: String, forIndexPath indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        if indexPath.dataGridRow % 2 == 0 {
            cell.backgroundColor = row1BackgroundColor
        } else {
            cell.backgroundColor = row2BackgroundColor
        }
        return cell
    }

    /**
     Registers a nib file for use in creating header views for the data grid view.

     - parameter nib:        The nib object containing the view object. The nib file must contain only one top-level object and that object must be of the type DataGridViewRowHeaderCell.
     - parameter kind:       Specified nib will be used to create headers of specified kind.
     - parameter identifier: The reuse identifier for the view. This parameter must not be nil and must not be an empty string.
     */
    open func registerNib(_ nib: UINib, forHeaderOfKind kind: SupplementaryViewKind, withReuseIdentifier identifier: String) {
        collectionView.register(nib, forSupplementaryViewOfKind: kind.rawValue, withReuseIdentifier: identifier)
    }

    /**
     Registers a class for use in creating column header views for the data grid view.

     - parameter cellClass:  The class of a column header view that you want to use in the data grid view.
     - parameter kind:       Specified class will be used to create headers of specified kind.
     - parameter identifier: The reuse identifier for the view. This parameter must not be nil and must not be an empty string.
     */
    open func registerClass(_ cellClass: DataGridViewBaseCell.Type, forHeaderOfKind kind: SupplementaryViewKind, withReuseIdentifier identifier: String) {
        collectionView.register(cellClass, forSupplementaryViewOfKind: kind.rawValue, withReuseIdentifier: identifier)
    }

    /**
     Returns a resuable view for the specified column header located by identifier.

     - parameter identifier: The reuse identifier for the specified column header view. This parameter must not be nil.
     - parameter column:     An index number identifying column of data grid view.

     - returns: A DataGridViewColumnHeaderCell object with the associated reuse identifier. This method always returns a valid view.
     */
    open func dequeueReusableHeaderViewWithReuseIdentifier(_ identifier: String, forColumn column: NSInteger) -> DataGridViewColumnHeaderCell {
        let indexPath = IndexPath(index: column)
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: SupplementaryViewKind.ColumnHeader.rawValue, withReuseIdentifier: identifier, for: indexPath)
        guard let headerCell = cell as? DataGridViewColumnHeaderCell else {
            fatalError("Error in dequeueReusableHeaderViewWithReuseIdentifier(\(identifier), forColumn:\(column)): expected to receive object of DataGridViewColumnHeaderCell class, got \(String(describing: cell.self)) instead")
        }
        headerCell.configureForDataGridView(self, indexPath: indexPath)
        headerCell.isSorted = column == sortColumn
        headerCell.isSortedAsc = sortAscending
        return headerCell
    }

    /**
     Returns a resuable view for the specified column header located by identifier.

     - parameter identifier: The reuse identifier for the specified column header view. This parameter must not be nil.
     - parameter column:     An index number identifying column of data grid view.

     - returns: A DataGridViewColumnHeaderCell object with the associated reuse identifier. This method always returns a valid view.
     */
    open func dequeueReusableHeaderViewWithReuseIdentifier(_ identifier: String, forRow row: NSInteger) -> DataGridViewRowHeaderCell {
        let indexPath = IndexPath(index: row)
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: SupplementaryViewKind.RowHeader.rawValue, withReuseIdentifier: identifier, for: indexPath)
        guard let headerCell = cell as? DataGridViewRowHeaderCell else {
            fatalError("Error in dequeueReusableHeaderViewWithReuseIdentifier(\(identifier), forRow:\(row)): expected to receive object of DataGridViewRowHeaderCell class, got \(String(describing: cell.self)) instead")
        }
        headerCell.configureForDataGridView(self, indexPath: indexPath)
        return headerCell
    }

    /**
     Returns a resuable view for the specified column header located by identifier.

     - parameter identifier: The reuse identifier for the specified column header view. This parameter must not be nil.
     - parameter column:     An index number identifying column of data grid view.

     - returns: A DataGridViewColumnHeaderCell object with the associated reuse identifier. This method always returns a valid view.
     */
    open func dequeueReusableCornerHeaderViewWithReuseIdentifier(_ identifier: String) -> DataGridViewCornerHeaderCell {
        let indexPath = IndexPath(index: 0)
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: SupplementaryViewKind.CornerHeader.rawValue, withReuseIdentifier: identifier, for: indexPath)
        guard let headerCell = cell as? DataGridViewCornerHeaderCell else {
            fatalError("Error in dequeueReusableCornerHeaderViewWithReuseIdentifier(\(identifier)): expected to receive object of DataGridViewCornerHeaderCell class, got \(String(describing: cell.self)) instead")
        }
        headerCell.configureForDataGridView(self, indexPath: indexPath)
        return headerCell
    }

    // UIView

//    public override static func initialize() {
//        super.initialize()
//        _ = DataGridView.__once
//    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupDataGridView()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupDataGridView()
    }

    // UIScrollView

    open var contentOffset: CGPoint {
        set { collectionView.contentOffset = newValue }
        get { return collectionView.contentOffset }
    }

    open func setContentOffset(_ contentOffset: CGPoint, animated: Bool) {
        collectionView.setContentOffset(contentOffset, animated: animated)
    }
}
