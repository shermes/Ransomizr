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
@property (nonatomic,strong) NSMutableArray* ransomNoteCharacterViews;
@property (weak, nonatomic) IBOutlet UICollectionView *ransomNoteCollectionView;
@property (weak, nonatomic) IBOutlet UITextView *ransomNoteInput;

@end

@implementation ViewController

- (void)viewDidLoad {
   [super viewDidLoad];
   self.ransomNoteCharacterViews = [[NSMutableArray alloc] init];
   [self.ransomNoteCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"ViewCell"];
      // Do any additional setup after loading the view, typically from a nib.
   [self.ransomNoteCollectionView setDataSource:self];
   [self.ransomNoteCollectionView setDelegate:self];

}
- (IBAction)printNote:(UIButton *)sender {
    //change ME
    [self createPDFfromUIView:self.view saveToDocumentsWithFileName:@"test.pdf"];
}

- (IBAction)ransomize:(id)sender {
   NSArray *groups = [self.ransomNoteInput.text componentsSeparatedByString:@" "];
   [self.ransomNoteCharacterViews removeAllObjects];
   for( NSString *group in groups ) {
      RansomNoteRenderer *renderer = [[RansomNoteRenderer alloc] initWithCharacters:group];
      [self.ransomNoteCharacterViews addObject:renderer];
   }
   [self.ransomNoteCollectionView reloadData];
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
   
   RansomNoteRenderer *renderer = [self.ransomNoteCharacterViews objectAtIndex:indexPath.row];
   return CGSizeMake(renderer.frame.size.width, renderer.frame.size.height);
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
   return [self.ransomNoteCharacterViews count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
   UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ViewCell" forIndexPath:indexPath];
   [cell.contentView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
   RansomNoteRenderer *rendererView = [self.ransomNoteCharacterViews objectAtIndex:indexPath.row];
   [cell.contentView addSubview:rendererView];
   CGRect cellFrame = cell.frame;
   cellFrame.size = rendererView.frame.size;
   cell.frame = cellFrame;
   return cell;
}

@end
