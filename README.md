# TouristHelper

## Libraries Used:
* GoogleMaps: For showing map
* AFNetworking: To perform http requests
* JSONModel: To map object from json data.
* Bolts: Async task management. Implementation of 'Promise'.
* KVOController: KVO helper.
* Masonry: Autolayout constraint framework.

## Optimal Path Algorithm:
This is actually a TSP problem. But since we are talking about more than 100 nodes than the basic TSP is going to be impractical. Hence, a simple greedy approach is taken (which sometimes may give a result far from best optimal but it serves the purpose for this demo.) The implementation is isolated in such a way that it can be easily replaced with more better one (like one of the variants of TSP).

## Setup:
[Cocoapods](http://cocoapods.org) needs to be installed first. Then after cloning, from the project directory run
```
pod install
```

## Running:
* make sure the bundle identifier is com.mush.Tourist. It's because that this bundle identifier is being used for Google Map Service.

## TODO:
* more unittest.
* caching layer for Services.
* allow user to filter POI types. now the list contains only 'food','bar' and 'museum'.
