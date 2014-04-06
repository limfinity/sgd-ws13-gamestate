//
//  UIColor+LightAndDark.m
//  Fat.Finger
//
//  Description:
//  Category to add extra functions to UIColor that can lighten or darken a given color.
//
//  Created by Peter Pult on 07.09.13.
//  Copyright (c) 2013 Peter Pult. All rights reserved.
//

#import "UIColor+LightAndDark.h"

@implementation UIColor (LightAndDark)

- (UIColor *)lighterColor
{
    CGFloat h, s, b, a;
    
    // '&' is to reference the float, because a pointer is requested by the function
    if ([self getHue:&h saturation:&s brightness:&b alpha:&a])
        return [UIColor colorWithHue:h
                          saturation:s
                          brightness:MIN(b * 1.3, 1.0)
                               alpha:a];
    return nil;
}

- (UIColor *)darkerColor
{
    CGFloat h, s, b, a;
    if ([self getHue:&h saturation:&s brightness:&b alpha:&a])
        return [UIColor colorWithHue:h
                          saturation:s
                          brightness:b * 0.75
                               alpha:a];
    return nil;
}

@end
