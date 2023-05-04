//
//  StationDetailView.m
//  HereApp
//
//  Created by Brent Crowley on 4/5/2023.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "StationDetailView.h"
#import <QuartzCore/QuartzCore.h>

@interface StationDetailView()

@end
@implementation StationDetailView

- (void)setParent:(id<UITableViewDelegate, UITableViewDataSource>)parent {
    _parent = parent;
        
    self.departuresTableView.delegate = _parent;
    self.departuresTableView.dataSource = _parent;
}

@end
