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
  s.version          = "1.2.0"
  s.summary          = "A simplified datasource for UITableView."
  s.description      = <<-DESC
                        This is a simplified datasource for UITableView, which avoids most of the datasource code to remain in the View/ViewController code.
                        This code allows to:

                       * Create simple tableViews with one cell type, one section.
                       * Create more complex tableView with different sections, cell types, configurations, etc.
                       * Add simple header/footer per section.
                       * Also register cell NIBs at the tableView.
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

  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
end
