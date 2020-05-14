//
//  ToDoTable.m
//  MiniProject
//
//  Created by Mostafa Samir on 12/12/19.
//  Copyright © 2019 Mostafa Samir. All rights reserved.
//

#import "ToDoTable.h"
#import "AddTask.h"
#import "ToDoTask.h"
#import "TaskInfo.h"
#import "EditingTaskVC.h"

@interface ToDoTable ()
@property (strong, nonatomic) IBOutlet UISearchBar *search;

@end

@implementation ToDoTable{
    UIAlertView *alert;
    NSMutableArray *todo;
    NSMutableArray *filtered;
    int deleteFlag;
    int deleteIndex;
    AddTask *VC;
    TaskInfo *info;
    EditingTaskVC *tskedit;
    ToDoTask *initial;
    NSMutableArray *archieve;
    int editedTaskIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    filtered = [NSMutableArray new];
    todo = [NSMutableArray new];
    initial = [ToDoTask new];
    initial.taskName =@"initial";
    VC =[self.storyboard instantiateViewControllerWithIdentifier:@"AddTask"];
    info =[self.storyboard instantiateViewControllerWithIdentifier:@"TaskInfo"];
    tskedit =[self.storyboard instantiateViewControllerWithIdentifier:@"EditingTaskVC"];
    [VC setP:self];
    [tskedit setEditP:self];
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    if([[def objectForKey:@"a"] count] != 0){
        NSMutableArray *retrieved = [def objectForKey:@"a"];
        for (int i =0 ; i<[[def objectForKey:@"a"]count]; i++) {
            [todo addObject:[NSKeyedUnarchiver unarchiveObjectWithData:[retrieved objectAtIndex:i]]];
        }
    }
    else{
        [todo addObject:initial];
    }
    filtered =todo;


}
- (void)viewWillAppear:(BOOL)animated{
    [_tasksTable reloadData];
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [[filtered objectAtIndex:indexPath.row] taskName];
    cell.accessoryType= UITableViewCellAccessoryDetailButton;
    if([[[filtered objectAtIndex:indexPath.row] taskPriority] isEqualToString:@"High"]){
         cell.imageView.image =[UIImage imageNamed:@"1.png"] ;
    }
    else if([[[filtered objectAtIndex:indexPath.row] taskPriority] isEqualToString:@"Medium"]){
         cell.imageView.image =[UIImage imageNamed:@"2.png"] ;
    }
    else  {
        cell.imageView.image =[UIImage imageNamed:@"3.png"] ;
    }
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return [filtered count];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    NSString *header = @"ToDo List";
    return header;
}
- (IBAction)addBtnPressed:(id)sender {
    [self.navigationController pushViewController:VC animated:YES];
}
-(void) addTask:(ToDoTask*)task{
    
        [todo addObject:task];

    
}
-(void) editTask:(ToDoTask*)task{
    [todo replaceObjectAtIndex:editedTaskIndex withObject:task];
    
}



- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    NSString *result = [formatter stringFromDate:[[todo objectAtIndex:indexPath.row] taskReminder]];
    
    info.namestr = [[todo objectAtIndex:indexPath.row] taskName];
    info.descstr = [[todo objectAtIndex:indexPath.row] taskDesc];
    info.reminderstr =result;
    info.prioritystr =[[todo objectAtIndex:indexPath.row] taskPriority];
    info.conditionstr=[[todo objectAtIndex:indexPath.row] taskCondition];
    info.remdesc = [[todo objectAtIndex:indexPath.row] savedEventId];
    [self.navigationController pushViewController:info animated:YES];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    deleteFlag = 1;
    deleteIndex = indexPath.row;
    alert = [[UIAlertView alloc]initWithTitle:@"WARNING!" message:@" DATA WILL BE DELETED!!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",@"Cancel",nil];
    [alert show];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    editedTaskIndex = indexPath.row;
    tskedit.tsName = [[todo objectAtIndex:indexPath.row] taskName];
    tskedit.tsDesc = [[todo objectAtIndex:indexPath.row] taskDesc];
    tskedit.tsReminder =[[todo objectAtIndex:indexPath.row] taskReminder];
    tskedit.tsPriority =[[todo objectAtIndex:indexPath.row] taskPriority];
    tskedit.tsCondition=[[todo objectAtIndex:indexPath.row] taskCondition];
    tskedit.tsevent = [[todo objectAtIndex:indexPath.row] savedEventId];
    [self.navigationController pushViewController:tskedit animated:YES];
}

- (void) viewWillDisappear:(BOOL)animated {
    archieve = [[NSMutableArray alloc]initWithCapacity:[todo count]];
    NSData *encodedObject=[NSData new];
    for(int i=0 ; i<[todo count];i++)
    {
        encodedObject  = [NSKeyedArchiver archivedDataWithRootObject:[todo objectAtIndex:i]] ;
        [archieve addObject:encodedObject];
    }
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:archieve forKey:@"a"];


}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if (searchText.length == 0) {
        filtered =todo;
        [self.search endEditing:YES];
        
    }
    
    else {
        filtered =[NSMutableArray new];
        for (int i=0 ; i<[todo count];i++) {
            
            NSRange range = [[[todo objectAtIndex:i] taskName] rangeOfString:searchText options:NSCaseInsensitiveSearch];
            
            if (range.location != NSNotFound) {
                
                [filtered addObject:[todo objectAtIndex:i]];
                
            }
        }
        
    }
    
    [_tasksTable reloadData];
    
}

- (IBAction)deleteAll:(id)sender {
    deleteFlag = 2;
    alert = [[UIAlertView alloc]initWithTitle:@"WARNING!" message:@" DATA WILL BE DELETED!!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK",@"Cancel",nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        if(deleteFlag==2){
            [todo removeAllObjects];
            [_tasksTable reloadData];
        }
        else{
            [todo removeObjectAtIndex:deleteIndex];
            [_tasksTable reloadData];
        }
        
    }
}



@end
