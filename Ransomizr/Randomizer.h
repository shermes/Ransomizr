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
- (UIFont*)getRandomFontWithMinSize:(CGFloat)min maxSize:(CGFloat)max;

@end
