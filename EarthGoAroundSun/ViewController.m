//
//  ViewController.m
//  EarthGoAroundSun
//
//  Created by student on 23/12/2015.
//  Copyright © 2015 dungdang. All rights reserved.
//

#import "ViewController.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
@interface ViewController ()
@property(nonatomic,strong) AVAudioPlayer *backgroundMusic;
@end

@implementation ViewController
{
    NSTimer *timerSun,*timerMoon,*timer1,*timer2,*timer3,*timer4,*timer5,*timer6,*timer7,*timer8,*timer9;
    UIImageView *sun,*mercury,*venus,*earth,*mars,*jupiter,*saturn,*uranus,*neptune,*pluto;
    UIImageView *moon;
    CGPoint sunCenter; //CoreGraphics Point
    CGFloat distanceEarthToSun;
    CGFloat distanceMoonToEarth;
    CGFloat angle1,angle2,angle3,angle4,angle5,angle6,angle7,angle8,angle9;  //goc quay
    CGFloat angleMoon,angleSun;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"universe1.jpg"]];
    [self addSunAndEarth];
    timer1 = [NSTimer scheduledTimerWithTimeInterval:0.0167
                                             target:self
                                           selector:@selector(spinMercury)
                                           userInfo:nil
                                            repeats:true];
    timer2 = [NSTimer scheduledTimerWithTimeInterval:0.0167
                                              target:self
                                            selector:@selector(spinVenus)
                                            userInfo:nil
                                             repeats:true];
    timer3 = [NSTimer scheduledTimerWithTimeInterval:0.0167
                                              target:self
                                            selector:@selector(spinEarth)
                                            userInfo:nil
                                             repeats:true];
    timer4 = [NSTimer scheduledTimerWithTimeInterval:0.0167
                                              target:self
                                            selector:@selector(spinMars)
                                            userInfo:nil
                                             repeats:true];
    timer5 = [NSTimer scheduledTimerWithTimeInterval:0.0167
                                              target:self
                                            selector:@selector(spinJupiter)
                                            userInfo:nil
                                             repeats:true];
    timer6 = [NSTimer scheduledTimerWithTimeInterval:0.0167
                                              target:self
                                            selector:@selector(spinSaturn)
                                            userInfo:nil
                                             repeats:true];
    timer7 = [NSTimer scheduledTimerWithTimeInterval:0.0167
                                              target:self
                                            selector:@selector(spinUranus)
                                            userInfo:nil
                                             repeats:true];
    timer8 = [NSTimer scheduledTimerWithTimeInterval:0.0167
                                              target:self
                                            selector:@selector(spinNeptune)
                                            userInfo:nil
                                             repeats:true];
//    timer9 = [NSTimer scheduledTimerWithTimeInterval:0.0167
//                                              target:self
//                                            selector:@selector(spinPluto)
//                                            userInfo:nil
//                                             repeats:true];

    timerMoon = [NSTimer scheduledTimerWithTimeInterval:0.0167
                                             target:self
                                           selector:@selector(spinMoon)
                                           userInfo:nil
                                            repeats:true];
    timerSun = [NSTimer scheduledTimerWithTimeInterval:0.05
                                              target:self
                                            selector:@selector(rotateSun)
                                            userInfo:nil
                                             repeats:true];
    [self onMusic];
    
}

