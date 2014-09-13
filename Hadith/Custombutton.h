//
//  Custombutton.h
//  Hadith
//
//  Created by Peerbits Solution on 07/09/12.
//  Copyright (c) 2012 peerbits@gmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Custombutton : UIButton{
    
    NSString *booktitle;
    NSMutableArray *hadithidarr;
    int indexvalue;

    
}
@property(nonatomic,retain) NSString *booktitle;
@property(nonatomic,retain) NSMutableArray *hadithidarr;
@property(nonatomic,assign) int indexvalue;

@end
