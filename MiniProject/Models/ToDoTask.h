//
//  ToDoTask.h
//  MiniProject
//
//  Created by Mostafa Samir on 12/12/19.
//  Copyright © 2019 Mostafa Samir. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToDoTask : NSObject<NSCoding>

@property NSString *taskName , *taskPriority , *taskDesc , *taskCondition,*savedEventId;
@property NSDate *taskReminder;

@end

NS_ASSUME_NONNULL_END
