//
//  Randomizer.m
//  Ransomizr
//
//  Created by Scott Hermes on 11/20/14.
//  Copyright (c) 2014 Ransomizr Ince. All rights reserved.
//

#import "Randomizer.h"

@implementation Randomizer
- ( NSArray *) createRandomPath:(CGRect)outerRect  innerRect:(CGRect) innerRect{
    NSMutableArray *pathCoordinates = [[NSMutableArray alloc] init];
    // TODO: create random path
    return pathCoordinates;
}

static NSMutableArray *s_fontNames;

+ (void)initialize
{
    if(self == [Randomizer class])
    {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            s_fontNames = [NSMutableArray arrayWithCapacity:256];
            
            //We can thank Ajnaware's Weblog for the following snippet
            // https://ajnaware.wordpress.com/2008/10/24/list-of-fonts-available-on-the-iphone/
            // List all fonts on iPhone
            NSArray *familyNames = [[NSArray alloc] initWithArray:[UIFont familyNames]];
            NSArray *fontNames;
            NSInteger indFamily, indFont;
            for (indFamily=0; indFamily<[familyNames count]; ++indFamily)
            {
                fontNames = [[NSArray alloc] initWithArray:
                             [UIFont fontNamesForFamilyName:
                              [familyNames objectAtIndex:indFamily]]];
                for (indFont=0; indFont<[fontNames count]; ++indFont)
                {
                    [s_fontNames addObject:[fontNames objectAtIndex:indFont]];\
                }
            }
        });
    }
}

- (UIFont*)getRandomFontWithMinSize:(CGFloat)min maxSize:(CGFloat)max
{
    CGFloat size = (CGFloat)arc4random_uniform((uint32_t)(max - min + 1)) + min;
    NSUInteger index = (NSUInteger)arc4random_uniform((uint32_t)[s_fontNames count]);
    NSString *fontName = [s_fontNames objectAtIndex:index];
    UIFont *font = [UIFont fontWithName:fontName size:size];
    return font;
}

@end
