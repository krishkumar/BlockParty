//
//  ViewController.m
//  BlockParty
//
//  Created by Krishna Kumar on 6/26/15.
//  Copyright © 2015 Krishna Kumar. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)openSiteInSafari:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)openSiteInSafari:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: @"http://www.rediff.com"]];
}
@end
