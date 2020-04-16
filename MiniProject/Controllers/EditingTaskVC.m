//
//  EditingTaskVC.m
//  MiniProject
//
//  Created by Mostafa Samir on 12/13/19.
//  Copyright © 2019 Mostafa Samir. All rights reserved.
//

#import "EditingTaskVC.h"

@interface EditingTaskVC ()
@property (weak, nonatomic) IBOutlet UITextView *editName;
@property (weak, nonatomic) IBOutlet UITextField *editPriority;
@property (weak, nonatomic) IBOutlet UITextField *editCondition;

@property (weak, nonatomic) IBOutlet UITextView *editDesc;

@property (weak, nonatomic) IBOutlet UIDatePicker *editReminder;

@property (strong, nonatomic) DownPicker *priorityDownPicker;
@property (strong, nonatomic) DownPicker *conditionDownPicker;
@property (weak, nonatomic) IBOutlet UITextField *reminderhrs;
@property (weak, nonatomic) IBOutlet UITextField *remstart;

@end

@implementation EditingTaskVC{
    UIAlertView *alert;
    NSString *eventId;
    ToDoTask *editedTask;
    ToDoTable *taskTable;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
}
- (void)viewWillAppear:(BOOL)animated{
    eventId =[NSString new];
    editedTask = [ToDoTask new];
    taskTable =[self.storyboard instantiateViewControllerWithIdentifier:@"ToDoTable"];
    _editName.text = _tsName;
    _editPriority.text = _tsPriority;
    _editDesc.text = _tsDesc;
    _editCondition.text = _tsCondition;
    eventId = _tsevent;
    
}
- (void)viewDidAppear:(BOOL)animated{
    self.priorityDownPicker = [[DownPicker alloc] initWithTextField:self.editPriority withData:prioritylist];
    self.conditionDownPicker = [[DownPicker alloc] initWithTextField:self.editCondition withData:conditionlist];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        editedTask.taskName = _editName.text;
        editedTask.taskDesc = _editDesc.text;
        editedTask.taskPriority = _editPriority.text;
        editedTask.taskCondition = _editCondition.text;
        editedTask.taskReminder = _editReminder.date;
        editedTask.savedEventId = eventId;
        [_editP editTask:editedTask];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)saveEditing:(id)sender {
    alert = [[UIAlertView alloc]initWithTitle:@"WARNING!" message:@"data will change" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Save",@"Cancel",nil];
    [alert show];
}
- (IBAction)editReminder:(id)sender {
    int hoursnum = 0;
    int reminderstrt=0;
    reminderstrt =[_remstart.text integerValue];
    hoursnum =[_reminderhrs.text integerValue];
    EKEventStore *store = [EKEventStore new];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (!granted) { return; }
        EKEvent *event = [EKEvent eventWithEventStore:store];
        event.title = self->_editName.text;
        event.startDate = [self->_editReminder.date dateByAddingTimeInterval:reminderstrt*60];
        event.endDate = [event.startDate dateByAddingTimeInterval:hoursnum*60*60];
        event.calendar = [store defaultCalendarForNewEvents];
        EKAlarm *alarm = [EKAlarm alarmWithRelativeOffset:-2.0f];
        [event addAlarm:alarm];
        NSError *err = nil;
        [store saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
        eventId = event.eventIdentifier;
    }];
}
- (IBAction)removeReminder:(id)sender {
    EKEventStore* store = [EKEventStore new];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (!granted) { return; }
        EKEvent* eventToRemove = [store eventWithIdentifier:eventId];
        if (eventToRemove) {
            NSError* error = nil;
            [store removeEvent:eventToRemove span:EKSpanThisEvent commit:YES error:&error];
        }
    }];
}


@end
