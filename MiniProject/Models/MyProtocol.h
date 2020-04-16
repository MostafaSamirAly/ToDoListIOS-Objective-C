//
//  MyProtocol.h
//  MiniProject
//
//  Created by Mostafa Samir on 12/12/19.
//  Copyright © 2019 Mostafa Samir. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ToDoTask.h"
NS_ASSUME_NONNULL_BEGIN

@protocol MyProtocol <NSObject>
-(void) addTask:(ToDoTask*)task;
-(void) editTask:(ToDoTask*)task;

@end

NS_ASSUME_NONNULL_END
