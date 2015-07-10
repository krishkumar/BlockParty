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
- (IBAction)openSiteInSafari:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [SFContentBlockerManager reloadContentBlockerWithIdentifier:@"com.blackwaterpark.apps.BlockParty.RediffBlock" completionHandler:nil];
    NSLog(@"Reloading Content Blocker Rules!"); // tested to be not working as of beta 3 :(

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openSiteInSafari:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: UIApplicationOpenSettingsURLString]];
}
@end
