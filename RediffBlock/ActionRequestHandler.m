//
//  ActionRequestHandler.m
//  RediffBlock
//
//  Created by Krishna Kumar on 6/26/15.
//  Copyright © 2015 Krishna Kumar. All rights reserved.
//

#import "ActionRequestHandler.h"

@interface ActionRequestHandler ()

@end

@implementation ActionRequestHandler

- (void)beginRequestWithExtensionContext:(NSExtensionContext *)context {
    NSItemProvider *attachment = [[NSItemProvider alloc] initWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"blockerList" withExtension:@"json"]];
    
    NSExtensionItem *item = [[NSExtensionItem alloc] init];
    item.attachments = @[attachment];
    
    [context completeRequestReturningItems:@[item] completionHandler:nil];
}

@end
