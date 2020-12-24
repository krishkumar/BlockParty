//
//  ViewController.m
//  BlockParty
//
//  Created by Krishna Kumar on 6/26/15.
//  Copyright © 2015 Krishna Kumar. All rights reserved.
//

#import "ViewController.h"
#import <SafariServices/SafariServices.h>
#import "UIDeviceHelper.h"
#import "BlockPartyConstants.h"

@interface ViewController ()
- (IBAction)jsonTapped:(id)sender;
- (IBAction)settingsTapped:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *instructionLabel2;
@property (strong, nonatomic) IBOutlet UILabel *instructionLabel3;
@property (strong, nonatomic) IBOutlet UIButton *settingsButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    UINavigationController *navigationController = (UINavigationController *)self.navigationController;
    UIFont *font = [UIFont fontWithName:@"Avenir Next" size:16];
    [navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                font,
                                                                NSFontAttributeName,
                                                                nil]];
    #if TARGET_OS_UIKITFORMAC
        self.navigationItem.title = @"BlockParty Mac";
    #else
        self.navigationItem.title = @"BlockParty";
    #endif
    
    if (IS_IPHONE_4 || IS_IPHONE_5) {
        self.instructionLabel2.font = [UIFont fontWithName:@"Avenir Next" size:14];
        self.instructionLabel3.font = [UIFont fontWithName:@"Avenir Next" size:14];
    }
    
    [SFContentBlockerManager reloadContentBlockerWithIdentifier:APP_EXTENSION_NAME completionHandler:^(NSError *error) {
        if (error!=nil) {
            NSLog(@"RELOAD OF %@ FAILED WITH ERROR -%@", APP_EXTENSION_NAME,[error localizedDescription]);
        }
    }];
    
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handleBlockerState)
                                                name:UIApplicationDidBecomeActiveNotification
                                              object:nil];
    UIImageSymbolConfiguration *config = [UIImageSymbolConfiguration configurationWithPointSize:60.0];
    UIImage *gearImage = [UIImage systemImageNamed:@"gear" withConfiguration:config];
    [self.settingsButton setImage:gearImage forState:UIControlStateNormal];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self handleBlockerState];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)jsonTapped:(id)sender {
    [self performSegueWithIdentifier:@"showRules" sender:self];
}

- (IBAction)settingsTapped:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:^(BOOL success) {
            //
    }];
}

- (void)handleBlockerState {
    
    // getStateofContentBlockerIdentifier API is iOS 10 only
    if ([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:(NSOperatingSystemVersion){.majorVersion = 10, .minorVersion = 0, .patchVersion = 0}]) {
        [SFContentBlockerManager getStateOfContentBlockerWithIdentifier:APP_EXTENSION_NAME completionHandler:^(SFContentBlockerState * _Nullable state, NSError * _Nullable error) {
            if (error!=nil) {
                NSLog(@"GETTING STATE OF %@ FAILED WITH ERROR -%@", APP_EXTENSION_NAME,[error localizedDescription]);
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (state.enabled) { // blocker turned ON in settings
                        self.settingsButton.hidden = YES;
                        self.instructionLabel2.text = @"BLOCKPARTY ACTIVE";
                        self.instructionLabel3.hidden = YES;
                    } else { // blocker turned OFF in settings
                        self.settingsButton.hidden = NO;
                        self.instructionLabel2.hidden = NO;
                        NSString *enableBlockerString = @"";
                        #if TARGET_OS_UIKITFORMAC
                        enableBlockerString = @"Navigate to Safari ➝ Preferences ➝ Extensions";
                        #else
                        enableBlockerString = @"Navigate to Safari ➝ Content Blockers";
                        #endif
                        self.instructionLabel2.text = enableBlockerString;
                        self.instructionLabel3.hidden = NO;
                    }
                });
            }
        }];
    }
}

@end
