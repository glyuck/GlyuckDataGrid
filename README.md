# GlyuckDataGrid
[![CI Status](http://img.shields.io/travis/glyuck/GlyuckDataGrid.svg?style=flat)](https://travis-ci.org/Glyuck/GlyuckDataGrid)
[![Version](https://img.shields.io/cocoapods/v/GlyuckDataGrid.svg?style=flat)](http://cocoapods.org/pods/GlyuckDataGrid)
[![Quality](https://apps.e-sites.nl/cocoapodsquality/GlyuckDataGrid/badge.svg?clear_cache)](https://cocoapods.org/pods/GlyuckDataGrid/quality)
[![License](https://img.shields.io/cocoapods/l/GlyuckDataGrid.svg?style=flat)](http://cocoapods.org/pods/GlyuckDataGrid)
[![Platform](https://img.shields.io/cocoapods/p/GlyuckDataGrid.svg?style=flat)](http://cocoapods.org/pods/GlyuckDataGrid)

The `GlyuckDataGrid` is a custom view intended to render multicolumn tables (aka data grids, spreadsheets). Uses `UICollectionView` with custom `UICollectionViewLayout` internally. 

![Screenshot](https://raw.githubusercontent.com/glyuck/GlyuckDataGrid/master/Example/screenshot_01.png) ![Screenshot](https://raw.githubusercontent.com/glyuck/GlyuckDataGrid/master/Example/screenshot_02.png)

## Usage

### Minimum working example

```swift
import UIKit
import GlyuckDataGrid


class MultiplicationTableViewController: UIViewController, DataGridViewDataSource {
    // You can create view outlet in a Storyboard
    @IBOutlet weak var dataGridView: DataGridView!

    override func viewDidLoad() {
        super.viewDidLoad()

        //// You can also create view manually
        // dataGridView = DataGridView(frame: view.bounds)
        // view.addSubview(dataGridView)
        //// You'll need to setup constraints for just created view
        // dataGridView.setTranslatesAutoresizingMaskIntoConstraints(false)
        // view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0.0-[dataGridView]-0.0-|", options: nil, metrics: nil, views: ["dataGridView": dataGridView]))
        // view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0.0-[dataGridView]-0.0-|", options: nil, metrics: nil, views: ["dataGridView": dataGridView]))

        // Don't forget to set dataSource and (optionally) delegate
        dataGridView.dataSource = self
        // dataGridView.delegate = self
    }

    // MARK: - DataGridViewDataSource

    // You'll need to tell number of columns in data grid view
    func numberOfColumnsInDataGridView(dataGridView: DataGridView) -> Int {
        return 9
    }

    // And number of rows
    func numberOfRowsInDataGridView(dataGridView: DataGridView) -> Int {
        return 9
    }

    // Then you'll need to provide titles for columns headers
    func dataGridView(dataGridView: DataGridView, titleForHeaderForRow row: Int) -> String {
        return String(row + 1)
    }

    // And rows headers
    func dataGridView(dataGridView: DataGridView, titleForHeaderForColumn column: Int) -> String {
        return String(column + 1)
    }

    // And for text for content cells
    func dataGridView(dataGridView: DataGridView, textForCellAtIndexPath indexPath: NSIndexPath) -> String {
        return String( (indexPath.dataGridRow + 1) * (indexPath.dataGridColumn + 1) )
    }
}
```

### CocoaPods

To run the example project, run `pod try`. If you manually clone the repo, and run `pod install` from the Example directory first. 

## Installation

GlyuckDataGrid is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "GlyuckDataGrid"
```

## Author

Vladimir Lyukov, v.lyukov@gmail.com

[glyuck.com](http://glyuck.com/)

## License

GlyuckDataGrid is available under the MIT license. See the LICENSE file for more info.
