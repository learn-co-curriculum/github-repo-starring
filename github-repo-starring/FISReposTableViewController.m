//
//  FISReposTableViewController.m
//
//
//  Created by Joe Burgess on 5/5/14.
//
//

#import "FISReposTableViewController.h"
#import "FISReposDataStore.h"
#import "FISGithubRepository.h"
#import "FISGithubAPIClient.h"

@interface FISReposTableViewController ()
@property (strong, nonatomic) FISReposDataStore *dataStore;
@end

@implementation FISReposTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.accessibilityLabel=@"Repo Table View";
    self.tableView.accessibilityIdentifier=@"Repo Table View";
    
    self.tableView.accessibilityIdentifier = @"Repo Table View";
    self.tableView.accessibilityLabel=@"Repo Table View";
    self.dataStore = [FISReposDataStore sharedDataStore];
    [self.dataStore getRepositoriesWithCompletion:^(BOOL success) {
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            [self.tableView reloadData];
        }];
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.dataStore.repositories count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"basicCell" forIndexPath:indexPath];
    
    FISGithubRepository *repo = self.dataStore.repositories[indexPath.row];
    cell.textLabel.text = repo.fullName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FISGithubRepository *repo = self.dataStore.repositories[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.dataStore toggleStarForRepo:repo CompletionBlock:^(BOOL starred) {
        if (starred) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                NSString *message = [NSString stringWithFormat:@"You just starred %@", repo.fullName];
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Repo Starred" message:message preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:okAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }];
        } else
        {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                NSString *message = [NSString stringWithFormat:@"You just unstarred %@", repo.fullName];
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Repo Unstarred" message:message preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
                [alertController addAction:okAction];
                [self presentViewController:alertController animated:YES completion:nil];
            }];
        }
    }];
}

@end
