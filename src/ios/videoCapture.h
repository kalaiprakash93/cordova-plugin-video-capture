#import <Cordova/CDV.h>

#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>
#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface videoCapture : CDVPlugin <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIPopoverController *popover;
}
@property (strong, nonatomic) NSURL *videoURL;
- (void)StartCamera:(CDVInvokedUrlCommand *)command;
@property (strong, nonatomic) UIViewController * viewcont;
@property (nonatomic, strong) NSString *callbackIdForImagePicker;
@property (nonatomic, retain) UIActivityIndicatorView *indicator;
@property (nonatomic, retain) UIView *overlay;

@end
