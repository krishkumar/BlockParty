//
//  BlockerRule.m
//  BlockParty
//
//  Created by Krishna Kumar on 5/08/2015.
//  Copyright © 2015 Krishna Kumar. All rights reserved.
//

#import "BlockerRule.h"

@implementation BlockerRule

-(id) initWithUrlFilter:(NSString*) urlFilter actionType:(NSString *)actionType actionSelector:(NSString *)actionSelector {
    self = [super init];
    if (self) {
        self.urlFilter = urlFilter;
        self.actionType = actionType;
        self.actionSelector = actionSelector;
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)dic {
    
    // Here's the syntax on writing rules
    // https://www.webkit.org/blog/3476/content-blockers-first-look/
    
    self = [self initWithUrlFilter:dic[@"trigger"][@"url-filter"] actionType:dic[@"action"][@"type"] actionSelector:dic[@"action"][@"selector"]] ;
    return self;
}

@end
