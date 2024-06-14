
# AnyCaster

AnyCaster is a versatile Swift library that simplifies type casting of `Any` values. It provides a suite of tools to safely cast values to desired types, with additional capabilities for handling dictionaries and arrays. The library ensures type safety by throwing appropriate errors when casts fail, making it a reliable choice for dynamic type handling in Swift projects.

## Features

- Safe casting of `Any` values to desired types.
- Utility classes for handling dictionaries and arrays.
- Comprehensive error handling for failed casts.
- Support for custom mapping functions.

## Installation

### CocoaPods

Add the following line to your `Podfile`:

```ruby
pod 'AnyCaster'
```

Then, run:

```sh
pod install
```

### Swift Package Manager

Add the following dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/roman-okdi/AnyCaster.git", from: "1.0.0")
]
```

## Usage

### Deeply Nested Dictionary Casting

Using AnyCaster:
```swift
import AnyCaster

let nestedDict: [AnyHashable: Any] = [
    "level1": [
        "level2": [
            0,
            "targetValue",
            1
        ]
    ]
]
let caster = try AnyCaster(nestedDict).toDictionary()
// or
let caster = try AnyDictionaryCaster(nestedDict)

let targetValue = try caster.get("level1")
            .toDictionary()
            .get("level2")
            .toArray()
            .get(1)
            .cast(to: String.self)

print(targetValue) // Output: targetValue
```

Without AnyCaster:
```swift
let nestedDict: [AnyHashable: Any] = [
    "level1": [
        "level2": [
            0,
            "targetValue",
            1
        ]
    ]
]

if let level1 = nestedDict["level1"] as? [AnyHashable: Any],
   let level2 = level1["level2"] as? [Any],
   level2.count >= 2,
   let targetValue = level2[1] as? String {
    print(targetValue) // Output: targetValue
} else {
    print("Failed to cast value")
}
```

### Basic Casting

```swift
import AnyCaster

let anyValue: Any = "Hello, World!"
let caster = AnyCaster(anyValue)
let stringValue: String = try caster.cast()
// or
let stringValue = try caster.cast(String.self)
print(stringValue) // Output: Hello, World!
```

### Custom Mapping

```swift
let mappedValue: Int = try caster.cast(map: { (value: String) in
    return value.count
})
print(mappedValue) // Output: 13
```

### Dictionary Casting

```swift
let anyDict: [AnyHashable: Any] = ["key1": 1, "key2": "value"]
let dictCaster = try AnyCaster(anyDict).toDictionary()

let intValue: Int = try dictCaster.get("key1").cast()
let stringValue: String = try dictCaster.get("key2").cast()
print(intValue) // Output: 1
print(stringValue) // Output: value
```

### Array Casting

```swift
let anyArray: [Any] = [1, "value"]
let arrayCaster = try AnyCaster(anyArray).toArray()

let intValue: Int = try arrayCaster.get(0).cast()
let stringValue: String = try arrayCaster.get(1).cast()
print(intValue) // Output: 1
print(stringValue) // Output: value
```

## License

AnyCaster is licensed under the MIT License. See the [LICENSE](LICENSE) file for more information.

## Contributing

Contributions are welcome! Please open an issue or submit a pull request for any changes.

## Author

Roman Imanaliev - [newmailri@gmail.com](mailto:newmailri@gmail.com)
