
Pod::Spec.new do |s|
  s.name             = "CollectionViewPagingLayout"
  s.version          = "1.0.0"
  s.summary          = "A simple but highly customizable layout for UICollectionView and SwiftUI."
 
  s.description      = <<-DESC
                        A simple but highly customizable layout for UICollectionView and SwiftUI.
                       DESC

  s.homepage         = "https://github.com/amirdew/CollectionViewPagingLayout"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "Amir Khorsandi" => "khorsandi@me.com" }
  s.source           = { :git => "https://github.com/amirdew/CollectionViewPagingLayout.git", :tag => "#{s.version}" } 

  s.swift_versions = ["5.4"]
  s.ios.deployment_target = "9.0"

  s.source_files = "Lib/**/*.swift"

end
