#import <UIKit/UIKit.h>
#import "WSStarRatingView.h"


//@protocol CustomCellDelegate <NSObject>
//
//- (void)pushToNewPage;
//
//@end

@interface DengDaiPpTableViewCell : UITableViewCell<StarRatingViewDelegate>

@property (nonatomic ,strong)NSDictionary *dict;
//@property (nonatomic ,assign)id<CustomCellDelegate>Delgete;

//@property (nonatomic,strong)WSStarRatingView *wsStraRating;
@property (nonatomic,strong)UILabel *scoreLabel;
@property (nonatomic ,strong)NSDictionary *plane_name;

@end
