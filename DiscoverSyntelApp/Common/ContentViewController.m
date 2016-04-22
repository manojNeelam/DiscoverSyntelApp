//
//  ContentViewController.m
//  ThoughtLeaderShip
//
//  Created by Arshad Ahmad Khan on 3/20/14.
//  Copyright (c) 2014 Syntel. All rights reserved.
//

#import "ContentViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "NewsLinkViewController.h"
#import "VideosWebViewController.h"
#import "Common.h"
#import "DetailWebViewController.h"
#import "AFHTTPClient.h"



#define FRAME_MARGIN 10



@interface ContentViewController ()
@property (assign, nonatomic, getter = isRotating) BOOL rotating;

@end

@implementation ContentViewController
@synthesize titleLabel1 = _titleLabel1;
@synthesize titleLabel2 = _titleLabel2;
@synthesize titleLabel3 = _titleLabel3;
@synthesize titleLabel4 = _titleLabel4;
@synthesize contentArea = _contentArea;
@synthesize imageFrame = _imageFrame;
@synthesize imageView = _imageView;
@synthesize descriptionField = _descriptionField;
@synthesize movieIndex = _movieIndex;
@synthesize rotating = _rotating;
@synthesize titleString1=_titleString1;
@synthesize titleString2=_titleString2;
@synthesize titleString3=_titleString3;
@synthesize titleString4=_titleString4;
@synthesize arrayToShow=_arrayToShow;
@synthesize strViewControllerIdentifier=_strViewControllerIdentifier;
@synthesize arrayForImage=_arrayForImage;
//@synthesize label, contentAreaView;


- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self.strViewControllerIdentifier isEqualToString:Videos]) {
        [self performSelectorInBackground:@selector(imageConversion) withObject:nil];
        
    }


    //CollectionView
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
   // [flowLayout setItemSize:CGSizeMake(140, 200)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [objCollectionView setCollectionViewLayout:flowLayout];
    NSString *strType=[self returnContentType];
    if([strType isEqualToString:@"type1"]||[strType isEqualToString:@"favType1"])
    {
        [objCollectionView registerClass:CollectionViewControllerCellWithoutImgView.class forCellWithReuseIdentifier:@"CollectionViewControllerCellWithoutImgView"];
    }
    else{
        [objCollectionView registerClass:CollectionViewControllerCell.class forCellWithReuseIdentifier:@"CollectionViewControllerCell"];
    }
    
    [objCollectionView setAllowsSelection: YES];
    int val1=(int)[self.arrayToShow count]/4;
    int val2=(int)val1*4;
    noOfCellsLastScreen = (int)([self.arrayToShow count]-val2);
    comparingSwipeScreen = (int)[self.arrayToShow count]/4;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews
{
	[super viewWillLayoutSubviews];
}

- (void)setShadowPathsWithAnimationDuration:(NSTimeInterval)duration
{
	UIBezierPath *newPath = [UIBezierPath bezierPathWithRect:self.imageFrame.bounds];
	CGPathRef oldPath = CGPathRetain([self.imageFrame.layer shadowPath]);
	[self.imageFrame.layer setShadowPath:[newPath CGPath]];
	
	if (duration > 0)
	{
		CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"shadowPath"];
		[pathAnimation setFromValue:(__bridge id)oldPath];
		[pathAnimation setToValue:(id)[self.imageFrame.layer shadowPath]];
		[pathAnimation setDuration:duration];
		[pathAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
		[pathAnimation setRemovedOnCompletion:YES];
		
		[self.imageFrame.layer addAnimation:pathAnimation forKey:@"shadowPath"];
	}
	
	CGPathRelease(oldPath);
}

- (void)viewDidLayoutSubviews
{
	[super viewDidLayoutSubviews];
}

- (void)willMoveToParentViewController:(UIViewController *)parent
{
	[super willMoveToParentViewController:parent];
	if (parent)
		NSLog(@"willMoveToParentViewController");
	else
		NSLog(@"willRemoveFromParentViewController");
}

