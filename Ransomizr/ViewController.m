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
@property (weak, nonatomic) IBOutlet UICollectionView *ransomNoteCollectionView;
@property (weak, nonatomic) IBOutlet UITextView *ransomNoteInput;

@end

@implementation ViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   [self.ransomNoteCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"ViewCell"];
      // Do any additional setup after loading the view, typically from a nib.
   [self.ransomNoteCollectionView setDataSource:self];

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

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   return [[self.ransomNoteInput.text componentsSeparatedByString:@" "] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ViewCell" forIndexPath:indexPath];
   NSString *word = [[self.ransomNoteInput.text componentsSeparatedByString:@" "] objectAtIndex:indexPath.row];
   RansomNoteRenderer *rendererView = [[RansomNoteRenderer alloc] initWithFrame:[cell frame] withCharacters:word];
   [cell.contentView addSubview:rendererView];
   [cell setFrame:rendererView.frame];
   return cell;
}

@end
