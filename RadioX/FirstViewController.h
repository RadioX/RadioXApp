//
//  FirstViewController.h
//  RadioX
//
//  Created by witawat wanamonthon on 10/14/12.
//  Copyright (c) 2012 witawat wanamonthon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>


@interface FirstViewController : UIViewController<UITabBarDelegate>{
    AVPlayer *player;
    AVPlayerItem  *playerItems;
    BOOL isPlaying;
    int DjNumber;
}
@property (weak, nonatomic) IBOutlet UILabel *SongPlayNameOutlet;
@property (weak, nonatomic) IBOutlet UINavigationItem *logoOutlet;
@property (weak, nonatomic) IBOutlet UILabel *djName;
@property (weak, nonatomic) IBOutlet UILabel *ProgramAir;
@property (weak, nonatomic) IBOutlet UIImageView *djImage;
- (IBAction)smsButtonPress:(id)sender;
- (IBAction)facebookButtonPress:(id)sender;
- (IBAction)PlayButtonPress:(id)sender;

@end
