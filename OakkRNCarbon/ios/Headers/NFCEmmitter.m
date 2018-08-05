//
//  NFCEmmitter.m
//  OakkRN
//
//  Created by Marcel McFall on 5/8/18.
//  Copyright © 2018 Oakk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NFCEmmitter.h"

@implementation NFCEmitter
  // To export a module named ModuleWithEmitter
  RCT_EXPORT_MODULE();
- (NSArray<NSString *> *)supportedEvents {
  return @[@"onSessionConnect"];
}
  @end
