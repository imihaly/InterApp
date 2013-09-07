//
//  MasterViewController.h
//  IATodo
//
//  Created by Imre Mihaly on 9/6/13.
//  Copyright (c) 2013 Imre Mihaly. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;

- (void)insertTodoItem:(id)item;

@end
