# CollectionViewPagingLayout

[![Version](https://img.shields.io/cocoapods/v/CollectionViewPagingLayout.svg?style=flat)](http://cocoapods.org/pods/CollectionViewPagingLayout)
[![License](https://img.shields.io/cocoapods/l/CollectionViewPagingLayout.svg?style=flat)](http://cocoapods.org/pods/CollectionViewPagingLayout)
[![Platform](https://img.shields.io/cocoapods/p/CollectionViewPagingLayout.svg?style=flat)](http://cocoapods.org/pods/CollectionViewPagingLayout)

## Preview
<p float="left">
<img width="375" src="https://amir.app/git/flowlayout_preview.gif"></img>
<img width="375" src="https://amir.app/git/gallery_preview.gif"></img>
</p>
<img width="800" src="https://amir.app/git/card_stack_preview.gif"></img>

## About
A custom `UICollectionViewLayout` that gives you the ability to apply transforms easily on the cells   
by conforming your cell class to `TransformableView` protocol you will get a `progress` value and you can use it to change the cell view.  
You can see the usage by looking into the example source code.  
More examples will be added.

## Add to your project

#### Cocoapods
CollectionViewPagingLayout is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "CollectionViewPagingLayout"
```
#### Manually
Just add all the files under `Lib` directory to your project

## How to use
- make sure you imported the library if you use cocoapods
```swift
import CollectionViewPagingLayout
```
- Set the layout for collection view:
(in most cases you want a paging effect so make sure you enable it)
```swift
let layout = CollectionViewPagingLayout()
collectionView.collectionViewLayout = layout
collectionView.isPagingEnabled = true // enabling paging effect
```

- Here you can set `numberOfVisibleItems`, by default it's null and that means it will load all of the cells at a time   
```swift
layout.numberOfVisibleItems = ...
```
- Now you just need to conform your `UICollectionViewCell` class to `TransformableView` and start implementing your custom transforms
> `progress` is a float value that represents current position of the cell.   
> When it's `0` means the current position of the cell is exactly in the center of your collection view.   
> the value could be negative or positive and that represents the distance to the center of your collection view.   
> for instance `1` means the distance between the center of the cell and the center of your collection view is equal to your collection view width.

```swift
extension MyCollectionViewCell: TransformableView {
    func transform(progress: CGFloat) {
      ...
    }
}
```

you can start with a simple transform like this:
```swift
extension MyCollectionViewCell: TransformableView {
    func transform(progress: CGFloat) {
        let transform = CGAffineTransform(translationX: bounds.width/2 * progress, y: 0)
        let alpha = 1 - abs(progress)

        contentView.subviews.forEach { $0.transform = transform }
        contentView.alpha = alpha
    }
}
```


## Limitations
You need to specify the number of visible cells since this layout gives you the flexibility to show the next and previous cells.   
By default, the layout loads all of the cells in the collection view frame and that means it keeps all of them in memory.
You can specify the number of cells that you need to show at a time by considering your design.


## License

CollectionViewPagingLayout is available under the MIT license. See LICENSE file for more info.
