//
//  EListViewMaker.h
//  EServiceSDK
//
//  Created by 葛少玉 on 23/1/19.
//  Copyright © 2019年 easy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface EListViewMaker : NSObject

@property(nonatomic,retain)NSArray<NSString *> *registerCell;
@property(nonatomic,retain)NSArray<NSString *> *registerNib;
@property(nonatomic,copy)NSString *(^reusableCellBlock)(NSIndexPath *indexPath);
@property(nonatomic,copy)NSInteger(^numberOfSectionsBlock)(id data);
@property(nonatomic,copy)NSInteger(^numberOfRowsInSectionBlock)(NSInteger section);
@property(nonatomic,copy)id(^cellDataBlock)(id view, NSIndexPath *indexPath);
@property(nonatomic,copy)void(^didSelectRowBlock)(id view, NSIndexPath *indexPath);

//关联view的e_handler
@property(nonatomic,copy)void(^cellClickEventBlock)(id data);

- (instancetype)initWithListView:(UIView *)listView;
- (NSString *)identifierAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSInteger)numberOfSections;

@end


@interface ETableViewMaker : EListViewMaker

@property(nonatomic,copy)CGFloat(^cellHeightBlock)(UITableView *tableView, NSIndexPath * indexPath);
@property(nonatomic,retain)NSArray<UITableViewRowAction *> *editActions;
@property(nonatomic,copy)void(^deleteActionBlock)(NSIndexPath * indexPath);
@property(nonatomic,assign)UITableViewCellEditingStyle editingStyle;
@property(nonatomic,assign)CGFloat rowHeight;
@property(nonatomic,assign)CGFloat headerHeight;

@end




@interface ECollectionViewMaker : EListViewMaker

@property(nonatomic,assign)UIEdgeInsets sectionInset;
@property(nonatomic,assign)CGSize itemSize;
@property(nonatomic,assign)CGSize itemSpacing;
@property(nonatomic,assign)UICollectionViewScrollDirection scrollDirection;

@property(nonatomic,copy)CGSize(^cellSizeBlock)(UICollectionView *collectionView, NSIndexPath * indexPath);

@end





NS_ASSUME_NONNULL_END
