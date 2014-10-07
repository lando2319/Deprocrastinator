//
//  ViewController.m
//  Deprocrastinator
//
//  Created by Adam Cooper on 10/6/14.
//  Copyright (c) 2014 Adam Cooper. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textBox;
@property NSMutableArray *listArray;
@property (weak, nonatomic) IBOutlet UITableView *tableViewToDo;
@property BOOL isDone;

@end

@implementation ViewController 

- (void)viewDidLoad {
    [super viewDidLoad];

    self.listArray = [NSMutableArray array];

    self.isDone = NO;

    NSLog(@"%@", self.textBox);


}


- (IBAction)prioritySwipe:(UISwipeGestureRecognizer *)sender {
    UITableViewCell *cell = (UITableViewCell *)sender.view;
    cell.textLabel.backgroundColor = [UIColor redColor];

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {


    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"deprocrastinatorCell" forIndexPath:indexPath];
    cell.textLabel.text = [self.listArray objectAtIndex:indexPath.row];

    return cell;

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{


    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell.accessoryType == UITableViewCellAccessoryNone)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [tableView deselectRowAtIndexPath:indexPath animated:YES];

    }

    if (self.isDone == YES)
    {
        [self.listArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
    }

    [tableView reloadData];

}

- (IBAction)onSwipe:(UISwipeGestureRecognizer *)swiper
{

    NSLog(@"go time");

}





- (IBAction)onAddButtonPressed:(id)sender {
    [self.listArray addObject: self.textBox.text];

    self.textBox.text = @"";
    [self.tableViewToDo reloadData];


}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {

        [self.listArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableViewToDo reloadData];
    }
}


- (IBAction)onEditPressed:(UIButton *)editButton {


    if ([editButton.titleLabel.text isEqualToString:@"Edit"])
    {
        [editButton setTitle:@"Done" forState: normal];
    }else {
        [editButton setTitle:@"Edit" forState: normal];
    }

    self.isDone = !self.isDone;
}

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *button = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"     " handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                    {
                                        NSLog(@"Action to perform with Button 1");
                                    }];
    button.backgroundColor = [UIColor greenColor]; //arbitrary color
    UITableViewRowAction *button2 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"     " handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                     {
                                         NSLog(@"Action to perform with Button2!");
                                     }];
    button2.backgroundColor = [UIColor blueColor]; //arbitrary color

    UITableViewRowAction *button3 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Delete" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath)
                                     {
                                         [self.listArray removeObjectAtIndex:indexPath.row];
                                         [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                                         [self.tableViewToDo reloadData];
                                     }];
    button3.backgroundColor = [UIColor redColor]; //arbitrary color

    return @[button, button2, button3]; //array with all the buttons you want. 1,2,3, etc...
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES; //tableview must be editable or nothing will work...
}






@end
