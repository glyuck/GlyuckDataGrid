Pod::Spec.new do |s|
  s.name             = "GlyuckDataGrid"
  s.version          = "0.3.0"
  s.summary          = "An UICollectionView subclass specialized on displaying multicolumn tables or spreadsheets."
  s.homepage         = "https://github.com/glyuck/GlyuckDataGrid"
  s.screenshots      = "https://raw.githubusercontent.com/glyuck/GlyuckDataGrid/master/Example/screenshot_01.png", "https://raw.githubusercontent.com/glyuck/GlyuckDataGrid/master/Example/screenshot_02.png"
  s.license          = "MIT"
  s.author           = { "Vladimir Lyukov" => "v.lyukov@gmail.com" }
  s.source           = { :git => "https://github.com/Glyuck/GlyuckDataGrid.git", :tag => s.version.to_s }

  s.platform     = :ios, "8.0"
  s.requires_arc = true

  s.source_files = "Source/**/*"

  s.public_header_files = "Source/**/*.h"
  s.frameworks = "UIKit"
end
