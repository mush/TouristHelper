# TouristHelper

## Libraries Used:
* GoogleMaps: For showing map
* AFNetworking: To perform http requests
* JSONModel: To map object from json data.
* Bolts: Async task management. Implementation of 'Promise'.
* KVOController: KVO helper.
* Masonry: Autolayout constraint framework.

## Setup:
[Cocoapods](http://cocoapods.org) needs to installed first. Then after cloning, from the project directory run
```
pod install
```

## Running:
* make sure the bundle identifier is com.mush.Tourist. It's because that this bundle identifier is being used for Google Map Service.

## TODO:
* more unittest.
* caching layer for Services.
* allow user to filter POI types. now the list contains only 'food','bar' and 'museum'.
* create more animation for UIs
* make visually more aesthetic.
