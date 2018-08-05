//
//  ReactTree.h
//  OakkRN
//
//  Created by Marcel McFall on 5/8/18.
//  Copyright © 2018 Oakk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "React/RCTBridgeModule.h"

@interface RCT_EXTERN_MODULE(ReactTree, NSObject)

RCT_EXTERN_METHOD(printJS:(NSString *) string)

@end