- (void)didMoveToParentViewController:(UIViewController *)parent
{
	[super didMoveToParentViewController:parent];
	if (parent)
		NSLog(@"didMoveToParentViewController");
	else
		NSLog(@"didRemoveFromParentViewController");
}


#pragma mark - CollectionViewDelegates

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView
{
    if (self.movieIndex>comparingSwipeScreen) {
        NSLog(@"no of Cells %d",noOfCellsLastScreen);
       if (noOfCellsLastScreen<=2) {
            return 1;
       }
      
    }
    
    return 2;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   if (self.movieIndex>comparingSwipeScreen) {
       if(noOfCellsLastScreen==1 && section==0)
       {
           return 1;
       }
       else if(noOfCellsLastScreen==3 && section==1)
       {
           return 1;
       }
       
       
   }
   
    return 2;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellType=[self returnContentType];
    NSString *strKeyTitle;
    NSString *strKeyPubDate;
    NSString *strVideoImageLink;
    NSString *strCellIdentifier;

    int prevIndex = (int)self.movieIndex-1;
    
    if([cellType isEqualToString:@"type1"]||[cellType isEqualToString:@"favType1"]){
        // For News /Technological Offerings /Industrial Offerings
        strCellIdentifier=@"CollectionViewControllerCellWithoutImgView";
        collectionViewControllerCellWithoutImgView = (CollectionViewControllerCellWithoutImgView*) [collectionView dequeueReusableCellWithReuseIdentifier:strCellIdentifier forIndexPath:indexPath];
    }
    else{
        // For Videos /White Papers /Case Studies
        strCellIdentifier=@"CollectionViewControllerCell";
        collectionViewControllerCell = (CollectionViewControllerCell*) [collectionView dequeueReusableCellWithReuseIdentifier:strCellIdentifier forIndexPath:indexPath];
    }
    
    if ([cellType isEqualToString:@"favType1"]||[cellType isEqualToString:@"favType2"]){
        strKeyTitle=@"fav_title";
        strKeyPubDate=@"fav_date";
        strVideoImageLink=@"fav_image";
    }
    else{
        strKeyTitle=@"title";
        strKeyPubDate=@"pubDate";
    }
    
    
    if (indexPath.section==0) {
        if (indexPath.item==0) {
            if([cellType isEqualToString:@"type1"]||[cellType isEqualToString:@"favType1"]){
                collectionViewControllerCellWithoutImgView.titleLabel.text = [[self.arrayToShow objectAtIndex:prevIndex*4]valueForKey:strKeyTitle];
                collectionViewControllerCellWithoutImgView.pubDateLabel.text = [[self.arrayToShow objectAtIndex:prevIndex*4]valueForKey:strKeyPubDate];
            }
            else{
                if ([imageDataArray count]>0) {
                    collectionViewControllerCell.imageView.image = [UIImage imageWithData:[imageDataArray objectAtIndex:0]];
                }
                //collectionViewControllerCell.imageView.image = [UIImage imageWithData:[self.arrayForImage objectAtIndex:prevIndex*4]];
                collectionViewControllerCell.titleLabel.text = [[self.arrayToShow objectAtIndex:prevIndex*4]valueForKey:strKeyTitle];
                collectionViewControllerCell.pubDateLabel.text = [[self.arrayToShow objectAtIndex:prevIndex*4]valueForKey:strKeyPubDate];
                }
        }
        else if(indexPath.item==1)
        {
            if([cellType isEqualToString:@"type1"]||[cellType isEqualToString:@"favType1"]){
                
                collectionViewControllerCellWithoutImgView.titleLabel.text = [[self.arrayToShow objectAtIndex:prevIndex*4+1]valueForKey:strKeyTitle];
                collectionViewControllerCellWithoutImgView.pubDateLabel.text = [[self.arrayToShow objectAtIndex:prevIndex*4+1]valueForKey:strKeyPubDate];
            }
            else
            {
                if ([imageDataArray count]>0) {
                    collectionViewControllerCell.imageView.image = [UIImage imageWithData:[imageDataArray objectAtIndex:1]];
                }

                // collectionViewControllerCell.imageView.image = [UIImage imageWithData:[self.arrayForImage objectAtIndex:prevIndex*4+1]];
                collectionViewControllerCell.titleLabel.text = [[self.arrayToShow objectAtIndex:prevIndex*4+1]valueForKey:strKeyTitle];
                collectionViewControllerCell.pubDateLabel.text = [[self.arrayToShow objectAtIndex:prevIndex*4+1]valueForKey:strKeyPubDate];
            }
            
        }
    }
    else if(indexPath.section==1){
    
        if (indexPath.item==0) {
            if([cellType isEqualToString:@"type1"]||[cellType isEqualToString:@"favType1"])
            {
                collectionViewControllerCellWithoutImgView.titleLabel.text = [[self.arrayToShow objectAtIndex:prevIndex*4+2]valueForKey:strKeyTitle];
                collectionViewControllerCellWithoutImgView.pubDateLabel.text = [[self.arrayToShow objectAtIndex:prevIndex*4+2]valueForKey:strKeyPubDate];
            }
            else
            {
                if ([imageDataArray count]>0) {
                    collectionViewControllerCell.imageView.image = [UIImage imageWithData:[imageDataArray objectAtIndex:2]];
                }

                // collectionViewControllerCell.imageView.image = [UIImage imageWithData:[self.arrayForImage objectAtIndex:prevIndex*4+2]];
                collectionViewControllerCell.titleLabel.text = [[self.arrayToShow objectAtIndex:prevIndex*4+2]valueForKey:strKeyTitle];
                collectionViewControllerCell.pubDateLabel.text = [[self.arrayToShow objectAtIndex:prevIndex*4+2]valueForKey:strKeyPubDate];
            }
           
        }
        else if(indexPath.item==1)
        {
            if([cellType isEqualToString:@"type1"]||[cellType isEqualToString:@"favType1"]){
                
                collectionViewControllerCellWithoutImgView.titleLabel.text = [[self.arrayToShow objectAtIndex:prevIndex*4+3]valueForKey:strKeyTitle];
                collectionViewControllerCellWithoutImgView.pubDateLabel.text = [[self.arrayToShow objectAtIndex:prevIndex*4+3]valueForKey:strKeyPubDate];
            }
            else
            {
                if ([imageDataArray count]>0) {
                    collectionViewControllerCell.imageView.image = [UIImage imageWithData:[imageDataArray objectAtIndex:3]];
                }

              //collectionViewControllerCell.imageView.image = [UIImage imageWithData:[self.arrayForImage objectAtIndex:prevIndex*4+3]];
                collectionViewControllerCell.titleLabel.text = [[self.arrayToShow objectAtIndex:prevIndex*4+3]valueForKey:strKeyTitle];
                collectionViewControllerCell.pubDateLabel.text = [[self.arrayToShow objectAtIndex:prevIndex*4+3]valueForKey:strKeyPubDate];
            }
           
        }

    }
    
    if([cellType isEqualToString:@"type1"]||[cellType isEqualToString:@"favType1"]){
        collectionViewControllerCellWithoutImgView.layer.borderWidth=3.0f;
        collectionViewControllerCellWithoutImgView.layer.borderColor=[UIColor whiteColor].CGColor;
        return collectionViewControllerCellWithoutImgView;
    }
    else{
        collectionViewControllerCell.layer.borderWidth=3.0f;
        collectionViewControllerCell.layer.borderColor=[UIColor whiteColor].CGColor;
        return collectionViewControllerCell;
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
   
    if (UIDeviceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])){
        return CGSizeMake(284,110);
    }
    else if ([self.strViewControllerIdentifier isEqualToString:IndustrialOfferings]||[self.strViewControllerIdentifier isEqualToString:News]||[self.strViewControllerIdentifier isEqualToString:CaseStudies]||[self.strViewControllerIdentifier isEqualToString:WhitePapers])
    {
        return CGSizeMake(160, 160);
       //  return CGSizeMake(160, 120);
    }
    //return CGSizeMake(160, 220);
    return CGSizeMake(160, 180);
}



- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

// Layout: Set Edges
- (UIEdgeInsets)collectionView:
(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0,0,0,0);  // top, left, bottom, right
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
   
    int indexPathValue=0;
    int prevIndex = (int)self.movieIndex-1;
   
    if(indexPath.section==0){
        if(indexPath.item==0){
            indexPathValue=prevIndex*4;
        }
        else if (indexPath.item==1){
            indexPathValue=prevIndex*4+1;
        }
    }
    else if (indexPath.section==1){
        if(indexPath.item==0){
            indexPathValue=prevIndex*4+2;
        }
        else if (indexPath.item==1){
            indexPathValue=prevIndex*4+3;
        }

    }
    
    NSMutableArray *arrValPassd=[NSMutableArray array]; //contains the value to be passed
    [arrValPassd addObject:[self.arrayToShow objectAtIndex:indexPathValue]];
    NSString *strType=[self returnContentType];
    
    if([strType isEqualToString:@"type1"]||[strType isEqualToString:@"type2"])
    {
        int val=(int)[self.arrayToShow indexOfObject:[arrValPassd objectAtIndex:0]];
        NSString *fileNamePassed=[NSString stringWithFormat:@"%@%d",self.strViewControllerIdentifier,val];
        NewsLinkViewController* newsLinkViewController=[[NewsLinkViewController alloc]initWithNibName:@"NewsLinkViewController" :[[arrValPassd objectAtIndex:0]valueForKey:@"link"] bundle:nil arrDataSourceReceived:arrValPassd favouriteType:self.strViewControllerIdentifier cacheFileName:fileNamePassed];
        [self.navigationController pushViewController:newsLinkViewController animated:YES];
    }
    else if ([self.strViewControllerIdentifier isEqualToString:NewsFavourites])
    {
        
        NSMutableArray *arrDataSourceOffline=[self fetchCacheFileWithIndex:0 type:News];
        NSMutableArray *arrFilePathCache=[[NSMutableArray alloc]init];
        for (id obj in arrDataSourceOffline) {
            NSString *strFileNameExtracted=[obj valueForKey:@"fav_cachefile"];
            [arrFilePathCache addObject:[strFileNameExtracted lastPathComponent]];
        }
        
        NSLog(@"arrPathfile:%@",arrFilePathCache);
        
        DetailWebViewController *objDetailWebViewController=[[DetailWebViewController alloc]initWithNibName:@"DetailWebViewController" bundle:nil link:[[arrValPassd objectAtIndex:0]valueForKey:@"fav_link"] fileName:[arrFilePathCache objectAtIndex:indexPathValue]];
        [self.navigationController pushViewController:objDetailWebViewController animated:YES];
       
       
    }
    else if ([self.strViewControllerIdentifier isEqualToString:CaseStudiesFavourites]||[self.strViewControllerIdentifier isEqualToString:WhitePapersFavourites])
    {
        BOOL isOfflineMode=YES;
        NSString *strFavOption;
        if([self.strViewControllerIdentifier isEqualToString:CaseStudiesFavourites])
        {
            strFavOption=CaseStudies;
        }
        else if ([self.strViewControllerIdentifier isEqualToString:WhitePapersFavourites])
        {
            strFavOption=WhitePapers;
        }
        if(isOfflineMode)
        {
            NSMutableArray *arrDataSourceOffline=[self fetchCacheFileWithIndex:0 type:strFavOption];
            
            
            NSMutableArray *arrFilePathCache=[[NSMutableArray alloc]init];
            for (id obj in arrDataSourceOffline) {
                NSString *strFileNameExtracted=[obj valueForKey:@"fav_cachefile"];
                [arrFilePathCache addObject:[strFileNameExtracted lastPathComponent]];
            }
            
            NSLog(@"arrPathfile:%@",arrFilePathCache);
            
            DetailWebViewController *objDetailWebViewController=[[DetailWebViewController alloc]initWithNibName:@"DetailWebViewController" bundle:nil link:[[arrValPassd objectAtIndex:0]valueForKey:@"fav_link"] fileName:[arrFilePathCache objectAtIndex:indexPathValue]];
            [self.navigationController pushViewController:objDetailWebViewController animated:YES];
        }
    }
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                               duration:(NSTimeInterval)duration{
    
    [objCollectionView.collectionViewLayout invalidateLayout];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [objCollectionView performBatchUpdates:nil completion:nil];
}


