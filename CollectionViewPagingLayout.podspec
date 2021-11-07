Pod::Spec.new do |s|
  s.name = "CollectionViewPagingLayout"
  s.version = "1.0.3"
  s.summary = "A simple but highly customizable layout for UICollectionView and SwiftUI."

  s.description = <<-DESC
                        A simple but highly customizable UICollectionViewLayout for UICollectionView.
                        Simple SwiftUI views that let you make page-view effects.
                       DESC

  s.homepage = "https://github.com/amirdew/CollectionViewPagingLayout"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = { "Amir Khorsandi" => "khorsandi@me.com" }
  s.source = { :git => "https://github.com/amirdew/CollectionViewPagingLayout.git", :tag => "#{s.version}" }
  s.source_files = ["Lib/**/*.swift"]

  s.swift_versions = ["5.4"]

  s.ios.deployment_target = "10.0"

  s.frameworks = "UIKit"
  s.weak_frameworks = "SwiftUI", "Combine"
end
