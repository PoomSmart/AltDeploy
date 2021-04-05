//
//  ALTAddAppleIDViewController.m
//  AltDeploy
//
//  Created by Darwin on 1/9/20.
//  Copyright © 2020 PixelOmer. All rights reserved.
//

#import "ALTAddAppleIDViewController.h"
#import "ALTAppleIDManager.h"

@implementation ALTAddAppleIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self controlTextDidChange:(_Nonnull id)nil];
    self.usernameField.delegate = self.passwordField.delegate = self;
}

- (void)controlTextDidChange:(NSNotification *)notif {
	self.saveButton.enabled = (self.usernameField.stringValue.length && self.passwordField.stringValue.length);
}

- (IBAction)didClickButton:(NSButton *)sender {
    if (!self.usernameField.stringValue.length || !self.passwordField.stringValue.length) {
        return;
    }
    NSError *error;
    [[ALTAppleIDManager sharedManager] addAppleID:self.usernameField.stringValue password:self.passwordField.stringValue error:&error];
    [self.view.window close];
    [self.delegate didAddAppleID];
    if (error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSAlert *alert = [NSAlert alertWithError:error];
            [alert addButtonWithTitle:@"Dismiss"];
            [alert runModal];
        });
    }
}

@end
