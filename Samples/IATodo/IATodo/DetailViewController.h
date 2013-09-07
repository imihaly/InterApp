//
//  DetailViewController.h
//  IATodo
//
//  Created by Imre Mihaly on 9/6/13.
//  Copyright (c) 2013 Imre Mihaly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
