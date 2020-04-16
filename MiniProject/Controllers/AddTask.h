//
//  ViewController.h
//  MiniProject
//
//  Created by Mostafa Samir on 12/12/19.
//  Copyright © 2019 Mostafa Samir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIDownPicker.h>
#import <EventKit/EventKit.h>
#import "MyProtocol.h"
#import "ToDoTask.h"
#import "ToDoTable.h"
@interface AddTask : UIViewController <MyProtocol>{
    UIDownPicker *_dp1;
    UIDownPicker *_dp2;
    NSMutableArray *prioritylist;
    NSMutableArray *conditionlist;

}
@property id <MyProtocol> P;
@end

