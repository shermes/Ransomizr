//
//  ViewController.m
//  Ransomizr
//
//  Created by Scott Hermes on 11/20/14.
//  Copyright (c) 2014 Ransomizr Ince. All rights reserved.
//

#import "ViewController.h"
#import "RansomNoteRenderer.h"

@interface ViewController ()

@property CALayer *ransomNoteLayer;
@property (nonatomic,strong) RansomNoteRenderer *ransomNoteRenderer;

@end

@implementation ViewController

- (void)viewDidLoad {
   [super viewDidLoad];
      // Do any additional setup after loading the view, typically from a nib.
   self.ransomNoteRenderer = [[RansomNoteRenderer alloc] init];
   self.ransomNoteLayer = [CALayer layer];
   self.ransomNoteLayer.backgroundColor = [UIColor yellowColor].CGColor;
   self.ransomNoteLayer.geometryFlipped = YES;
   self.ransomNoteLayer.delegate = self.ransomNoteRenderer;
   
      // Put it atop the view
   [self.view.layer addSublayer:self.ransomNoteLayer];
}
- (IBAction)printNote:(UIButton *)sender {
    //change ME
    [self createPDFfromUIView:self.view saveToDocumentsWithFileName:@"test.pdf"];
}

-(void)createPDFfromUIView:(UIView*)aView saveToDocumentsWithFileName:(NSString*)aFilename
{
    
    NSMutableData *pdfData = [NSMutableData data];
    
    UIGraphicsBeginPDFContextToData(pdfData, aView.bounds, nil);
    UIGraphicsBeginPDFPage();
    CGContextRef pdfContext = UIGraphicsGetCurrentContext();
    
    [aView.layer renderInContext:pdfContext];
    
    UIGraphicsEndPDFContext();
    
    
    NSArray* documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask,YES);
    
    NSString* documentDirectory = [documentDirectories objectAtIndex:0];
    NSString* documentDirectoryFilename = [documentDirectory stringByAppendingPathComponent:aFilename];
    
    
    [pdfData writeToFile:documentDirectoryFilename atomically:YES];
    NSLog(@"documentDirectoryFileName: %@",documentDirectoryFilename);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    CGRect bounds = self.view.bounds;
    
    bounds.size.height -= 60; // Leave space for the buttons
    
    self.ransomNoteLayer.bounds = bounds;
    self.ransomNoteLayer.anchorPoint = CGPointZero;
    self.ransomNoteLayer.position = CGPointZero;
    [self.ransomNoteLayer setNeedsDisplay];
}


@end
