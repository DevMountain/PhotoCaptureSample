//
//  ViewController.m
//  PhotoCaptureSample
//
//  Created by Caleb Hicks on 11/14/14.
//  Copyright (c) 2014 DevMountain. All rights reserved.
//

#import "ViewController.h"

typedef NS_ENUM(NSInteger, ActionSheetButton){
    ActionSheetFromLibrary,
    ActionSheetTakePicture
};

@interface ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.imageView.backgroundColor = [UIColor grayColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)photoButton:(id)sender {
    UIActionSheet *profileActionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"From Camera Roll", @"Take Picture", nil];
    
    [profileActionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    ActionSheetButton button = buttonIndex;
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    
    NSLog(@"%ld", (long)buttonIndex);
    
    switch (button) {
            
        case ActionSheetFromLibrary:{
            imagePicker.sourceType =  UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imagePicker animated:YES completion:nil];
            break;
        }
            
        case ActionSheetTakePicture:{
            if ([UIImagePickerController isSourceTypeAvailable:
                 UIImagePickerControllerSourceTypeCamera] == YES){
                
                imagePicker.sourceType =  UIImagePickerControllerSourceTypeCamera;
                imagePicker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
                imagePicker.allowsEditing = YES;
                
                [self presentViewController:imagePicker animated:YES completion:nil];
                
            } else{
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Camera Not Available on Device" message:@"This device does not have a camera option. Please choose Photo Library" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            }
            break;
        }
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    // Access the uncropped image from info dictionary
    UIImage *image = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    // Dismiss controller
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // Set Avatar Image
    self.imageView.image = image;

    // Any other actions you want to take with the image would go here
    
}

@end
