//
//  ToDoTask.m
//  MiniProject
//
//  Created by Mostafa Samir on 12/12/19.
//  Copyright © 2019 Mostafa Samir. All rights reserved.
//

#import "ToDoTask.h"

@implementation ToDoTask
- (void)encodeWithCoder:(NSCoder *)encoder {
    //Encode properties, other class variables, etc
    [encoder encodeObject:self.taskName forKey:@"name"];
    [encoder encodeObject:self.taskDesc forKey:@"desc"];
    [encoder encodeObject:self.taskPriority forKey:@"priority"];
    [encoder encodeObject:self.taskReminder forKey:@"reminder"];
    [encoder encodeObject:self.taskCondition forKey:@"condition"];
    [encoder encodeObject:self.savedEventId forKey:@"event"];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if((self = [super init])) {
        //decode properties, other class vars
        self.taskName = [decoder decodeObjectForKey:@"name"];
        self.taskDesc = [decoder decodeObjectForKey:@"desc"];
        self.taskPriority = [decoder decodeObjectForKey:@"priority"];
        self.taskReminder = [decoder decodeObjectForKey:@"reminder"];
        self.taskCondition = [decoder decodeObjectForKey:@"condition"];
        self.savedEventId = [decoder decodeObjectForKey:@"event"];
        
    }
    return self;
}
@end