- (void)addSunAndEarth {
    sun = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sun.png"]];
    mercury = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mercury1.png"]];
    venus = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"venus2.png"]];
    earth = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"earth3.png"]];
    mars = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mars4.png"]];
    jupiter = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jupiter5.png"]];
    saturn = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"saturn6.png"]];
    uranus = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"uranus7.png"]];
    neptune = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"neptune8.png"]];
    //pluto = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pluto9.png"]];
    moon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"moon.png"]];
    
    CGSize mainViewSize = self.view.bounds.size;
    CGFloat statusNavigationBarHeight = [UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.bounds.size.height;
    
    sunCenter = CGPointMake(mainViewSize.width * 0.5, (mainViewSize.height + statusNavigationBarHeight) * 0.5);
    
    //distanceEarthToSun = mainViewSize.width * 0.5 - 50.0;
    distanceMoonToEarth = 10.0;
    sun.center = sunCenter;
    angle3 = 0.0;
    angleMoon= 0.0;
    mercury.center = [self computePositionOfPlant:20 and:0.0];
    venus.center = [self computePositionOfPlant:40 and:0.0];
    earth.center = [self computePositionOfPlant:60 and:0.0];
    mars.center = [self computePositionOfPlant:80 and:0.0];
    jupiter.center = [self computePositionOfPlant:110 and:0.0];
    saturn.center = [self computePositionOfPlant:140 and:0.0];
    uranus.center = [self computePositionOfPlant:170 and:0.0];
    neptune.center = [self computePositionOfPlant:195 and:0.0];
    //pluto.center = [self computePositionOfPlant:190 and:0.0];

    moon.center = [self computePositionOfMoon:angleMoon];
    
    [self.view addSubview:sun];
    [self.view addSubview:mercury];
    [self.view addSubview:venus];
    [self.view addSubview:earth];
    [self.view addSubview:mars];
    [self.view addSubview:jupiter];
    [self.view addSubview:saturn];
    [self.view addSubview:uranus];
    [self.view addSubview:neptune];
    //[self.view addSubview:pluto];
    [self.view addSubview:moon];
    //sun.animationDuration
    
}


- (CGPoint)computePositionOfPlant: (CGFloat) _distance
                              and: (CGFloat) _angle {
    return CGPointMake(sunCenter.x + _distance * cos(_angle),
                       sunCenter.y + _distance * sin(_angle));
}


- (void) spinMercury {
    angle1 += 0.04;
    mercury.center = [self computePositionOfPlant:20 and:angle1];
}
- (void) spinVenus {
    angle2 += 0.016;
    venus.center = [self computePositionOfPlant:40 and:angle2];
}
- (void) spinEarth {
    angle3 += 0.01;
    earth.center = [self computePositionOfPlant:60 and:angle3];
}
- (void) spinMars {
    angle4 += 0.005;
    mars.center = [self computePositionOfPlant:80 and:angle4];
}
- (void) spinJupiter {
    angle5 += 0.0009;
    jupiter.center = [self computePositionOfPlant:110 and:angle5];
}
- (void) spinSaturn {
    angle6 += 0.00034;
    saturn.center = [self computePositionOfPlant:140 and:angle6];
}
- (void) spinUranus {
    angle7 += 0.00012;
    uranus.center = [self computePositionOfPlant:170 and:angle7];
}
- (void) spinNeptune {
    angle8 += 0.000061;
    neptune.center = [self computePositionOfPlant:195 and:angle8];
}
//- (void) spinPluto {
//    angle9 += 0.00004;
//    pluto.center = [self computePositionOfPlant:190 and:angle9];
//}
- (CGPoint)computePositionOfMoon: (CGFloat) _angleMoon{
    return CGPointMake(sunCenter.x + 60 * cos(angle3) + 10*cos(angleMoon),
                       sunCenter.y + 60 * sin(angle3) + 10*sin(angleMoon));
}
- (void) rotateSun{
    CGFloat deltaAngle = 0.01;
    angleSun += deltaAngle;
    sun.transform= CGAffineTransformMakeRotation(angleSun);
}
- (void) spinMoon{
    angleMoon += 0.12;
    moon.center = [self computePositionOfMoon:angleMoon];
}
- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [timerSun invalidate];
    timerSun = nil;
}
-(void)onMusic{
    NSString *soundFilPath = [[NSBundle mainBundle] pathForResource:@"Demons" ofType:@"mp3"];
    NSURL *soundFileURL = [NSURL fileURLWithPath:soundFilPath];
    self.backgroundMusic = [[AVAudioPlayer alloc] initWithContentsOfURL:soundFileURL error:nil];
    self.backgroundMusic.numberOfLoops = -1;
    self.backgroundMusic.currentTime = 0;
    [self.backgroundMusic play];}
@end
