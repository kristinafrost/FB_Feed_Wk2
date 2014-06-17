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

//- (IBAction)onLogin:(id)sender {
    //[self.indicatorView startAnimating];
//}

- (IBAction)onPassword:(id)sender {
    if (self.userName.hasText){
        NSLog(@"user name has text");
        self.loginButton.enabled = true;
    }
    else {
        self.loginButton.enabled = false;
    }
}

- (void)willShowKeyboard:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    
    //     [self.view addGestureRecognizer:self.tapRecognizer];
    
    // Get the keyboard height and width from the notification
    // Size varies depending on OS, language, orientation
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

- (IBAction)onLogin:(id)sender {

 
    
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

- (void)validatePassword {
    if ([self.passwordTextField.text isEqualToString:@"password"]) {
        NSLog(@"correct password");
        
        
        FeedViewController *feedVC = [[FeedViewController alloc] init];
        //MoreViewController *moreVC = [[MoreViewController alloc] init];
        
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:feedVC];
       
        UITabBarController *tabBarController = [[UITabBarController alloc] init];
        
        tabBarController.viewControllers = @[navigationController];
        
        //self.window.rootViewController = tabBarController;
        
        navigationController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:tabBarController animated:YES completion:nil];


        
    }
    
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
    // Do any additional setup after loading the view from its nib.
    
    self.loginButton.enabled = false;
    
    //self.view.backgroundColor=[UIColor colorWithRed:0.301 green:0.427 blue:0.666 alpha:1.0];
    
    //([self.userName.text isEqualToString:@"password"]) {
    
    [self.view addSubview:self.loginItems];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
