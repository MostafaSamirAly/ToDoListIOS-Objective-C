//
//  ViewController.m
//  MiniProject
//
//  Created by Mostafa Samir on 12/12/19.
//  Copyright © 2019 Mostafa Samir. All rights reserved.
//

#import "AddTask.h"

@interface AddTask ()
@property (weak, nonatomic) IBOutlet UITextField *priorityDropField;

@property (strong, nonatomic) DownPicker *priorityDownPicker;

@property (weak, nonatomic) IBOutlet UITextField *conditionDropField;
@property (strong, nonatomic) DownPicker *conditionDownPicker;
@property (weak, nonatomic) IBOutlet UITextField *taskName;
@property (weak, nonatomic) IBOutlet UITextView *taskDesc;
@property (weak, nonatomic) IBOutlet UIDatePicker *taskDate;
@property (weak, nonatomic) IBOutlet UITextField *reminderEnd;
@property (weak, nonatomic) IBOutlet UITextField *reminderStart;

@end

@implementation AddTask{
    UIAlertView *alert;
    ToDoTask *addedTask;
    NSMutableArray *todoArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    prioritylist =[NSMutableArray new];
    [prioritylist addObject:@"High"];
    [prioritylist addObject:@"Medium"];
    [prioritylist addObject:@"Low"];
    
    conditionlist =[NSMutableArray new];
    [conditionlist addObject:@"ToDo"];
    [conditionlist addObject:@"InProgress"];
    [conditionlist addObject:@"Done"];
    
    _dp1 = [[UIDownPicker alloc] initWithData:prioritylist];
    [self.view addSubview:_dp1];
    _dp2 = [[UIDownPicker alloc] initWithData:conditionlist];
    [self.view addSubview:_dp2];
    todoArray =[NSMutableArray new];
}
- (void)viewWillAppear:(BOOL)animated{
    
    addedTask =[ToDoTask new];
}
- (void)viewDidAppear:(BOOL)animated{
     self.priorityDownPicker = [[DownPicker alloc] initWithTextField:self.priorityDropField withData:prioritylist];
     self.conditionDownPicker = [[DownPicker alloc] initWithTextField:self.conditionDropField withData:conditionlist];
}
- (IBAction)addTask:(id)sender {
    alert = [[UIAlertView alloc]initWithTitle:@"WARNING!" message:@"Add new task?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Ok",@"Cancel",nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        addedTask.taskName = _taskName.text;
        addedTask.taskDesc = _taskDesc.text;
        addedTask.taskPriority = _priorityDropField.text;
        addedTask.taskCondition = _conditionDropField.text;
        addedTask.taskReminder = _taskDate.date;
        _taskName.text = @"";
        _taskDesc.text =@"";
        _reminderStart.text=@"";
        _reminderEnd.text=@"";
        [_P addTask:addedTask];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (IBAction)addReminder:(id)sender {
    int hoursEnd=0;
    int hoursStart=0;
    hoursStart=[_reminderStart.text doubleValue];
    hoursEnd =[_reminderEnd.text doubleValue];
    EKEventStore *store = [EKEventStore new];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (!granted) { return; }
        EKEvent *event = [EKEvent eventWithEventStore:store];
        event.title = self->_taskName.text;
        event.startDate = [self->_taskDate.date dateByAddingTimeInterval:hoursStart*60*60];
        event.endDate = [event.startDate dateByAddingTimeInterval:hoursEnd*60*60];
        EKAlarm *alarm = [EKAlarm alarmWithRelativeOffset:-2.0f];
        [event addAlarm:alarm];
        event.calendar = [store defaultCalendarForNewEvents];
        NSError *err = nil;
        [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
        self->addedTask.savedEventId = event.eventIdentifier;
    }];
}
- (IBAction)removeReminder:(id)sender {
    EKEventStore* store = [EKEventStore new];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (!granted) { return; }
        EKEvent* eventToRemove = [store eventWithIdentifier:self->addedTask.savedEventId];
        if (eventToRemove) {
            NSError* error = nil;
            [store removeEvent:eventToRemove span:EKSpanThisEvent commit:YES error:&error];
        }
    }];
}

@end
