# ShimmerEffect-iOS

![CI Status](https://img.shields.io/travis/AhmedOsman00/ShimmerEffect-iOS.svg?style=flat)
[![Version](https://img.shields.io/cocoapods/v/ShimmerEffect-iOS.svg?style=flat)](https://cocoapods.org/pods/ShimmerEffect-iOS)
![License](https://img.shields.io/cocoapods/l/ShimmerEffect-iOS.svg?style=flat)
![Platform](https://img.shields.io/cocoapods/p/ShimmerEffect-iOS.svg?style=flat)

ShimmerEffect-iOS is a lightweight, easy-to-use library for adding a shimmering effect to your iOS views. Perfect for placeholders, loading states, or simply adding a bit of sparkle to your app.

## Getting Started

### Installation

ShimmerEffect-iOS is available via CocoaPods. To integrate it into your Xcode project, add the following line to your Podfile:

```ruby
pod 'ShimmerEffect-iOS'
```

Then, run `pod install` in your project directory.

### Example Project

To see ShimmerEffect-iOS in action, clone this repo and run `pod install` from the Example directory. This will set up the example project for you to explore.

    Shimmer Effect in Action

    ![](https://raw.githubusercontent.com/AhmedOsman00/ShimmerEffect-iOS/main/assets/shimmer.gif)

## Features

ShimmerEffect-iOS supports all UIView subclasses, including:

- UILabel
- UITextField
- UITextView
- UITableView
- UICollectionView
- UIImageView
- ...and more

## How to Use

### Basic Usage

1. **Import ShimmerEffect-iOS** in your Swift file:

   ```swift
   import ShimmerEffect_iOS
   ```

2. **Enable the shimmering effect** on your UIView or its subclasses:

   From code:

   ```swift
   view.isShimmering = true
   ```

   From storyboard:

   ![](https://raw.githubusercontent.com/AhmedOsman00/ShimmerEffect-iOS/main/assets/enable.png)

3. **Activate the shimmer effect**:

   ```swift
   view.showShimmerEffect()
   ```

### Advanced Usage

#### UICollectionView

To incorporate a shimmer effect into UICollectionView cells, you should adhere to the `UICollectionViewShimmerDataSource` protocol. Utilize the `shimmerCollectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)` method to provide a custom cell specifically designed for the shimmer effect. Additionally, you can define the number of items per section and the total number of sections to be displayed during the shimmer effect by implementing the following methods:

```swift
func shimmerCollectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
func numberOfShimmerSections(in collectionView: UICollectionView) -> Int
```

These methods allow you to customize the appearance and repetition of the shimmer effect across different sections of your collection view.

Alternatively, you can leverage the existing `UICollectionViewDataSource` methods to manage the shimmer effect, ensuring that the shimmer cells, the number of cells, and the number of sections remain consistent with your original collection view setup. This approach allows for a seamless integration of the shimmer effect, mirroring the structure and content of your collection view without requiring additional customization.

#### UITableView

For integrating a shimmer effect into UITableView cells, adopt the `UITableViewShimmerDataSource` protocol in a similar manner:

```swift
func shimmerTableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
func shimmerTableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
func numberOfShimmerSections(in tableView: UITableView) -> Int
```

Use these methods to provide custom cells for the shimmer effect, and to determine the number of rows and sections required for the shimmer. This approach allows for a consistent application of the shimmer effect, aligning with the existing structure of your table view.

Optionally, you can utilize the existing `UITableViewDataSource` methods for a seamless transition to the shimmer effect, ensuring that the layout and content of your table view remain unchanged while the shimmer is active.

## Contribution

Contributions are welcome! If you'd like to improve ShimmerEffect-iOS, please feel free to fork, make changes, and submit a pull request.

## Author

Ahmed Osman | eng.ahmedosman00@gmail.com

## License

ShimmerEffect-iOS is released under the MIT license. For more information, see the LICENSE file in this repository.
