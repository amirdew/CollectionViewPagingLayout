
## How to use with `SwiftUI`

*If you'd like to follow code instead of docs go to [Sample Code](https://github.com/amirdew/CollectionViewPagingLayout/blob/master/HOW_TO_USE_SWIFTUI.md#sample-code)*


- First, make sure you imported the framework
```swift
import CollectionViewPagingLayout
```

### Prepared Page views

There are three prepared page views to make it easier to use this framework.                     
- `ScalePageView` (orange previews) 
- `SnapshotPageView` (green previews)
- `StackPageView` (blue previews)   
  
These views are highly customizable, you can make tons of different effects using them.        
Here is a simple example for `StackPageView`:

```swift
    var body: some View {
        StackPageView(items) { item in
            // Build your view here
            ZStack {
                Rectangle().fill(Color.orange)
                Text("\(item.number)")
            }
        }
        .pagePadding(.absolute(50))
        .options(.init(
            scaleFactor: 0.12,
            maxStackSize: 4,
            popAngle: .pi / 10,
            popOffsetRatio: .init(width: -1.45, height: 0.3),
            stackPosition: .init(x: 1.5, y: 0)
        ))
    }
```
There is an "options" property for each of these page views where you can customize the effect, check the struct to find out what each parameter does.        


### TransformPageView

You can build your custom effects using this view.

```swift
    var body: some View {
        TransformPageView(items) { item, progress in
            // Build your view here
            ZStack {
                Rectangle().fill(Color.orange)
                Text("\(item.number)")
            }
            // Apply transform here
            .transformEffect(.init(translationX: progress * 200, y: 0))
        }
        // The padding around each page
        // you can use `.fractionalWidth` and
        // `.fractionalHeight` too
        .pagePadding(
            vertical: .absolute(100),
            horizontal: .absolute(80)
        )
    }

```   
As you see above, you get a `progress` value. Use that to apply any effect you want.  

> `progress` is a float value that represents the current position of the page view.   
> When it's `0` that means the page position is exactly in the center of TransformPageView.   
> The value could be negative or positive and that represents the distance to the center of your TransformPageView.   
> for instance `1` means the distance between the center of the page and the center of TransformPageView is equal to your TransformPageView width.

in above example we `translationX: progress * 200` meaning current page will be in the center (translationX = 0), the page before current page will be -200 pixels behind and so on ...

### Selection

You can pass a binding value when you initialize your page view along with `items`:   
`selection: Binding<ValueType.ID?>`

This is a two-way binding selection, which means you can change it to animate the page to the selected page, and the value gets changed when the user navigates between pages.

  
## Modifiers
### - `.pagePadding`
By default, the content view size will be equal to the parent view, you can use this modifier to add padding around pages. Padding can be `absolute`, `fractionalHeight` or `fractionalWidth`:
```swift
 enum Padding {
        /// Creates a padding with an absolute point value.
        case absolute(CGFloat)

        /// Creates a padding that is computed as a fraction of the height of the container view.
        case fractionalHeight(CGFloat)

        /// Creates a padding that is computed as a fraction of the width of the container view.
        case fractionalWidth(CGFloat)
    }
``` 

You can use one of these or combine them:
```swift
pagePadding(_ padding: )
pagePadding(vertical: horizontal: )
pagePadding(top: left: bottom: right:)
```


### - `.numberOfVisibleItems`
By default, all of the pages get load immediately.   
If you have lots of pages and you want to have lazy loading, use this modifier.

```swift
numberOfVisibleItems(_ count: Int)
```


### - `.zPosition`
Use this modifier to provide zPosition(zIndex) for each page.   
The default value: `Int(-abs(round(progress)))`

```swift 
zPosition(_ zPosition: (progress: CGFloat) -> Int)
```

### - `.onTapPage`
*Note: in most cases you want to use `selection: Binding<ValueType.ID?>` instead of this modifer.*

As the name says this modifier can be used to handle tap on page.   
This is equivalent for `collectionView(_ collectionView:, didSelectItemAt indexPath:)`

```swift 
onTapPage(_ closure: (ValueType.ID) -> Void)
```

### - `.animator`
Use this modifer to define your animator.   
[`DefaultViewAnimator`](https://github.com/amirdew/CollectionViewPagingLayout/blob/master/Lib/ViewAnimator.swift#L29) allows you to specify animation duration and curve function. 

You can implement your custom animator too!.

```swift 
animator(_ animator: ViewAnimator)
```

### - `.scrollToSelectedPage`
if this is enabled page view automaticly scrolls to the selected page.     
default value: `true`

```swift
scrollToSelectedPage(_ goToSelectedPage: Bool)
```

### - `.scrollDirection`
Use to specify the scroll direction `.vertical` or `.horizontal`


### - `.collectionView`
Using this modifier, you can set value for the underlying UICollectionView's properties

for instance, if you want to show vertical scroll indicators:   
`.collectionView(\.showsVerticalScrollIndicator, true)`


```swift
collectionView<T>(_ key: WritableKeyPath<UICollectionView, T>, _ value: T)
```



## Sample Code

`ContentView` implementing a scale effect:

```swift
import SwiftUI
import CollectionViewPagingLayout

struct ContentView: View {

    // Replace with your data
    struct Item: Identifiable {
        let id: UUID = .init()
        let number: Int
    }
    let items = Array(0..<10).map {
        Item(number: $0)
    }

    // Use the options to customize the layout
    var options: ScaleTransformViewOptions {
        .layout(.linear)
    }

    var body: some View {
        ScalePageView(items) { item in
            // Build your view here
            ZStack {
                Rectangle().fill(Color.orange)
                Text("\(item.number)")
            }
        }
        .options(options)
        // The padding around each page
        // you can use `.fractionalWidth` and
        // `.fractionalHeight` too
        .pagePadding(
            vertical: .absolute(100),
            horizontal: .absolute(80)
        )
    }

}
```

`ContentView` implementing a custom effect:


```swift
struct ContentView: View {

    // Replace with your data
    struct Item: Identifiable {
        let id: UUID = .init()
        let number: Int
    }
    let items = Array(0..<10).map {
        Item(number: $0)
    }

    var body: some View {
        TransformPageView(items) { item, progress in
            // Build your view here
            ZStack {
                Rectangle().fill(Color.orange)
                Text("\(item.number)")
            }
            // Apply transform and other effects
            .scaleEffect(1 - abs(progress) * 0.6)
            .transformEffect(.init(translationX: progress * 200, y: 0))
            .blur(radius: abs(progress) * 20)
            .opacity(1.8 - Double(abs(progress)))
        }
        // The padding around each page
        // you can use `.fractionalWidth` and
        // `.fractionalHeight` too
        .pagePadding(
            vertical: .absolute(100),
            horizontal: .absolute(80)
        )
    }

}
```