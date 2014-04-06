//
//  UIColor+LightAndDark.h
//  Fat.Finger
//
//  Description:
//  Category to add extra functions to UIColor that can lighten or darken a given color.
//
//  Created by Peter Pult on 07.09.13.
//  Copyright (c) 2013 Peter Pult. All rights reserved.
//

/*
 * Credits go to: H2CO3
 * http://stackoverflow.com/a/11598127/1633733
 */

@interface UIColor (LightAndDark)

/*! Lightens a UIColor.
 * \returns Lightend UIColor
 */
- (UIColor *)lighterColor;

/*! Lightens a UIColor.
 * \returns Lightend UIColor
 */
- (UIColor *)darkerColor;

@end
