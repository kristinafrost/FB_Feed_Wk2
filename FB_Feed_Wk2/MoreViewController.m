//
//  MoreViewController.m
//  FB_Feed_Wk2
//
//  Created by Kristina Frost on 6/16/14.
//  Copyright (c) 2014 Kristina Frost. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *moreScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *moreContentView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftButton;
@property (weak, nonatomic) IBOutlet UIImage *leftButtonImage;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightButton;
@property (weak, nonatomic) IBOutlet UIImage *rightButtonImage;

-(void)viewDidLayoutSubviews;

@end

@implementation MoreViewController
@synthesize moreScrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Nav Item "More" Title
    self.navigationItem.title = @"More";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    
    //Left Button aka "Search"
    UIImage *leftButtonImage = [[UIImage imageNamed:@"search_button"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithImage:leftButtonImage style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    //Right Button aka "Messages"
    UIImage *rightButtonImage = [[UIImage imageNamed:@"messages_button"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithImage:rightButtonImage style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    
    //Nav Bar Attributes
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.301 green:0.427 blue:0.666 alpha:1.0];
    self.navigationController.navigationBar.translucent = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

//Scrolling
-(void)viewDidLayoutSubviews {
    self.moreScrollView.contentSize = self.moreContentView.frame.size;
    [self.moreScrollView setScrollEnabled:true];
}

@end
