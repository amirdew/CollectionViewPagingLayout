
## How to use with `UIKit`

- First, make sure you imported the framework
```swift
import CollectionViewPagingLayout
```
- Set up your `UICollectionView` as you always do (you need a custom class for cells)
- Set the layout for your collection view:
(in most cases you want a paging effect so enable that too)
```swift
let layout = CollectionViewPagingLayout()
collectionView.collectionViewLayout = layout
collectionView.isPagingEnabled = true // enabling paging effect
```

*Note:* Go to [Prepared Transformable Protocols](#prepared-transformable-protocols) if you want to use prepared effects! to make a custom effect contiune.   

- Now, you just need to conform your cell class to `TransformableView` and start implementing your custom transforms. 
for instance:
```swift
class YourCell: UICollectionViewCell { /*...*/ }
extension YourCell: TransformableView {
  func transform(progress: CGFloat) {
    // apply changes on any view of your cell
  }
}
```
As you see above, you get a `progress` value. Use that to apply any changes you want.  

> `progress` is a float value that represents the current position of your cell in the collection view.   
> When it's `0` that means the current position of the cell is exactly in the center of your collection view.   
> the value could be negative or positive and that represents the distance to the center of your collection view.   
> for instance `1` means the distance between the center of the cell and the center of your collection view is equal to your collection view width.


you can start with a simple transform like this:
```swift
extension YourCell: TransformableView {
    func transform(progress: CGFloat) {
        let transform = CGAffineTransform(translationX: bounds.width/2 * progress, y: 0)
        let alpha = 1 - abs(progress)

        contentView.subviews.forEach { $0.transform = transform }
        contentView.alpha = alpha
    }
}
```

- Don't forget to set `numberOfVisibleItems`, by default it's null and that means all of the cells will be loaded in the memory.  
```swift
layout.numberOfVisibleItems = ...
```

## Prepared Transformable Protocols

There are some prepared transformable protocols to make it easier to use this framework.             
Using them is simple. You only need to conform your `UICollectionViewCell` to the protocol.     
You can use the options property to tweak it as you want.         
There are three types:
- `ScaleTransformView` (orange previews) 
- `SnapshotTransformView` (green previews)
- `StackTransformView` (blue previews)     
These protocols are highly customizable, you can make tons of different effects using them.        
Here is a simple example for `ScaleTransformView` which gives you a simple paging with scaling effect:
```swift
extension YourCell: ScaleTransformView {
    var scaleOptions = ScaleTransformViewOptions(
        minScale: 0.6,
        scaleRatio: 0.4,
        translationRatio: CGPoint(x: 0.66, y: 0.2),
        maxTranslationRatio: CGPoint(x: 2, y: 0),
    )
}
```
There is an "options" property for each of these protocols where you can customize the effect, check the struct to find out what each parameter does.          
A short comment on the top of each parameter explains what that does.      
`ScaleTransformView` -> [`ScaleTransformViewOptions`](https://github.com/amirdew/CollectionViewPagingLayout/blob/master/Lib/Scale/ScaleTransformViewOptions.swift)     
`SnapshotTransformView` -> [`SnapshotTransformViewOptions`](https://github.com/amirdew/CollectionViewPagingLayout/blob/master/Lib/Snapshot/SnapshotTransformViewOptions.swift)     
`StackTransformView` -> [`StackTransformViewOptions`](https://github.com/amirdew/CollectionViewPagingLayout/blob/master/Lib/Stack/StackTransformViewOptions.swift)     
     
See the examples in the samples app.      
Check [here](https://github.com/amirdew/CollectionViewPagingLayout/tree/master/PagingLayoutSamples/Modules/Shapes/ShapeCell) to see used options for each: `/PagingLayoutSamples/Modules/Shapes/ShapeCell/`

#### Target view
You may wonder how does it find out the subview in your cell to apply transforms on.      
If you check the transformable protocols, you find the target view for each. like `ScaleTransformView.scalbleView`.      




The default value is the first subview of "contentView":
```swift
public extension ScaleTransformView where Self: UICollectionViewCell {
    
    /// Default `scalableView` for `UICollectionViewCell` is the first subview of
    /// `contentView` or the content view itself if there is no subview
    var scalableView: UIView {
        contentView.subviews.first ?? contentView
    }
}
```
If that's not what you want, you can implement it.


## Customize Prepared Transformables

Yes, you can customize them or even combine them.       
To do that, implement `TransformableView.transform` function and call the transformable function manually, like this:     
```swift
extension LayoutTypeCollectionViewCell: ScaleTransformView {
    
    func transform(progress: CGFloat) {
        applyScaleTransform(progress: progress)
        // customize views here, like this:
        titleLabel.alpha = 1 - abs(progress)
        subtitleLabel.alpha = titleLabel.alpha
    }

}
```
As you see, `applyScaleTransform` applies the scale transforms and right after that we change the alpha for `titleLabel` and `subtitleLabel`.        
To find the public function(s) of each protocol check the definition of that.      

## Features

### Control current page

You can control the current page by the following functions of `CollectionViewPagingLayout`:
- `func setCurrentPage(_ page: Int, animated: Bool = true)`
- `func goToNextPage(animated: Bool = true)`
- `func goToPreviousPage(animated: Bool = true)`       

These are safe wrappers around setting the `ContentOffset` of `UICollectionview`.        
You can get the current page by a public variable: `CollectionViewPagingLayout.currentPage`.    
Listen to the changes using `CollectionViewPagingLayout.delegate`:      
```swift
public protocol CollectionViewPagingLayoutDelegate: class {
    func onCurrentPageChanged(layout: CollectionViewPagingLayout, currentPage: Int)
}
```

