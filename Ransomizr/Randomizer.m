//
//  Randomizer.m
//  Ransomizr
//
//  Created by Scott Hermes on 11/20/14.
//  Copyright (c) 2014 Ransomizr Ince. All rights reserved.
//

#import "Randomizer.h"
const int POINTS_PER_SQUARE = 1;
const int MAX_SQUARES = 8;

@implementation Randomizer
- ( NSArray *) createRandomPath:(CGRect)outerRect  innerRect:(CGRect) innerRect{
    NSMutableArray *pathCoordinates = [[NSMutableArray alloc] init];
    // TODO: create random path
    
    // Generate random number of points to generate per quad
    // Determine min,max for top, right, left, bottom
    // generate and sort points
    // x-> width
    // y -> height
    CGFloat gapWidth = (outerRect.size.width - innerRect.size.width)/2.0;
    CGFloat gapHeight = (outerRect.size.height - innerRect.size.height)/2.0;
    // start at 0.0
    CGPoint minPoint;
    CGPoint maxPoint;
    for (int i = 0; i < MAX_SQUARES; i++) {
        switch (i) {
            case 0:
                // Left top corner
                minPoint = CGPointMake(0.0, 0.0);
                maxPoint = CGPointMake(minPoint.x + gapWidth, minPoint.y + gapHeight);
                break;
            case 1:
                // top center
                minPoint = CGPointMake(minPoint.x + gapWidth, minPoint.y);
                maxPoint = CGPointMake(maxPoint.x + innerRect.size.width, maxPoint.y);
                break;
            case 2:
                // right top corner
                minPoint = CGPointMake(minPoint.x + innerRect.size.width, minPoint.y);
                maxPoint = CGPointMake(maxPoint.x + gapWidth, maxPoint.y);
                break;
            case 3:
                // left side middle
                minPoint = CGPointMake(0, gapHeight);
                maxPoint = CGPointMake(gapWidth, gapHeight + innerRect.size.height);
                break;
            case 4:
                // right side middle
                minPoint = CGPointMake(gapWidth + innerRect.size.width, minPoint.y);
                maxPoint = CGPointMake(outerRect.size.width, maxPoint.y);
                break;
            case 5:
                // left lower corner
                minPoint = CGPointMake(0, gapHeight + innerRect.size.height);
                maxPoint = CGPointMake(gapWidth, outerRect.size.height);
                break;
            case 6:
                // left lower center
                minPoint = CGPointMake(minPoint.x + gapWidth, minPoint.y);
                maxPoint = CGPointMake(maxPoint.x + innerRect.size.width, maxPoint.y);
                break;
            case 7:
                // left right corner
                minPoint = CGPointMake(minPoint.x + innerRect.size.width, minPoint.y);
                maxPoint = CGPointMake(maxPoint.x + gapWidth, maxPoint.y);
                break;
                
            default:
                NSLog(@"Should not reach here!");
                break;
        }
        NSValue *point = [NSValue valueWithCGPoint:[self createRandomPoint:minPoint maxPoint:maxPoint]];
        [pathCoordinates addObject:point];
    }
    return pathCoordinates;
}
- (CGPoint) createRandomPoint:(CGPoint)minPoint maxPoint:(CGPoint) maxPoint {
    // prevent overlaps between sqaures by using offset
    CGFloat offset = 2.0;
    CGFloat rangeX = (maxPoint.x - minPoint.x) - offset;
    CGFloat rangeY = (maxPoint.y - minPoint.y) - offset;
    // using int for random offsets
    CGFloat randomX = minPoint.x + offset + (arc4random()%(int)rangeX);
    CGFloat randomY = minPoint.y + offset + (arc4random()%(int)rangeY);
    return CGPointMake(randomX, randomY);
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

- (BOOL)randomBool
{
    return [self randomBoolWithPercentage:0.5];
}

- (BOOL)randomBoolWithPercentage:(CGFloat)percentage
{
    percentage *= 100.0; //Turn our percent into a number
    //101 will result in a number between 0 - 100. Our
    // new percentage number will be used to see if the random
    // number is less than our equal to the percentage.
    return arc4random_uniform(101) <= percentage;
}

@end
