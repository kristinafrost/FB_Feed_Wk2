//
//  FeedViewController.m
//  FB_Feed_Wk2
//
//  Created by Kristina Frost on 6/16/14.
//  Copyright (c) 2014 Kristina Frost. All rights reserved.
//

#import "FeedViewController.h"

@interface FeedViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *contentView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadIndicator;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftButton;
@property (weak, nonatomic) IBOutlet UIImage *leftButtonImage;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightButton;
@property (weak, nonatomic) IBOutlet UIImage *rightButtonImage;



- (void)feedLoad;
- (void)delayContent;
- (void)viewDidLayoutSubviews;


@end

@implementation FeedViewController
@synthesize scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Delay Showing Feed, starts at 0.0 opacity, starts with load indicator
    [self performSelector:@selector(delayContent) withObject:nil afterDelay:2];
    [self performSelector:@selector(feedLoad) withObject:nil afterDelay:2];
    [self.contentView setAlpha:0.0];

    //Nav Item "News Feed" Title
    self.navigationItem.title = @"News Feed";
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
    self.scrollView.contentSize = self.contentView.frame.size;
    [self.scrollView setScrollEnabled:true];
    
}

//Show Feed after 2 seconds, ends at 1.0 opacity
-(void)delayContent {
    [self.contentView setAlpha:1.0];
    
}

    //Feed Load
-(void)feedLoad {
    NSLog(@"loading");
    
    [self.loadIndicator stopAnimating];
}

@end
