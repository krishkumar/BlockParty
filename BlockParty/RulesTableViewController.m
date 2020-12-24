//
//  RulesTableViewController.m
//  BlockParty
//
//  Created by Krishna Kumar on 5/08/2015.
//  Copyright © 2015 Krishna Kumar. All rights reserved.
//

#import "RulesTableViewController.h"
#import "BlockerRule.h"
#import "BlockPartyConstants.h"

@interface RulesTableViewController ()
@property (nonatomic, strong)NSArray *blockerRules;
@end

@implementation RulesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadRules];
    UIImage *docImage = [UIImage systemImageNamed:@"doc.plaintext"];
    UIButton *button2 =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setImage:docImage forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(rightButtonAction)forControlEvents:UIControlEventTouchUpInside];
    [button2 setFrame:CGRectMake(0, 0, 30, 22)];
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithCustomView:button2];
    [self.navigationItem setRightBarButtonItems:@[rightBarButton]];
}

- (void)rightButtonAction {
    [self showJSON];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.blockerRules count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    BlockerRule *rule = [self.blockerRules objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = rule.urlFilter;
    cell.textLabel.text = rule.actionType;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)loadRules {
    
    id data;
    NSString *contentOfURL;
    if ([APP_DEFAULT_BLOCKS_URL length] != 0) {
        NSError *error;
        NSURL *url = [NSURL URLWithString:APP_DEFAULT_BLOCKS_URL];
        contentOfURL = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
        if (error)
            NSLog(@"Error reading remote json file: %@", error.localizedDescription);
    }
    
    NSError *error;
    NSData *nsdata;
    if (contentOfURL != (id)[NSNull null] && contentOfURL.length != 0) {
        nsdata = [contentOfURL dataUsingEncoding:NSUTF8StringEncoding];
    } else {
        NSLog(@"URL not defined or accessible - using local JSON");
        nsdata = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:APP_DEFAULT_BLOCKS_FILE withExtension:@"json"]];
    }
    data = [NSJSONSerialization JSONObjectWithData:nsdata options:NSJSONReadingAllowFragments error:&error];
    
    if (error)
        NSLog(@"Error reading json file: %@", error.localizedDescription);
    
    if (data!=nil) {
        NSArray *rulesArray = (NSArray *)data;
        NSMutableArray *tempRules = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dic in rulesArray) {
            BlockerRule *rule = [[BlockerRule alloc] initWithDictionary:dic];
            [tempRules addObject:rule];
        }
        
        self.blockerRules = [[NSArray alloc] initWithArray:tempRules];
    }
    else {
        NSLog(@"Data is nil");
    }
    
}

- (void)showJSON
{

    NSString *fileContents;
    if ([APP_DEFAULT_BLOCKS_URL length] != 0) {
        NSError *error;
        NSURL *url = [NSURL URLWithString:APP_DEFAULT_BLOCKS_URL];
        fileContents = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
        if (error)
            NSLog(@"Error reading remote json file: %@", error.localizedDescription);
    }
    if (fileContents == (id)[NSNull null] || fileContents.length == 0) {
        NSLog(@"URL not defined or accessible - using local JSON");
        NSError *error;
        NSString *filepath = [[NSBundle mainBundle] pathForResource:APP_DEFAULT_BLOCKS_FILE ofType:@"json"];
        fileContents = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:&error];
        if (error)
            NSLog(@"Error reading json file: %@", error.localizedDescription);
    }
    
    if (fileContents!=nil) {
        UIViewController *jsonViewController = [[UIViewController alloc] init];
        jsonViewController.view.backgroundColor = [UIColor systemBackgroundColor];

        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 65, self.view.frame.size.width, self.view.frame.size.height)];
        textView.translatesAutoresizingMaskIntoConstraints = NO;
        textView.text = fileContents;
        textView.editable = NO;
        
        if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad)
            textView.font = [UIFont fontWithName:@"Menlo" size:18.0];
        else
            textView.font = [UIFont fontWithName:@"Menlo" size:12.0];
        
        [jsonViewController.view addSubview:textView];
        
        [self showViewController:jsonViewController sender:self];
    }
}

@end
