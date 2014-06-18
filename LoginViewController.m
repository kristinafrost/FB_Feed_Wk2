//
//  LoginViewController.m
//  FB_Feed_Wk2
//
//  Created by Kristina Frost on 6/14/14.
//  Copyright (c) 2014 Kristina Frost. All rights reserved.
//

#import "LoginViewController.h"
#import "FeedViewController.h"
#import "MoreViewController.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIView *loginItems;
@property (strong, nonatomic) IBOutlet UITapGestureRecognizer *tapRecognizer;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
- (IBAction)onLogin:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;
- (IBAction)onPassword:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;


- (void)validatePassword;
- (void)willShowKeyboard:(NSNotification *)notification;
- (void)willHideKeyboard:(NSNotification *)notification;

@end

@implementation LoginViewController



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Register the methods for the keyboard hide/show events
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShowKeyboard:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (IBAction)endTap:(id)sender {
    [self.view endEditing:YES];
}


- (IBAction)onPassword:(id)sender {
    if (self.userName.hasText){
        self.loginButton.enabled = true;
    }
    else {
        self.loginButton.enabled = false;
    }
}

//Show keyboard
- (void)willShowKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    

    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    NSLog(@"Height: %f Width: %f", kbSize.height, kbSize.width);
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                      self.loginItems.frame = CGRectMake(0, self.view.frame.size.height - self.loginItems.frame.size.height - 150, self.loginItems.frame.size.width, self.loginItems.frame.size.height);
                     }
                     completion:nil];
}

//Hide keyboard
- (void)willHideKeyboard:(NSNotification *)notification {
    NSLog(@"Hiding keyboard");
    NSDictionary *userInfo = [notification userInfo];
    
    //[self.view removeGestureRecognizer:self.tapRecognizer];
    
    // Get the animation duration and curve from the notification
    NSNumber *durationValue = userInfo[UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration = durationValue.doubleValue;
    NSNumber *curveValue = userInfo[UIKeyboardAnimationCurveUserInfoKey];
    UIViewAnimationCurve animationCurve = curveValue.intValue;
    
    // Move the view with the same duration and animation curve so that it will match with the keyboard animation
    [UIView animateWithDuration:animationDuration
                          delay:0.0
                        options:(animationCurve << 16)
                     animations:^{
                         self.loginItems.frame = CGRectMake(0, 0, self.loginItems.frame.size.width, self.loginItems.frame.size.height);
                     }
                     completion:nil];
    
    
}

//Log in with password
- (IBAction)onLogin:(id)sender {
    
    [self.view endEditing:YES];

        if (true) {
            [UIView animateWithDuration:0.3 animations:^{self.indicatorView.alpha = 1.0;}];
    
        UIButton *button = (UIButton*)sender;
            button.selected = !button.isSelected;
            [self.indicatorView startAnimating];
            self.loginButton.enabled = true;
    }
    
        //timer
        [self performSelector:@selector(validatePassword) withObject:nil afterDelay:2.0];
}

//Validate password
- (void)validatePassword {
    if ([self.passwordTextField.text isEqualToString:@"password"]) {
        NSLog(@"correct password");
        
        
        //Tab bar controller
        UITabBarController *tabBarController = [[UITabBarController alloc] init];
        
        //News Feed View with navigation
        FeedViewController *feedVC = [[FeedViewController alloc] init];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:feedVC];

        //More View with navigation
        MoreViewController *moreVC = [[MoreViewController alloc] init];
        UINavigationController *moreNavigationController = [[UINavigationController alloc] initWithRootViewController:moreVC];
        
        //Transition and presenting the tab bar controller
        navigationController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:tabBarController animated:YES completion:nil];

        
        //Tab bars
        navigationController.tabBarItem.title = @"News Feed";
        navigationController.tabBarItem.image = [UIImage imageNamed:@"feed_tab_img"];
        moreNavigationController.tabBarItem.title = @"More";
        moreNavigationController.tabBarItem.image = [UIImage imageNamed:@"more_tab_img"];
        
        tabBarController.viewControllers = @[navigationController, moreNavigationController];
  
    }
    
    //If incorrect password is entered
    else {UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Incorrect Password" message:@"The password you entered is incorrect. Please try again" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
        
        [self.indicatorView stopAnimating];
        self.passwordTextField.text = nil;
        
        // reset the button
        self.loginButton.enabled = false;
        self.loginButton.selected = false;
    }
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.loginButton.enabled = false;
    
    [self.view addSubview:self.loginItems];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
