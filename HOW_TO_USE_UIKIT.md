
## How to use with `UIKit`

*If you'd like to follow code instead of docs go to [Sample Code](https://github.com/amirdew/CollectionViewPagingLayout/blob/master/HOW_TO_USE_UIKIT.md#sample-code)*

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
layout.numberOfVisibleItems = nil // default=nil means it's equal to number of items in CollectionView
```

### Prepared Transformable Protocols

*If you'd like to build your custom effect, go to [Make custom effects](https://github.com/amirdew/CollectionViewPagingLayout/blob/master/HOW_TO_USE_UIKIT.md#make-custom-effects)*

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
  
If you want to replicate the same effects that you see in previews, use the `Layout` extension file.

`ScaleTransformView` -> [`ScaleTransformViewOptions`](https://github.com/amirdew/CollectionViewPagingLayout/blob/master/Lib/Scale/ScaleTransformViewOptions.swift) [`.Layout`](https://github.com/amirdew/CollectionViewPagingLayout/blob/master/Lib/Scale/ScaleTransformViewOptions%2BLayout.swift)     
`SnapshotTransformView` -> [`SnapshotTransformViewOptions`](https://github.com/amirdew/CollectionViewPagingLayout/blob/master/Lib/Snapshot/SnapshotTransformViewOptions.swift) [`.Layout`](https://github.com/amirdew/CollectionViewPagingLayout/blob/master/Lib/Snapshot/SnapshotTransformViewOptions%2BLayout.swift)    
`StackTransformView` -> [`StackTransformViewOptions`](https://github.com/amirdew/CollectionViewPagingLayout/blob/master/Lib/Stack/StackTransformViewOptions.swift)     [`.Layout`](https://github.com/amirdew/CollectionViewPagingLayout/blob/master/Lib/Stack/StackTransformViewOptions%2BLayout.swift)  

#### Target View
All the effects apply to one subview of your cell. that is the target view.    
By default, target view is the first subview of `cell.contentView`. (Override it If that's not what you want)  
The contentView size will always be equal to the UICollectionView size. So, It's important to consider the padding inside your cell.    
For instance, if you want to show 20 percent of the next and the previous page, your target view width should be 60 percent of `cell.contentView`.    

Target View named as below:

`ScaleTransformView` -> [`scalableView`](https://github.com/amirdew/CollectionViewPagingLayout/blob/master/Lib/Scale/ScaleTransformView.swift#L18)  
`SnapshotTransformView` -> [`targetView`](https://github.com/amirdew/CollectionViewPagingLayout/blob/master/Lib/Snapshot/SnapshotTransformView.swift#L17)  
`StackTransformView` -> [`cardView`](https://github.com/amirdew/CollectionViewPagingLayout/blob/master/Lib/Stack/StackTransformView.swift#L18)            



### Customize or Combine Prepared Transformables

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


## Make custom effects.

Conform your cell class to `TransformableView` and start implementing your custom transforms.   
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
> When it's `0` that means the current position of the cell is exactly in the center of your CollectionView.   
> the value could be negative or positive and that represents the distance to the center of your CollectionView.   
> for instance `1` means the distance between the center of the cell and the center of your collection view is equal to your CollectionView width.


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

## Features

### Control current page

You can control the current page by the following functions of `CollectionViewPagingLayout`:
- [`func setCurrentPage(Int)`](https://github.com/amirdew/CollectionViewPagingLayout/blob/master/Lib/CollectionViewPagingLayout.swift#L101)
- [`func goToNextPage()`](https://github.com/amirdew/CollectionViewPagingLayout/blob/master/Lib/CollectionViewPagingLayout.swift#L107)
- [`func goToPreviousPage()`](https://github.com/amirdew/CollectionViewPagingLayout/blob/master/Lib/CollectionViewPagingLayout.swift#L113)       

These are safe wrappers around setting the `ContentOffset` of `UICollectionview`.        
You can get the current page by a public variable: `CollectionViewPagingLayout.currentPage`.    
Listen to the changes using [`CollectionViewPagingLayout.delegate`](https://github.com/amirdew/CollectionViewPagingLayout/blob/master/Lib/CollectionViewPagingLayout.swift#L11):      
```swift
public protocol CollectionViewPagingLayoutDelegate: class {
    func onCurrentPageChanged(layout: CollectionViewPagingLayout, currentPage: Int)
}
```

### ViewAnimator

A custom animator that you can use to animate `ContentOffset`. 

[`DefaultViewAnimator`](https://github.com/amirdew/CollectionViewPagingLayout/blob/master/Lib/ViewAnimator.swift#L29) allows you to specify animation duration and curve function.   

You can implement your custom animator too!.

You can specify a default animator `CollectionViewPagingLayout.defaultAnimator` which will be used for all animations unless you specify animator per animation:   
`setCurrentPage(_ page: Int, animated: Bool, animator: ViewAnimator?)`,



## Sample Code

UIViewController:

```swift
import UIKit
import CollectionViewPagingLayout

// A simple View Controller that filled with a UICollectionView
// You can use `UICollectionViewController` too
class ViewController: UIViewController, UICollectionViewDataSource {
    
    var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    private func setupCollectionView() {
        let layout = CollectionViewPagingLayout()
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.register(MyCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.dataSource = self
        view.addSubview(collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    }
    
}
```

UICollectionViewCell:

```swift
class MyCell: UICollectionViewCell {
    
    // The card view that we apply transforms on
    var card: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        // Adjust the card view frame
        // you can use Auto-layout too
        let cardFrame = CGRect(
 		   x: 80,
 		   y: 100,
 		   width: frame.width - 160,
 		   height: frame.height - 200
        )
        card = UIView(frame: cardFrame)
        card.backgroundColor = .systemOrange
        contentView.addSubview(card)
    }
}

```

`MyCell` implementing a [scale effect](https://github.com/amirdew/CollectionViewPagingLayout/blob/master/HOW_TO_USE_UIKIT.md#prepared-transformable-protocols):

```swift
extension CardCollectionViewCell: ScaleTransformView {
    var scaleOptions: ScaleTransformViewOptions {
        .layout(.linear)
    }
}
```

`MyCell` implementing a [custom effect]((https://github.com/amirdew/CollectionViewPagingLayout/blob/master/HOW_TO_USE_UIKIT.md#make-custom-effects)):

```swift
extension CardCollectionViewCell: TransformableView {
    func transform(progress: CGFloat) {
        let alpha = 1 - abs(progress)
        contentView.alpha = alpha
    }
}
```
