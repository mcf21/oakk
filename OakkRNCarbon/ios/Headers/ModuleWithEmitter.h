//
//  ModuleWithEmitter.h
//  OakkRN
//
//  Created by Marcel McFall on 5/8/18.
//  Copyright © 2018 Oakk. All rights reserved.
//

#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>

@interface ModuleWithEmitter : RCTEventEmitter <RCTBridgeModule>
  
@end
