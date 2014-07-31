![MPColorTools logo small](https://raw.githubusercontent.com/marzapower/MPColorTools/master/assets/MPColorTools_small.png) MPColorTools
============

[![Version](http://cocoapod-badges.herokuapp.com/v/MPColorTools/badge.png)](http://cocoadocs.org/docsets/MPColorTools)
[![Platform](http://cocoapod-badges.herokuapp.com/p/MPColorTools/badge.png)](http://cocoadocs.org/docsets/MPColorTools)

<p align="center">
  <img src="https://raw.githubusercontent.com/marzapower/MPColorTools/master/assets/MPColorTools.png" alt="MPColorTools"/>
</p>

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

You will be able to create colors using RGB values in the (0,255) range:

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

### Hex values support

Like in CSS script files, you can create color starting from string hex values. Values can be defined in these formats:
  1. RGB
  2. RGBA
  3. RRGGBB
  4. RRGGBBAA
  
I.e you can create color like this:

```objc
UIColor *myHexColor = MP_HEX_RGB(@"FCE");   // Will be the equivalent of using @"FFCCEEFF"
UIColor *myHexFullColor = MP_HEX_RGB(@"AAB678CC");
```

If you are using pure integer values for handling colors, you can use this other approach:

```objc
UIColor *myHexIntColor = [UIColor colorWithRGB:0xff443c];
UIColor *myHexIntShortColor = MP_HEX_INT(0xff443c);
UIColor *myHexIntShortTransparentColor = MP_HEX_INTA(0xff443c, 0.2);
```

#### Getters
You can retrieve the hexadecimal representation of the color using these two methods:

```objc
NSUInteger myHexValue = [myColor hexValue];
NSString *myHexString = [myColor hexString];
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

### CMYK support

The iOS SDK also lacks for the CMYK color space. This tool will make it possibile to create colors in the CMYK color space
and also to get CMYK values from existing colors:

```objc
UIColor *cmykColor = [UIColor colorWithCyan:0.3 magenta:0.9 yellow:1.0 keyBlack:0.1];
UIColor *cmykShortColor = MP_CMYK(0.3,0.9,1.0,0.1);
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

### Color schemes

You can compute complementary, triadic, square, analogous and split-complementary colors starting from one reference color.

More generally, you can offset a color on the color wheel by adding an angle expressed as an integer in the `(-360,360)` range. This is accomplished via this method:

```objc
UIColor *offsetColor = [myColor colorByAddingAngle:125];
```

The rotation is counter-clockwise if the added angle is positive, clockwise if it is negative.

__Examples:__

__+30°__

![Adding 30 degrees](https://raw.githubusercontent.com/marzapower/MPColorTools/master/assets/30plus.png)

__+60°__

![Adding 60 degrees](https://raw.githubusercontent.com/marzapower/MPColorTools/master/assets/60plus.png)

__-120°__

![Removing 120 degrees](https://raw.githubusercontent.com/marzapower/MPColorTools/master/assets/120minus.png)


The following methods all use this one to compute these common color schemes.

#### Complementary color

![Complementary colors](https://raw.githubusercontent.com/marzapower/MPColorTools/master/assets/opposite.png)

Returns the complementary color.

```objc
UIColor *complementary = [myColor complementaryColor];
```

#### Triadic colors

![Triadic colors](https://raw.githubusercontent.com/marzapower/MPColorTools/master/assets/triadic.png)

The `triadicColors` method will return an array of three colors, equally spaces by 120° on the color wheel, the middle one being `myColor`.

```objc
NSArray *triadic = [myColor triadicColors];
```

#### Square colors

![Square colors](https://raw.githubusercontent.com/marzapower/MPColorTools/master/assets/square.png)


With `squareColors` you will get an array of four equally spaced colors (with a 90° offset between each other), the first being the reference one.

```objc
NSArray *square = [myColor squareColors];
```

#### Split-complementary colors

![Split-complementary colors](https://raw.githubusercontent.com/marzapower/MPColorTools/master/assets/split.png)

The split-complementary colors are an array of three colors, with the middle one being the reference color, and the other two are the colors with +/- 150° offset from that. If the reference color is a primary color, the split-complementary colors will include the nearest secondary colors near its complementary color.

```objc
NSArray *splitComplementary = [myColor splitComplementaryColors];
```

#### Analogous colors

![Analogous colors](https://raw.githubusercontent.com/marzapower/MPColorTools/master/assets/analogous.png)

Analogous colors will return an array of five colors (the middle one being the reference color), equally spaced among them by a given angle. Usually you should keep this angle low (eg. 20-30°) to get an array of analogous colors that are close to each other on the color wheel.

```objc
NSArray *analogous = [myColor analogousColorsWithAngle:30];
```

### Getters and "setters"

It is fairly difficult to gather a single color space value for a `UIColor` instance. Now you can easily access any value you want
with simple getters:

```objc
UIColor *myColor = MP_RGB(125,125,90);
CGFloat red = myColor.red;
CGFloat light = myColor.lightness;
...
```

`UIColor` are immutable objects, so it's not possible to change color space values on-the-fly. This tool just creates a set of quick
instance methods to duplicate color and change a single color space value on them. It's just as simple as using a setter, with the
only difference that you will create a separate object with the new values:

```objc
UIColor *myColor = MP_GRAY(64);
UIColor *darkRedColor = [myColor colorWithRed:1];
```

Notice that these "setter" methods will accept values in the `[0,1]` range like all the other `UIColor` methods do.

## Copyright

Copyright [2013-2014] Daniele Di Bernardo
                        
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
  
   http://www.apache.org/licenses/LICENSE-2.0
  
Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
