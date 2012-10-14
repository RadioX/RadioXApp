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


@interface FirstViewController : UIViewController{
    AVPlayer *player;
    AVPlayerItem  *playerItems;
    BOOL isPlaying;
}
@property (weak, nonatomic) IBOutlet UILabel *SongPlayNameOutlet;
@property (weak, nonatomic) IBOutlet UINavigationItem *logoOutlet;
- (IBAction)PlayButtonPress:(id)sender;

@end
