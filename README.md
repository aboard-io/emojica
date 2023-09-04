![emojica](https://raw.githubusercontent.com/xoudini/emojica/images/emojica.png)
=====

<sup>
Emojica – a Swift framework for using custom emoji in strings.
</sup>

![gif](https://raw.githubusercontent.com/xoudini/emojica/images/demo.gif)

## What does it do?

Emojica allows you to replace the standard emoji in your iOS apps with
twemojis. Works on `UILabel` and `UITextView`.

Just follow the instructions below, import your custom image set, and you're
ready to go.


## Features

- [x] Compatible with __all__ iOS 14 emoji
- [x] Convert input directly on [`textViewDidChange(_:)`](#directly-converting-text-input)
- [x] Revert converted strings to their original representation

<sup>
1. The original emoji are used as fallback.
</sup>


## Requirements

+ Xcode 11
+ iOS 13.0+
   * _Lower versions haven't been tested, although the framework may run without
      issues on a lower version._
+ Swift 5
   * _Using the framework in an Objective-C project may require some
      modifications to the source. Support for Objective-C will possibly be
      added at some point in the future._



## Installation

### [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)

1. Add the pod to your `Podfile`:

 ```ruby
 target '...' do
    pod 'Emojica', :git => 'https://github.com/aboard-io/emojica.git'
 end
 ```
2. Navigate into your project directory and install/update:

 ```sh
 $ cd /Path/To/Your/Project/ && pod install
 ```

### Manual installation

1. Clone the repository, and drag `Emojica.xcodeproj` into your project
    hierarchy in Xcode.
2. Select your project, then select your application's target under __Targets__.
3. Under the __General__ tab, click the __+__ under __Embedded Binaries__.
4. Select `Emojica.frameworkiOS` and finish by pressing __Add__.

 > If Xcode gives you a `No such module 'Emojica'` compiler error at your
 >`import` statement, just build your application (or the framework) once. Also,
 > each time you Clean (⇧⌘K) the project Xcode will give you the same error,
 > and the solution is the same.



## Usage

```swift
import Emojica
```

### Instantiation

```swift
let emojica = Emojica()

// Creates an instance with a font.
let emojica = Emojica(font: UIFont.systemFont(ofSize: 17.0))
```

### Configure instance

* __Set font__:

   ```swift
   emojica.font = UIFont.systemFont(ofSize: 17.0)
   ```

 If no font is set, the system font is used.


* __Set size__:

   ```swift
   emojica.pointSize = 17.0
   ```

 If you're satisfied with the default font, you can just set the size.
 The value for `pointSize` is 17.0 by default.


* __Enable emoji to be reverted__:

 > __NOTE__: Keep the instance non-revertible if the original strings aren't
 > needed after conversion.

   ```swift
   emojica.revertible = true
   ```

 Enables strings with custom emoji to be reverted to original state.


### Convert string

```swift
let sample: String = "Sample text 😎"

let converted: NSAttributedString = emojica.convert(string: sample)
```

### Revert string

> __NOTE__: The instance must have `revertible` set to `true`.

```swift
let reverted: String = emojica.revert(attributedString: converted)
```

### Using converted strings

```swift
let textView = UITextView()

...

let flag: String = "🇫🇮 "

textView.attributedText = emojica.convert(string: flag)
```

### Directly converting text input

You can directly convert text input by implementing the `UITextViewDelegate`
method `textViewDidChange(_:)` and passing the changed `UITextView` to the
Emojica method by the same name:

```swift
func textViewDidChange(_ textView: UITextView) {
    emojica.textViewDidChange(textView)
}
```


## Example Project

The example `EmojicaExample.xcodeproj` is set up but __does not contain
images__. To test the project, add your emoji images to the `Images` group and
__Run__.


## License

Emojica is released under the **Apache License 2.0**.
