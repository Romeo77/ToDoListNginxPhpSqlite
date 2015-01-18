//
//  TodoTableViewController.m
//  ToDoListNginxPhpSql
//
//  Created by Roman on 16.01.15.
//  Copyright (c) 2015 Roman. All rights reserved.
//

#import "TodoTableViewController.h"

@interface TodoTableViewController ()
@property (nonatomic, strong) NSMutableArray *todoDataSource;
@end

@implementation TodoTableViewController

- (void)viewDidLoad {
    self.todoDataSource = [[NSMutableArray alloc]init];
    [self linkServer];
}

-(void) linkServer {
    NSDictionary *json = [LinkWithServer linkWithServerTodos:@"GET" :@"" :@""];
    [self loadData:json];
}

- (void)loadData :(NSDictionary*)json{
    NSArray* length = [json allValues];
    NSString *indexJson;
    if(self.todoDataSource.count >0)
        [self.todoDataSource removeAllObjects];
    
    for (int i = 0; i < length.count; i++) {
        indexJson = [NSString stringWithFormat:@"%d", i];
        [self.todoDataSource addObject:[[json objectForKey:indexJson]objectForKey :@"todo"]];
    }
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)alertView :(NSString*)title :(NSString*)message :(NSString*)buttonTitles :(NSInteger)index :(NSString*)method :(NSString*)indexPathUpdate
{
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:buttonTitles, nil];
    av.alertViewStyle = UIAlertViewStylePlainTextInput;
    if([buttonTitles isEqualToString:@"Update"])
        [av textFieldAtIndex:0].text = self.todoDataSource[index];
    [av show];
    
    av.tapBlock = ^(UIAlertView *av, NSInteger buttonIndex)
    {
        if (buttonIndex == av.cancelButtonIndex) return;
        if ([av textFieldAtIndex:0].text.length < 1) {
            UIMsg(@"Please provide todo input");
            //[self alertView :title :message :buttonTitles :index :method :indexPathUpdate];
            return;
        }
        NSDictionary *json = [LinkWithServer linkWithServerTodos:method :[av textFieldAtIndex:0].text :indexPathUpdate];
        [self loadData:json];
    };
}

- (IBAction)btnAddTodoTapped:(id)sender
{
    [self alertView:@"Add ToDo" :@"Please enter todo item text" :@"Add" :0 :@"POST" :@""];
}

- (IBAction)btnLogoutTapped:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:notificationLogout object:nil];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.todoDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"todoCell" forIndexPath:indexPath];
    cell.textLabel.text = self.todoDataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *json = [LinkWithServer linkWithServerTodos:@"DELETE" :[NSString stringWithFormat:@"%ld",(long)indexPath.row] :@""];
    [self loadData:json];
}

- (void )tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self alertView:@"Update ToDo" :@"Please update todo item text" :@"Update" :indexPath.row :@"PUT" :[NSString stringWithFormat:@"%ld",(long)indexPath.row]];
}

@end
