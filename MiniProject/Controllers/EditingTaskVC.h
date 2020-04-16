//
//  EditingTaskVC.h
//  MiniProject
//
//  Created by Mostafa Samir on 12/13/19.
//  Copyright © 2019 Mostafa Samir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIDownPicker.h>
#import "MyProtocol.h"
#import "ToDoTable.h"
#import "ToDoTask.h"
#import <EventKit/EventKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface EditingTaskVC : UIViewController<MyProtocol>{
    UIDownPicker *_dp1;
    UIDownPicker *_dp2;
    NSMutableArray *prioritylist;
    NSMutableArray *conditionlist;
}

@property NSString *tsName , *tsDesc , *tsCondition , *tsPriority,*tsevent;
@property NSData *tsReminder;
@property id <MyProtocol> editP;

@end

NS_ASSUME_NONNULL_END
