//
//  RansomNoteRenderer.m
//  Ransomizr
//
//  Created by Shawn Windler on 11/20/14.
//  Copyright (c) 2014 Ransomizr Ince. All rights reserved.
//

#import "RansomNoteRenderer.h"
#import "Randomizer.h"


#define RANGE (700.0f)
// RANGE is the range of values that are OK

#define B_MARGIN (10.0f)
// B_MARGIN is the bottom margin in points

#define T_MARGIN (10.0f)
// T_MARGIN is the top margin in points

#define H_GAP (10.4f)
// H_GAP is the gap between the bars and side margins

#define NAME_HEIGHT (95.0f)
// NAME_HEIGHT is the height of the persons name in points

@interface RansomNoteRenderer()

@property (nonatomic,strong) Randomizer *randomizer;
@property (nonatomic,strong) NSAttributedString *displayString;
@end

@implementation RansomNoteRenderer

- (id)initWithFrame:(CGRect)frame withCharacters:(NSString *)characters
{
   self = [super initWithFrame:frame];
   if( self!=nil ) {
      self.randomizer = [[Randomizer alloc] init];
      UIFont *font = [self.randomizer getRandomFontWithMinSize:80 maxSize:120];
      UIColor *color = [UIColor greenColor]; //TODO: Randomize this
      NSDictionary *attribs = @{
         NSFontAttributeName: font,
         NSForegroundColorAttributeName: color,
      };
      self.displayString = [[NSAttributedString alloc] initWithString:characters attributes:attribs];
      self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.displayString.size.width, self.displayString.size.height);
   }
   return self;
}

- (void)drawRect:(CGRect)rect {

   [self.displayString drawInRect:self.bounds];

/*   CGContextRef ctx = UIGraphicsGetCurrentContext();
   CGRect    bounds = self.bounds;
   UIFont *font = [self.randomizer getRandomFontWithMinSize:80 maxSize:120];
   UIColor *color = [UIColor greenColor]; //TODO: Randomize this
   CGColorSpaceRef cs = CGColorSpaceCreateDeviceRGB();
   
   CGFloat blackRGBA[] = { 0, 0, 0, 1 };
   CGColorRef black = CGColorCreate(cs, blackRGBA);
   CGFloat whiteRGBA[] = { 1, 1, 1, 1 };
   CGColorRef white = CGColorCreate(cs, whiteRGBA);
   
   CGContextSetStrokeColorWithColor(ctx, black);
   CGContextSetLineWidth(ctx, 1);
   
   CGContextSetFillColorWithColor(ctx, white);
   
   NSDictionary *attribs = @{
      NSFontAttributeName: font,
      NSForegroundColorAttributeName: color,
   };
   NSAttributedString *displayAttrString = [[NSAttributedString alloc] initWithString:self.characters attributes:attribs];
   CGSize strSize = displayAttrString.size;
   CGPoint textPos = CGPointMake(CGRectGetMaxX(bounds) - strSize.width, -(CGRectGetMaxY(bounds)));
//   
//   UIGraphicsPushContext(ctx);
//   CGContextSaveGState(ctx);
//   CGContextScaleCTM(ctx, 1.0, -1.0);
   [displayAttrString drawAtPoint:textPos];
//   CGContextRestoreGState(ctx);
//   UIGraphicsPopContext();
   
   CGColorRelease(white);
   CGColorRelease(black);
   
   CGColorSpaceRelease(cs);*/
}

@end
