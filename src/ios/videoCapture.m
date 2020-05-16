#import "videoCapture.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

#if defined(__IPHONE_10_0) && __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
@import UserNotifications;
#endif

#ifndef NSFoundationVersionNumber_iOS_9_x_Max
#define NSFoundationVersionNumber_iOS_9_x_Max 1299
#endif

@implementation videoCapture
@synthesize indicator = _indicator;
@synthesize overlay = _overlay;

- (void)StartCamera:(CDVInvokedUrlCommand *)command {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeMovie, nil];
        
        UIViewController *top = [UIApplication sharedApplication].keyWindow.rootViewController;
        if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
            [top presentViewController:picker animated:YES completion: nil];
            self.callbackIdForImagePicker = command.callbackId;
        } else {
            popover=[[UIPopoverController alloc]initWithContentViewController:picker];
            CGRect myFrame = [top.view frame];
            [popover presentPopoverFromRect:myFrame inView:top.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSError *error;
    self.videoURL = info[UIImagePickerControllerMediaURL];
    NSString *videoFileUrl = [NSString stringWithFormat:@"%@", info[UIImagePickerControllerMediaURL]];
    NSString *fileFromPath = [videoFileUrl stringByReplacingOccurrencesOfString:@"file:///private" withString:@""];
    NSString *fileName = [info[UIImagePickerControllerMediaURL] lastPathComponent];
    NSString *directory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *destFilePath = [NSString stringWithFormat:@"%@/AppFolder/%@", directory, fileName];
    if(![[NSFileManager defaultManager] fileExistsAtPath:[destFilePath stringByDeletingLastPathComponent]]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:[destFilePath stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil];
        if([[NSFileManager defaultManager] copyItemAtPath:fileFromPath toPath:destFilePath error:&error]==YES) {
            NSLog(@"File copied..");
        }
    } else {
        NSLog(@"Error occured");
    }
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)videoPlayBackDidFinish:(NSNotification *)notification {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Video Playback" message:@"Just finished the video playback. The video is now removed." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okayAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:okayAction];
   // [self presentViewController:alertController animated:YES completion:nil];
    
}

@end
