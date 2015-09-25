//
//  UIDeviceHelper.h
//  BlockParty
//
//  Created by Krishna Kumar on 17/09/2015.
//  Copyright © 2015 Krishna Kumar. All rights reserved.
//

#ifndef UIDeviceHelper_h
#define UIDeviceHelper_h

#define IS_IPHONE_4 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)480) < DBL_EPSILON)
#define IS_IPHONE_5 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)568) < DBL_EPSILON)
#define IS_IPHONE_6 (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)667) < DBL_EPSILON)
#define IS_IPHONE_6_PLUS (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)736) < DBL_EPSILON)


#endif /* UIDeviceHelper_h */
