#import <Foundation/Foundation.h>
#import "KeyboardBrightnessClient.h"
#import <IOKit/IOMessage.h>
#import <IOKit/pwr_mgt/IOPMLib.h>

static io_connect_t root_port;
static IONotificationPortRef notifyPortRef;
static io_object_t notifierObject;
KeyboardBrightnessClient *brightnessClient;

void fix() {
    if ([brightnessClient brightnessForKeyboard:1] < 1.0) {
        [brightnessClient setBrightness:1.0 forKeyboard:1];
    }
}

void callback(void *refCon, io_service_t service, natural_t messageType, void *messageArgument) {
    switch (messageType) {
        case kIOMessageSystemWillSleep:
            IOAllowPowerChange(root_port, (long)messageArgument);
            break;
        case kIOMessageCanSystemSleep:
            IOAllowPowerChange(root_port, (long)messageArgument);
            break;
        case kIOMessageSystemHasPoweredOn:
            fix();
            break;
        default:
            break;
    }
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSBundle *coreBrightness = [NSBundle bundleWithPath:@"/System/Library/PrivateFrameworks/CoreBrightness.framework"];
        [coreBrightness load];

        brightnessClient = [[NSClassFromString(@"KeyboardBrightnessClient") alloc] init];

        root_port = IORegisterForSystemPower(NULL, &notifyPortRef, callback, &notifierObject);
        if (!root_port) {
            return EXIT_FAILURE;
        }

        CFRunLoopSourceRef runLoopSource = IONotificationPortGetRunLoopSource(notifyPortRef);
        CFRunLoopAddSource(CFRunLoopGetCurrent(), runLoopSource, kCFRunLoopCommonModes);
        CFRunLoopRun();
    }
    return 0;
}