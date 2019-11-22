//
//  ELibsManager.h
//  ELibsManager
//
//  Created by 葛少玉 on 21/2/19.
//  Copyright © 2019年 easy. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for ELibsManager.
FOUNDATION_EXPORT double ELibsManagerVersionNumber;

//! Project version string for ELibsManager.
FOUNDATION_EXPORT const unsigned char ELibsManagerVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <ELibsManager/PublicHeader.h>


#import <ELibsManager/ELibsManagerHeader.h>
#import <ELibsManager/UIView+EHUD.h>
#import <ELibsManager/UIViewController+EHUD.h>
#import <ELibsManager/ENetworkManager.h>






/**
 
 pods 更新本地库:  pod repo update
 pods   配置
 {
     platform :ios, '8.0'
     workspace 'MainProject.xcworkspace'                 #指定workspace
     inhibit_all_warnings!                               #忽略警告
     use_frameworks!
 
     def commpod                                         #宏定义几个target都要用的的pod
     pod 'Masonry', '~> 1.1.0'
     pod 'MJRefresh', '~> 3.1.15.7'
     pod 'SDWebImage', '~> 5.0.0-beta5'
     pod 'AFNetworking', '~> 3.2.1'
     end
 
     target 'MainProject' do
     project 'MainProject'
     commpod
     end
 
     target 'ELibsManager' do
     project '../../ELibsManager/ELibsManager'
     commpod
     end
 }
 
 **/
