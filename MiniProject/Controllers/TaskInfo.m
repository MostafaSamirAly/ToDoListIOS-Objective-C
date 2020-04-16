//
//  TaskInfo.m
//  MiniProject
//
//  Created by Mostafa Samir on 12/12/19.
//  Copyright © 2019 Mostafa Samir. All rights reserved.
//

#import "TaskInfo.h"

@interface TaskInfo ()
@property (weak, nonatomic) IBOutlet UILabel *nameInfo;
@property (weak, nonatomic) IBOutlet UILabel *priorityInfo;
@property (weak, nonatomic) IBOutlet UILabel *conditionInfo;
@property (weak, nonatomic) IBOutlet UILabel *reminderInfo;
@property (weak, nonatomic) IBOutlet UITextView *descInfo;

@property (weak, nonatomic) IBOutlet UILabel *reminderdesc;


@end

@implementation TaskInfo

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    _nameInfo.text = _namestr;
    _priorityInfo.text=_prioritystr;
    _conditionInfo.text = _conditionstr;
    _reminderInfo.text=_reminderstr;
    _descInfo.text = _descstr;
    _reminderdesc.text = _remdesc;
}

@end
