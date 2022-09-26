Pod::Spec.new do |s|
  s.name = "CollectionViewPagingLayout"
  s.version = "1.1.0"
  s.summary = "A simple but highly customizable layout for UICollectionView and SwiftUI."

  s.description = <<-DESC
                        A simple but highly customizable UICollectionViewLayout for UICollectionView.
                        Simple SwiftUI views that let you make page-view effects.
                       DESC

  s.homepage = "https://github.com/amirdew/CollectionViewPagingLayout"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = { "Amir Khorsandi" => "khorsandi@me.com" }
  s.source = { :git => "https://github.com/amirdew/CollectionViewPagingLayout.git", :tag => "#{s.version}" }
  
  s.ios.deployment_target = '12.0'
  s.swift_versions = ["5.5"]
  s.default_subspecs = 'UIKit'
  
  s.subspec "UIKit" do |ss|
    ss.source_files = ["Lib/**/*.swift"]
    ss.exclude_files = ["Lib/SwiftUI"]
    ss.frameworks = "UIKit"
  end
  
  s.subspec "Full" do |ss|
    ss.ios.deployment_target = '13.0'
    ss.source_files = ["Lib/**/*.swift"]
    #ss.frameworks = "UIKit" # If only SwiftUI, UIKit is unnecessary
    ss.weak_frameworks = "SwiftUI", "Combine"
  end
  
end
