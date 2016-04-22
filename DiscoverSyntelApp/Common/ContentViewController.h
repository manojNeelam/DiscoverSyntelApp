//
//  ContentViewController.h
//  ThoughtLeaderShip
//
//  Created by Arshad Ahmad Khan on 3/20/14.
//  Copyright (c) 2014 Syntel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CollectionViewControllerCell.h"
#import "CollectionViewControllerCellWithoutImgView.h"
#import <SystemConfiguration/SystemConfiguration.h>

@interface ContentViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

{
    int noOfItems;
    int noOfSections;
    int noOfCellsLastScreen;
    int comparingSwipeScreen;
    int objIndexVal;
    IBOutlet UICollectionView* objCollectionView;
    CollectionViewControllerCell *collectionViewControllerCell;
    CollectionViewControllerCellWithoutImgView *collectionViewControllerCellWithoutImgView;
    NSMutableArray *imageDataArray;
}
@property (weak, nonatomic) IBOutlet UILabel *titleLabel1;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel2;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel3;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel4;



// Empty view that holds the image and description
@property (weak, nonatomic) IBOutlet UIView *contentArea;

// White border for movie image (to give it a Polaroid look)
@property (weak, nonatomic) IBOutlet UIView *imageFrame;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UITextView *descriptionField;

// Index of the movie (1 - 3)
@property (assign, nonatomic) NSUInteger movieIndex;
@property (assign,nonatomic) NSString* titleString1;
@property (assign,nonatomic) NSString* titleString2;
@property (assign,nonatomic) NSString* titleString3;
@property (assign,nonatomic) NSString* titleString4;

@property (assign,nonatomic) NSMutableArray* arrayToShow;
@property(assign,nonatomic) NSString *strViewControllerIdentifier;
@property (assign,nonatomic) NSMutableArray* arrayForImage;
//@property (weak, nonatomic) IBOutlet UILabel *label;
//@property (weak, nonatomic) IBOutlet UIView *contentAreaView;
//



@end
