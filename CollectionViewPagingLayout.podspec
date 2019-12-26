
Pod::Spec.new do |s|
  s.name             = 'CollectionViewPagingLayout'
  s.version          = '0.0.1'
  s.summary          = 'Simple layout for making pagings with UICollectionView.'
 
  s.description      = <<-DESC
                          a custom UICollectionViewLayout for making a paging effect with custom transforms
                       DESC

  s.homepage         = 'https://github.com/amirdew/CollectionViewPagingLayout'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Amir Khorsandi' => 'khorsandi@me.com' }
  s.source           = { :git => 'https://github.com/amirdew/CollectionViewPagingLayout.git', :tag => s.version.to_s } 

  s.ios.deployment_target = '8.0'

  s.source_files = 'CollectionViewPagingLayout/Lib/**/*'

end
