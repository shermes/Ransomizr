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
@property (nonatomic,strong) NSArray *clipPathPoints;
@property (nonatomic,strong) UIColor *fontColor;
@property (nonatomic,strong) UIColor *bgColor;
@end

@implementation RansomNoteRenderer

- (id)initWithCharacters:(NSString *)characters
{
   self = [super initWithFrame:CGRectZero];
   if( self!=nil ) {
      self.randomizer = [[Randomizer alloc] init];
      UIFont *font = [self.randomizer getRandomFontWithMinSize:32 maxSize:64];
      self.fontColor = [self.randomizer getRandomUIColor];
      self.bgColor = [self.randomizer getRandomUIColor];
      NSDictionary *attribs = @{
         NSFontAttributeName: font,
         NSForegroundColorAttributeName: self.fontColor,
      };
      characters = [characters stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
      self.displayString = [[NSAttributedString alloc] initWithString:characters attributes:attribs];
      
      self.clipPathPoints = [self.randomizer createRandomPath:[self getRectForPaddedString:self.displayString] innerRect:self.displayString.size];
      if( self.displayString.length<=0 ) {
         self.frame = CGRectMake(0, 0, 40.f, self.displayString.size.height + 8.f);
      } else {
         self.frame = CGRectMake(0, 0, self.displayString.size.width + 8.f, self.displayString.size.height + 8.f);
      }
      self.backgroundColor = [UIColor clearColor];
   }
   return self;
}

- (void)drawRect:(CGRect)rect {

   if( self.displayString.length>0 ) {
      CGContextRef ctx = UIGraphicsGetCurrentContext();
      UIGraphicsPushContext(ctx);
      CGContextSetFillColorWithColor(ctx, self.bgColor.CGColor);
      // CLIP
      CGContextSaveGState(ctx);
      CGMutablePathRef clipPath = CGPathCreateMutable();
      CGPathMoveToPoint(clipPath, nil, [self.clipPathPoints[0] CGPointValue].x, [self.clipPathPoints[0] CGPointValue].y);
      for( int k = 1; k < self.clipPathPoints.count; k++) {
         CGPathAddLineToPoint(clipPath, nil, [self.clipPathPoints[k] CGPointValue].x, [self.clipPathPoints[k] CGPointValue].y);
      }
      CGPathMoveToPoint(clipPath, nil, [self.clipPathPoints[0] CGPointValue].x, [self.clipPathPoints[0] CGPointValue].y);
      CGContextAddPath(ctx, clipPath);
      CGContextClip(ctx);
      CGContextFillPath(ctx);
      CGContextFillRect(ctx, self.bounds);
      [self.displayString drawAtPoint:CGPointMake(4.f, 2.f)];
      CGContextRestoreGState(ctx);

      // STRING
      CGContextSaveGState(ctx);
      CGContextScaleCTM(ctx, 1.0, -1.0);
      CGContextRestoreGState(ctx);
      
      UIGraphicsPopContext();
   }
}

- (CGSize)getRectForPaddedString:(NSAttributedString *)str {

   CGSize stringSize = str.size;
   return CGSizeMake( stringSize.width + 24.f, stringSize.height + 32.f);
}

@end
