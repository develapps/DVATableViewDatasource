//
//  UITableView+Downloading.m
//  GastroGuia
//
//  Created by Rafa Barberá on 24/04/15.
//  Copyright (c) 2015 develapps. All rights reserved.
//

#import "UITableView+Downloading.h"

@implementation UITableView (Downloading)

- (void)dva_showDownloadProgressIndicator {
    if (self.tableFooterView && self.tableFooterView.tag != 0xBADF00D) {
        return;
    }
    UIActivityIndicatorView *downloading = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    downloading.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds),60);
    [downloading startAnimating];
    self.tableFooterView = downloading;
}

- (void)dva_hideDownloadProgressIndicator {
    if (self.tableFooterView && self.tableFooterView.tag != 0xBADF00D) {
        self.tableFooterView = [UIView new];
        self.tableFooterView.tag = 0xBADF00D;
    }
}

@end
