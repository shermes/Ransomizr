//
//  Randomizer.h
//  Ransomizr
//
//  Created by Scott Hermes on 11/20/14.
//  Copyright (c) 2014 Ransomizr Ince. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Randomizer : NSObject

- ( NSArray *) createRandomPath:(CGRect)outerRect  innerRect:(CGRect) innerRect;
/*!
 Gets a random font available on the system of a random size constrained
 between min and max.
 
 @param min The minimum font size to randomly generate
 @param max The maximum font size to randomly generate
 
 @return A font with a random font name and size
 */
- (UIFont*)getRandomFontWithMinSize:(CGFloat)min maxSize:(CGFloat)max;

/*!
 Gets a random boolean value. Essentially flips a coin
 
 @return A random boolean value, who knows could be true, could be false
 */
- (BOOL)randomBool;

/*!
 Gets a random boolean value based on a percentage specified for yes.
 
 @param percentage The percentage chances of a yes being returned. Value is
    expected to be between 0.0 and 1.0. For a 50/50 chance pass 0.5, a 20% chance
    pass 0.2.
 @return A boolean with a specified percentage chance of being true
 */
- (BOOL)randomBoolWithPercentage:(CGFloat)percentage;

@end
