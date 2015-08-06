//
//  ViewController.m
//  BlockParty
//
//  Created by Krishna Kumar on 6/26/15.
//  Copyright © 2015 Krishna Kumar. All rights reserved.
//

#import "ViewController.h"
#import <SafariServices/SafariServices.h>

@interface ViewController ()
- (IBAction)jsonTapped:(id)sender;

- (IBAction)settingsTapped:(id)sender;
- (IBAction)site1Tapped:(id)sender;
- (IBAction)site2Tapped:(id)sender;
- (IBAction)site3Tapped:(id)sender;
- (IBAction)site4Tapped:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UINavigationController *navigationController = (UINavigationController *)self.navigationController;
    UIFont *font = [UIFont fontWithName:@"Avenir Next" size:16];
    [navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                [UIColor blackColor],
                                                                NSForegroundColorAttributeName,
                                                                font,
                                                                NSFontAttributeName,
                                                                nil]];
    //test call
    [SFContentBlockerManager reloadContentBlockerWithIdentifier:@"com.blackwaterpark.apps.BlockParty.RediffBlock" completionHandler:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)jsonTapped:(id)sender {
    [self performSegueWithIdentifier:@"showRules" sender:self];
}

- (IBAction)settingsTapped:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: UIApplicationOpenSettingsURLString]];
}

- (IBAction)site1Tapped:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.latimes.com"]];
}

- (IBAction)site2Tapped:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.torontotelegraph.com"]];
}

- (IBAction)site3Tapped:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.ndtv.com"]];
}

- (IBAction)site4Tapped:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.engadget.com"]];
}


@end
