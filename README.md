# BlockParty

[![BuddyBuild](https://dashboard.buddybuild.com/api/statusImage?appID=562a8a646f3b010100cc3648&branch=master&build=latest)](https://dashboard.buddybuild.com/apps/562a8a646f3b010100cc3648/build/latest)

Content Blocker App for iOS 9 and OS X

![Screen1](Screenshot01.png)
![Screen2](Screenshot02.png)
![Screen3](Screenshot03.png)

- Currently blocks content from annoying ad networks thereby loading pages super fast

- Useful for data-capped, international roaming connections

- Blocking rules are at [RediffBlock/blockerList.json](RediffBlock/blockerList.json)

- View JSON in app

## How to Install 

You need Xcode 7 or later. And an iOS device running atleast iOS 9. 

Step 1

```bash
git clone https://github.com/krishkumar/BlockParty.git
```

Step 2

```bash
  cd BlockParty
```
  
Step 3

Open `BlockParty.xcodeproj` in Xcode.

  
Step 4

Build and run the application. 

- When running this application on a device you will need to add a signing profile in the project's Build Settings.


Step 5

Allow `BlockParty` in Content Blockers under Settings → Safari.


## Tested

- iPad mini 2 running iOS 9
- iPhone 6 running iOS 9
- Desktop version tested on Safari 9 for Yosemite & El Capitan
- Universal app contains link to Settings, JSON and instructions for turning on Content Blockers

## Device Compatibility

[“Note: Apps containing content blocking extensions for Safari on iOS are available only on 64-bit devices, due to performance limitations of 32-bit devices.”](https://developer.apple.com/library/prerelease/ios/releasenotes/General/WhatsNewInSafari/Articles/Safari_9.html)

The exceptions to this are iPhone 5 and iPhone 5C which have been tested to be working with BlockParty.

## References

* A step-by-step guide: [installing BlockParty on a device with iOS 9 beta installed](https://medium.com/@searls/installing-a-content-blocker-on-ios-9-public-beta-a25b2b83848f)
* Instructions to install desktop version: [How to Use BlockParty for Desktop Safari](https://github.com/krishkumar/BlockParty/blob/master/BlockParty%20-%20Desktop%20Safari/How%20to%20Install.md)
* WWDC 2015 Session 511: [Safari Extensibility: Content Blocking and Shared Links](https://developer.apple.com/videos/wwdc/2015/?id=511)
* Introduction to WebKit Content Blockers: [Introduction & JSON Syntax](https://www.webkit.org/blog/3476/content-blockers-first-look/)