-(void)imageConversion
{
    NSLog(@"inside other thread");
    int addValLoop;
    int prevIndex = (int)(self.movieIndex-1)*4;
    if (self.movieIndex>comparingSwipeScreen)
    {
        addValLoop = prevIndex+noOfCellsLastScreen;
    }
    else
    {
        addValLoop = prevIndex+4;
    }
    imageDataArray = [[NSMutableArray alloc]init];
    
    for (int i=prevIndex; i<addValLoop; i++){
        
        NSString *ImageURL = [[self.arrayToShow objectAtIndex:i]valueForKey:@"image"];
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:ImageURL]];
        if (imageData) {
            [imageDataArray addObject:imageData];
            NSLog(@"index val %d",i);
        }
        
        
    }
    
    [objCollectionView reloadData];
    
}


-(NSMutableArray*)fetchCacheFileWithIndex:(int)indexVal type:(NSString*)favType
{
    AppDelegate* appDelegateObj = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* managedContextObj = [appDelegateObj managedObjectContext];
    
    // Define entity to use
    NSEntityDescription* entityDescription = [NSEntityDescription entityForName:@"Favourites" inManagedObjectContext:managedContextObj];
    
    // Setup the fetch request
    NSFetchRequest* fetchRequestObj =[[NSFetchRequest alloc] init ];
    [fetchRequestObj setEntity:entityDescription];
    
    //setting predicate according to favourite type
    NSPredicate* predicateObj = [NSPredicate predicateWithFormat:@"fav_type==%@",favType];
    [fetchRequestObj setPredicate:predicateObj];
    NSError* errorObj = nil;
    NSArray *arrFavouriesManagedContext = [managedContextObj executeFetchRequest:fetchRequestObj error:&errorObj];
    return [arrFavouriesManagedContext mutableCopy];
}

