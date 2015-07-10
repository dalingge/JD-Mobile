//
//  iOS8.h
//  Drivers
//
//  Created by muxi on 15/2/4.
//  Copyright (c) 2015年 muxi. All rights reserved.
//
/*
 
 1.Too many arguments to function call, expected 0, have 2
 - Project - Build Settings - ENABLE_STRICT_OBJC_MSGSEND 将其设置为 NO
 
 2.导入pch文件
 (1)Building Setting中搜索pref
 (2)将Prefix Header的值设为 $(SRCROOT)/$(PRODUCT_NAME)/$(PRODUCT_NAME).pch
 
 
 3.sizeClass经验总结：
 
 （1）所有公用的控件要出现在**
 （2）所有公共的约束需要出现在**
 （2）所有的大块view，如果内部子控件的约束是固定的，约束需要写在**中。
 
 总结：在**中要指定大小，同时一般不指定位置，你可以手动拖动位置，便于查看，在其他详细界面再正确调整，这样多个sizeclass查看界面就不会显得很乱。
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 */
