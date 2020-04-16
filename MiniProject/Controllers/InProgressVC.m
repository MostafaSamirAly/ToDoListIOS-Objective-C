//
//  InProgressVC.m
//  MiniProject
//
//  Created by Mostafa Samir on 12/13/19.
//  Copyright © 2019 Mostafa Samir. All rights reserved.
//

#import "InProgressVC.h"

@interface InProgressVC ()
@property (weak, nonatomic) IBOutlet UITableView *inprogressTable;

@end

@implementation InProgressVC{
    NSMutableArray *allTasks;
    NSMutableArray *inProgressTasks;
    TaskInfo *info;

}

- (void)viewDidLoad {
    [super viewDidLoad];

}
- (void)viewWillAppear:(BOOL)animated{
    info = [self.storyboard instantiateViewControllerWithIdentifier:@"TaskInfo"];
    allTasks = [NSMutableArray new];
    inProgressTasks = [NSMutableArray new];
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    if([[def objectForKey:@"a"] count] != 0){
        NSMutableArray *retrieved = [def objectForKey:@"a"];
        for (int i =0 ; i<[[def objectForKey:@"a"]count]; i++) {
            [allTasks addObject:[NSKeyedUnarchiver unarchiveObjectWithData:[retrieved objectAtIndex:i]]];
        }
    }
    for (int i =0 ; i<[allTasks count]; i++) {
        if ([[[allTasks objectAtIndex:i] taskCondition ]isEqualToString:@"InProgress"]) {
            [inProgressTasks addObject:[allTasks objectAtIndex:i]];
        }
    }
    [_inprogressTable reloadData];
}




- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"inProgressCell" forIndexPath:indexPath];
    cell.textLabel.text = [[inProgressTasks objectAtIndex:indexPath.row] taskName];
    cell.accessoryType= UITableViewCellAccessoryDetailButton;
    if([[[inProgressTasks objectAtIndex:indexPath.row] taskPriority] isEqualToString:@"High"]){
        cell.imageView.image =[UIImage imageNamed:@"1.png"] ;
    }
    else if([[[inProgressTasks objectAtIndex:indexPath.row] taskPriority] isEqualToString:@"Medium"]){
        cell.imageView.image =[UIImage imageNamed:@"2.png"] ;
    }
    else  {
        cell.imageView.image =[UIImage imageNamed:@"3.png"] ;
    }
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [inProgressTasks count];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *header = @"InProgress List";
    return header;
}
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *result = [formatter stringFromDate:[[inProgressTasks objectAtIndex:indexPath.row] taskReminder]];
    
    info.namestr = [[inProgressTasks objectAtIndex:indexPath.row] taskName];
    info.descstr = [[inProgressTasks objectAtIndex:indexPath.row] taskDesc];
    info.reminderstr =result;
    info.prioritystr =[[inProgressTasks objectAtIndex:indexPath.row] taskPriority];
    info.conditionstr=[[inProgressTasks objectAtIndex:indexPath.row] taskCondition];
    info.remdesc = [[inProgressTasks objectAtIndex:indexPath.row] savedEventId];
    [self.navigationController pushViewController:info animated:YES];
}
    @end
    
