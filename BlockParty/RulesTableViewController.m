//
//  RulesTableViewController.m
//  BlockParty
//
//  Created by Krishna Kumar on 5/08/2015.
//  Copyright © 2015 Krishna Kumar. All rights reserved.
//

#import "RulesTableViewController.h"
#import "BlockerRule.h"

@interface RulesTableViewController ()
@property (nonatomic, strong)NSArray *blockerRules;
@end

@implementation RulesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadRules];
    UIButton *button2 =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setImage:[UIImage imageNamed:@"raw"] forState:UIControlStateNormal];
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

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)loadRules {
    
    id data = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"blockerList" withExtension:@"json"]] options:NSJSONReadingAllowFragments error:nil];
    
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

    NSString *filepath = [[NSBundle mainBundle] pathForResource:@"blockerList" ofType:@"json"];
    NSError *error;
    NSString *fileContents = [NSString stringWithContentsOfFile:filepath encoding:NSUTF8StringEncoding error:&error];
    
    if (error)
        NSLog(@"Error reading json file: %@", error.localizedDescription);
    
    if (fileContents!=nil) {
        UIViewController *jsonViewController = [[UIViewController alloc] init];
        jsonViewController.view.backgroundColor = [UIColor whiteColor];

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
