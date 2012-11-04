//
//  FirstViewController.m
//  RadioX
//
//  Created by witawat wanamonthon on 10/14/12.
//  Copyright (c) 2012 witawat wanamonthon. All rights reserved.
//

#import "FirstViewController.h"
#import "SBJson.h"

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
    NSURL *url = [NSURL URLWithString:@"http://www.iloveradiox.com/json/dj"];
    NSString *jsonString = [self performStoreRequestWithURL:url];
    NSDictionary *jsonDict = [jsonString JSONValue];
   // NSLog(@"%@",jsonDict );
    int d = (arc4random()%[jsonDict count])+1;
    DjNumber = [jsonDict count];
    [self.djImage setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[jsonDict objectForKey:[NSString stringWithFormat:@"%d",d]] objectForKey:@"image"]]]]]];
    [self.djName setText:[NSString stringWithFormat:@"%@",[[jsonDict objectForKey:[NSString stringWithFormat:@"%d",d]]objectForKey:@"nick_name"]]];
    [self.ProgramAir setText:[NSString stringWithFormat:@"%@",[[jsonDict objectForKey:[NSString stringWithFormat:@"%d",d]]objectForKey:@"showtime"]]];
    [self performSelector:@selector(changeDj:) withObject:[NSString stringWithFormat:@"%d",d] afterDelay:5.0];
}

-(void)changeDj:(NSString*)djID{
    NSURL *url = [NSURL URLWithString:@"http://www.iloveradiox.com/json/dj"];
    NSString *jsonString = [self performStoreRequestWithURL:url];
    NSDictionary *jsonDict = [jsonString JSONValue];
    int number = [djID intValue];
    int randomNumber = (arc4random()%DjNumber)+1;
    while (number == randomNumber) {
        randomNumber = (arc4random()%DjNumber)+1;
    }
    [self.djImage setImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[jsonDict objectForKey:[NSString stringWithFormat:@"%d",randomNumber]] objectForKey:@"image"]]]]]];
    [self.djName setText:[NSString stringWithFormat:@"%@",[[jsonDict objectForKey:[NSString stringWithFormat:@"%d",randomNumber]]objectForKey:@"nick_name"]]];
    [self.ProgramAir setText:[NSString stringWithFormat:@"%@",[[jsonDict objectForKey:[NSString stringWithFormat:@"%d",randomNumber]]objectForKey:@"showtime"]]];
     [self performSelector:@selector(changeDj:) withObject:[NSString stringWithFormat:@"%d",randomNumber] afterDelay:5.0];
     
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)smsButtonPress:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sms://466453"]];
}

- (IBAction)facebookButtonPress:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/87.5RadioXStation"]];
}

- (IBAction)PlayButtonPress:(id)sender {
    if (!isPlaying) {
        [player play];
        playerItems = [AVPlayerItem playerItemWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://radio.thaisphost.com:8100/;stream.nsv"]]];
        [playerItems addObserver:self forKeyPath:@"timedMetadata" options:NSKeyValueObservingOptionNew context:nil];
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

- (NSString *)performStoreRequestWithURL:(NSURL *)url
{
    NSError *error;
    NSString *resultString = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:&error];
    if (resultString == nil) {
        NSLog(@"Download Error: %@", error);
        return nil;
    }
    return resultString;
}

@end