-(NSString*)returnContentType
{
    if([self.strViewControllerIdentifier isEqualToString:News]||[self.strViewControllerIdentifier isEqualToString:TechnicalOfferings]||[self.strViewControllerIdentifier isEqualToString:IndustrialOfferings])
    {
        return @"type1";
    }
    else if ([self.strViewControllerIdentifier isEqualToString:Videos]||[self.strViewControllerIdentifier isEqualToString:WhitePapers]||[self.strViewControllerIdentifier isEqualToString:CaseStudies])
    {
        return @"type2";
    }
    else if ([self.strViewControllerIdentifier isEqualToString:NewsFavourites]||[self.strViewControllerIdentifier isEqualToString:TechnicalOfferingsFavourites]||[self.strViewControllerIdentifier isEqualToString:IndustrialOfferingsFavourites])
    {
        return @"favType1";
    }
    else if ([self.strViewControllerIdentifier isEqualToString:VideosFavourites]||[self.strViewControllerIdentifier isEqualToString:WhitePapersFavourites]||[self.strViewControllerIdentifier isEqualToString:CaseStudiesFavourites])
    {
        return @"favType2";
    }
    return nil;
}

-(BOOL)chechConnectivity
{
    
    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:@"http://google.com"]];
    [client setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        if (status == AFNetworkReachabilityStatusNotReachable) {
    
            UIAlertView* alertView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Check your internet connection" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        } else {
            
            // Reachable
            
           
        }
        
        
    }];
    return YES;
}

@end
