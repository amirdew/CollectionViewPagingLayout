# CollectionViewPagingLayout

[![Version](https://img.shields.io/cocoapods/v/CollectionViewPagingLayout.svg?style=flat)](http://cocoapods.org/pods/CollectionViewPagingLayout)
[![License](https://img.shields.io/cocoapods/l/CollectionViewPagingLayout.svg?style=flat)](http://cocoapods.org/pods/CollectionViewPagingLayout)
[![Platform](https://img.shields.io/cocoapods/p/CollectionViewPagingLayout.svg?style=flat)](http://cocoapods.org/pods/CollectionViewPagingLayout)

## Preview

<img width="375" src="https://amir.app/CollectionViewPagingLayout/preview.gif"></img>


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


## Limitations
You need to specify the number of visible cells since this layout gives you the flexibility to show the next and previous cells.   
By default, the layout loads all of the cells in the collection view frame and that means it keeps all of them in memory.
You can specify the number of cells that you need to show at the time by considering your design.


## License

CollectionViewPagingLayout is available under the MIT license. See LICENSE file for more info.
