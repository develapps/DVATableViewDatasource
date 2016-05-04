#
# Be sure to run `pod lib lint DVATableViewDatasource.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "DVATableViewDatasource"
  s.version          = "2.0.0"
  s.summary          = "A simplified datasource for UITableView."
  s.description      = <<-DESC
                        This is a simplified datasource for UITableView, which avoids most of the datasource code to remain in the View/ViewController code.
                        This code allows to:

                       * Create simple tableViews with one cell type, one section.
                       * Create more complex tableView with different sections, cell types, configurations, etc.
                       * Add simple header/footer per section.
                       * Also register cell NIBs at the tableView.
                       * Add animation to modifications at the tableView

                        New 1.2.3
                        ---------
                       * Fixes noDataView

                        New 1.3.0
                        ---------
                       * Added a new NSDictionary+DVATableViewModelProtocol category that lets you implement the full viewModel as a plain NSDictionary by providing a "dva_cellIdentifier" key.
                       * Added categories to let you initialize a tableView from an NSArray or NSDictionary plist.

                        New 1.3.1
                        ---------
                        * Updated MagicalRecord to 2.3.

                        New 1.4.0
                        ---------
                        * Added editable table view

                        New 1.5.0
                        ---------
                        * Moved pods as subpods

                        New 1.5.1
                        ---------
                        * Fixes when passing no cells to de datasource array

                        New 1.5.2
                        ---------
                        * Fixed public headers.
                        New 2.0
                        ---------
                        * Removed arrayDataSource
                        * Fixed empty array should show noData view.


                       DESC
  s.homepage         = "http://www.develapps.es"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Rafa Barberá" => "rafa@develapps.es",
                         "Pablo Romeu" => "pablo.romeu@develapps.es" }
  s.source           = { :git => "https://bitbucket.com/dvalibs/DVATableViewDatasource.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/rbarbera'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'DVATableViewDatasource' => ['Pod/Assets/*.png']
  }

  s.frameworks = 'UIKit'

    s.public_header_files = 'Pod/Classes/*.h', 'Pod/Classes/Subclasses/*.h'
    s.source_files = 'Pod/Classes/*.{h,m}', 'Pod/Classes/Subclasses/*.{h,m}'

    s.frameworks = 'UIKit'

    s.subspec 'Protocols' do |ss|
        ss.source_files = 'Pod/Classes/Protocols/**/*.{h,m}'
    end
    s.subspec 'EditableDatasource' do |ss|
        ss.dependency 'DVATableViewDatasource/Protocols'
        ss.source_files = 'Pod/Classes/EditableDatasource/**/*.{h,m}'
    end


end
