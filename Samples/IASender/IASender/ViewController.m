//
//  ViewController.m
//  IASender
//
//  Created by Imre Mihaly on 9/6/13.
//  Copyright (c) 2013 Imre Mihaly. All rights reserved.
//

#import "ViewController.h"
#import "IAServiceManager.h"

@protocol TodoApp <NSObject>

- (id)addItem:(id)item;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[[IAServiceManager sharedManager] registerService:self forSelector:@"alert://show"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)send:(id)sender {
	if(self.textField.text.length == 0) return;
	[[[IAServiceManager sharedManager] proxyToService:@"todo://list"] addItem:self.textField.text];
}

- (IBAction)alert:(id)sender {
	if(self.textField.text.length == 0) return;
	[[[IAServiceManager sharedManager] proxyToService:@"alert://show"] presentAlert:self.textField.text];
}

#pragma mark - service interface

- (id)presentAlert:(id)text {
	UIAlertView *av = [[UIAlertView alloc] initWithTitle:nil message:text delegate:nil cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
	[av show];
	return @YES;
}

@end
