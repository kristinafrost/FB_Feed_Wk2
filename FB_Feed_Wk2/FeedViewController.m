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


- (void)feedLoad;
-(void)viewDidLayoutSubviews;

@end

@implementation FeedViewController
@synthesize scrollView;

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
    
    //[self performSelector:@selector(feedLoad) withObject:nil afterDelay:2];
    
    [self.scrollView setScrollEnabled:true];
    [self.scrollView setContentSize:CGSizeMake(320, 500)];
    
    [self performSelector:@selector(feedLoad) withObject:nil afterDelay:2];
   
    
    // Do any additional setup after loading the view from its nib.
 
    self.navigationItem.title = @"News Feed";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews {
    self.scrollView.contentSize = self.contentView.frame.size;
}


-(void)feedLoad {
    NSLog(@"loading");
    [self.loadIndicator stopAnimating];
}
    
//}

@end
