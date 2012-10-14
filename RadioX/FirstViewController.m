//
//  FirstViewController.m
//  RadioX
//
//  Created by witawat wanamonthon on 10/14/12.
//  Copyright (c) 2012 witawat wanamonthon. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    UIImage *image = [UIImage imageNamed: @"logo.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage: image];
    
    [self.logoOutlet setTitleView:imageView];
    isPlaying = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)PlayButtonPress:(id)sender {
    if (!isPlaying) {
        //player = [AVPlayer playerWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://radio.thaisphost.com:8100/;stream.nsv"]]];
        [player play];
        playerItems = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://radio.thaisphost.com:8100/;stream.nsv"]]];
        [playerItems addObserver:self forKeyPath:@"timedMetadata" options:NSKeyValueObservingOptionNew context:nil];
//        NSArray *metadataList = [playerItem.asset commonMetadata];
//        NSLog(@"%@",[playerItem.asset commonMetadata]);
//        
//        for (AVMetadataItem *metaItme in metadataList) {
//            NSLog(@"%@",[metaItme commonKey]);
//        }
        player = [AVPlayer playerWithPlayerItem:playerItems];
        [player play];
        
        isPlaying = YES;
    }
    else {
        [player pause];
        [playerItems removeObserver:self forKeyPath:@"timedMetadata" context:nil];
        isPlaying = NO;
    }
}

- (void) observeValueForKeyPath:(NSString*)keyPath ofObject:(id)object
                         change:(NSDictionary*)change context:(void*)context {
    
    if ([keyPath isEqualToString:@"timedMetadata"])
    {
        AVPlayerItem* playerItem = object;
        
        for (AVMetadataItem* metadata in playerItem.timedMetadata)
        {
            NSLog(@"\nkey: %@\nkeySpace: %@\ncommonKey: %@\nvalue: %@", [metadata.key description], metadata.keySpace, metadata.commonKey, metadata.stringValue);
            if ([[metadata.key description] isEqualToString:@"title"]) {
                
                [self.SongPlayNameOutlet setText:[NSString stringWithFormat:@"%@",metadata.stringValue]];
            }
        }
    }
}
@end
