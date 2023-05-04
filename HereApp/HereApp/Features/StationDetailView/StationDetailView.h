//
//  StationDetailView.h
//  HereApp
//
//  Created by Brent Crowley on 4/5/2023.
//

#ifndef StationDetailView_h
#define StationDetailView_h

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StationDetailView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (weak, nonatomic) IBOutlet UILabel *descLabel;
@property (weak, nonatomic) IBOutlet UITableView *departuresTableView;


@property (weak, nonatomic) id<UITableViewDelegate, UITableViewDataSource> parent;

@end
NS_ASSUME_NONNULL_END

#endif /* StationDetailView_h */
