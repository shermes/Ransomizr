//
//  RansomNoteRenderer.h
//  Ransomizr
//
//  Created by Shawn Windler on 11/20/14.
//  Copyright (c) 2014 Ransomizr Ince. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RansomNoteRenderer : NSObject

// Assumes the context is flipped
- (void)drawInContext:(CGContextRef)ctx bounds:(CGRect)bounds;

// Just a stub that calls drawInContext:bounds:
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx;

@end
