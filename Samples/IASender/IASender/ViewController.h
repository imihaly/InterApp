//
//  ViewController.h
//  IASender
//
//  Created by Imre Mihaly on 9/6/13.
//  Copyright (c) 2013 Imre Mihaly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property(nonatomic, assign) IBOutlet UITextField *textField;
- (IBAction)send:(id)sender;
- (IBAction)alert:(id)sender;
@end
