#import "FlutterId3ReaderPlugin.h"
#if __has_include(<flutter_id3_reader/flutter_id3_reader-Swift.h>)
#import <flutter_id3_reader/flutter_id3_reader-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_id3_reader-Swift.h"
#endif

@implementation FlutterId3ReaderPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterId3ReaderPlugin registerWithRegistrar:registrar];
}
@end