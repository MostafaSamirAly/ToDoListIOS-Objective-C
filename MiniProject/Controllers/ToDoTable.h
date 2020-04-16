//
//  ToDoTable.h
//  MiniProject
//
//  Created by Mostafa Samir on 12/12/19.
//  Copyright © 2019 Mostafa Samir. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToDoTable : UIViewController <UITableViewDelegate,UITableViewDataSource,MyProtocol>{
    
}
@property (weak, nonatomic) IBOutlet UITableView *tasksTable;


@end

NS_ASSUME_NONNULL_END
