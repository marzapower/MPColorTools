//
//  MPColorTools.m
//
//  Created by Daniele Di Bernardo on 23/01/13.
//  Copyright (c) 2013 marzapower. All rights reserved.
//

#include "MPColorTools.h"

static void HSL2RGB(float h, float s, float l, float* outR, float* outG, float* outB) {
	float temp1, temp2, temp[3];
	int i;
	
	// Check for saturation. If there isn't any just return the luminance value for each, which results in gray.
	if (s == 0.0) {
		if(outR)
			*outR = l;
		if(outG)
			*outG = l;
		if(outB)
			*outB = l;
		return;
	}
	
	// Test for luminance and compute temporary values based on luminance and saturation
	if (l < 0.5)
		temp2 = l * (1.0 + s);
	else
		temp2 = l + s - l * s;
    temp1 = 2.0 * l - temp2;
	
	// Compute intermediate values based on hue
	temp[0] = h + 1.0 / 3.0;
	temp[1] = h;
	temp[2] = h - 1.0 / 3.0;
    
	for (i = 0; i < 3; ++i) {
		
		// Adjust the range
		if (temp[i] < 0.0)
			temp[i] += 1.0;
		if (temp[i] > 1.0)
			temp[i] -= 1.0;
		
		
		if (6.0 * temp[i] < 1.0)
			temp[i] = temp1 + (temp2 - temp1) * 6.0 * temp[i];
		else {
			if(2.0 * temp[i] < 1.0)
				temp[i] = temp2;
			else {
				if(3.0 * temp[i] < 2.0)
					temp[i] = temp1 + (temp2 - temp1) * ((2.0 / 3.0) - temp[i]) * 6.0;
				else
					temp[i] = temp1;
			}
		}
	}
	
	// Assign temporary values to R, G, B
	if (outR)
		*outR = temp[0];
	if (outG)
        *outG = temp[1];
	if (outB)
		*outB = temp[2];
}


static void RGB2HSL(float r, float g, float b, float* outH, float* outS, float* outL) {
    float h,s, l, v, m, vm, r2, g2, b2;
    
    h = 0;
    s = 0;
    l = 0;
    
    v = MAX(r, g);
    v = MAX(v, b);
    m = MIN(r, g);
    m = MIN(m, b);
    
    l = (m+v)/2.0f;
    
    if (l <= 0.0){
        if(outH)
			*outH = h;
		if(outS)
			*outS = s;
		if(outL)
			*outL = l;
        return;
    }
    
    vm = v - m;
    s = vm;
    
    if (s > 0.0f){
        s/= (l <= 0.5f) ? (v + m) : (2.0 - v - m);
    } else {
        if (outH)
			*outH = h;
		if (outS)
			*outS = s;
		if (outL)
			*outL = l;
        return;
    }
    
    r2 = (v - r)/vm;
    g2 = (v - g)/vm;
    b2 = (v - b)/vm;
    
    if (r == v) {
        h = (g == m ? 5.0f + b2 : 1.0f - g2);
    } else if (g == v) {
        h = (b == m ? 1.0f + r2 : 3.0 - b2);
    } else {
        h = (r == m ? 3.0f + g2 : 5.0f - r2);
    }
    
    h/=6.0f;
    
    if (outH)
        *outH = h;
    if (outS)
        *outS = s;
    if (outL)
        *outL = l;
}

@implementation UIColor (MPColorTools)

- (void) getHue:(CGFloat *)hue saturation:(CGFloat *)saturation lightness:(CGFloat *)lightness alpha:(CGFloat *)alpha {
    float r = 0;
    float g = 0;
    float b = 0;
    [self getRed:&r green:&g blue:&b alpha:alpha];
    RGB2HSL(r, g, b, hue, saturation, lightness);
}

+ (UIColor *) colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation lightness:(CGFloat)light alpha:(CGFloat)alpha {
    float r = 0;
    float g = 0;
    float b = 0;
    HSL2RGB(hue, saturation, light, &r, &g, &b);
    return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
}

- (UIColor *) colorByAddingLightness:(CGFloat)quantity {
    CGFloat hue = 0;
    CGFloat sat = 0;
    CGFloat lum = 0;
    CGFloat alp = 0;
    
    [self getHue:&hue saturation:&sat lightness:&lum alpha:&alp];
    lum = MP_RANGE_0_1(lum + quantity);
    
    return [UIColor colorWithHue:hue saturation:sat lightness:lum alpha:alp];
}

- (UIColor *)colorLightenedBy:(CGFloat)percent {
    CGFloat hue = 0;
    CGFloat sat = 0;
    CGFloat lum = 0;
    CGFloat alp = 0;
    
    [self getHue:&hue saturation:&sat lightness:&lum alpha:&alp];
    lum = MP_RANGE_0_1(lum * (1+percent));
    
    return [UIColor colorWithHue:hue saturation:sat lightness:lum alpha:alp];
}

- (UIColor *)colorDarkenedBy:(CGFloat)percent {
    CGFloat hue = 0;
    CGFloat sat = 0;
    CGFloat lum = 0;
    CGFloat alp = 0;
    
    [self getHue:&hue saturation:&sat lightness:&lum alpha:&alp];
    lum = MP_RANGE_0_1(lum * (1-percent));
    
    return [UIColor colorWithHue:hue saturation:sat lightness:lum alpha:alp];
}

- (UIColor *)colorWithLightness:(CGFloat)lightness {
    CGFloat hue = 0;
    CGFloat sat = 0;
    CGFloat lum = 0;
    CGFloat alp = 0;
    
    [self getHue:&hue saturation:&sat lightness:&lum alpha:&alp];
    return [self colorWithLightness:lightness alpha:alp];
}

- (UIColor *)colorWithLightness:(CGFloat)lightness alpha:(CGFloat)alpha {
    CGFloat hue = 0;
    CGFloat sat = 0;
    CGFloat lum = 0;
    CGFloat alp = 0;
    
    [self getHue:&hue saturation:&sat lightness:&lum alpha:&alp];
    return [UIColor colorWithHue:hue saturation:sat lightness:lightness alpha:alpha];
}

@end