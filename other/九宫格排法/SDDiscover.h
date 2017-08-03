

#import <UIKit/UIKit.h>

@interface SDDiscover : UIView
@property (nonatomic, assign) CGFloat sd_height;
@property (nonatomic, assign) CGFloat sd_width;
@property (nonatomic, strong) NSArray *headerItemModelsArray;

@property (nonatomic, copy) void (^buttonClickedOperationBlock)(NSInteger index);

@end

// --------------------------SDDiscoverTableViewHeaderItemModel-----------

@interface SDDiscoverTableViewHeaderItemModel1 : NSObject

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *catid;
@property (nonatomic, copy) Class destinationControllerClass;

+ (instancetype)modelWithTitle:(NSString *)title imageName:(NSString *)imageName catid:(NSString *)catid destinationControllerClass:(Class)destinationControllerClass;

@end