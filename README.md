MPColorTools
============

A collection of tool for handling colors on iOS SDK.

This tool will add a couple of handy macros for creating colors on the fly, and will also add the capability of working with HSL values instead of just RGB and HSV/HSB.

Since it is more frequent to work with color values in the RGB `(0,255)` range, 
this tool will add a couple of macros that will ease your work of defining colors with 
'natural' values instead of forcing you to convert those values in the `(0.0, 1.0)` range.


Installation
------------

### Manually

Just add to your project the two main files:
  1. MPColorTools.h
  2. MPColorTools.m

### Using [CocoaPods][cocoapods]

[cocoapods]: http://cocoapods.org/

Just add the following line to the `Podfile` in your project:

```ruby
pod "MPColorTools"
```

Usage
-----

### Short-hand macros

You will be able to create colors using RBG values in the (0,255) range:

```objc
UIColor *myColor = MP_RGB(100, 120, 200);
```

And will be able to create them even with a custom alpha value:

```objc
UIColor *myTransparentColor = MP_RGBA(100, 120, 200, 0.2);
```

In case you need to create a gray-scale color, there are a couple of macros for that too:

```objc
UIColor *myGrayColor = MP_GRAY(128);
UIColor *myGrayTransparentColor = MP_GRAYA(128, 0.2);
```

### Hue/Saturation/Lightness (HSL) support

Since the lack of HSL values support in the iOS SDK, a couple of handy functions have been added:

```objc
UIColor *hslColor = [UIColor colorWithHue:0.1 saturation:0.4 lightness:0.6 alpha:1];
```

or shortly:

```objc
UIColor *hslColor = MP_HSL(0.1, 0.4, 0.6);
```

### Lighten and darken colors

You can lighten and darken colors directly using `UIColor`. These two functions will increase or decrease 
lightness by a given percentage:

```objc
UIColor *lighterColor = [myColor colorLightenedBy:0.1];
UIColor *darkerColor = [myColor colorDarkenedBy:0.1];
```

If you want to add or subtract a custom value to the lightness parameter, you can use the following function:

```objc
UIColor *lighterColor = [myColor colorByAddingLightness:0.5];
```

And if you want to generate a new color from the one you already have with a custom lightness values,
ignoring the current one, you can use the following function:


```objc
UIColor *lighterColor = [myColor colorWithLighness:0.7];
UIColor *lighterTransparentColor = [myColor colorWithLighness:0.7 alpha:0.2];
```