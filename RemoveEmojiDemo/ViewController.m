//
//  ViewController.m
//  RemoveEmojiDemo
//
//  Created by 骆杨 on 14-8-11.
//  Copyright (c) 2014年 MarsLuo. All rights reserved.
//

#import "ViewController.h"
#import "NSString+RemoveEmoji.h"
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *m_textField;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //    NSString *string = @"☺️✌️☝️❤️⭐️☀️⛅️☁️⚡️☔️❄️⛄️☎️⌛️⌚️✉️✂️✒️✏️⚽️⚾️⛳️☕️⛪️⛺️⛲️⛵️⚓️✈️⚠️⛽️♨️⬆️⬇️⬅️➡️↗️↖️↘️↙️↔️↕️↕️◀️▶️↩️↪️ℹ️⤵️⤴️♿️Ⓜ️㊙️㊗️⛔️✳️❇️✴️♻️♈️♉️♊️♋️♌️♍️♎️♏️♐️♑️♒️♓️‼️⁉️❗️⭕️✖️♠️♥️♣️♦️✔️☑️〽️◼️◻️◾️◽️▪️▫️⚫️⚪️⬜️⬛️";
    //
    //    [self stringContainsEmoji:string];
    //
    //    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:93];
    //
    //    for (int i = 0; i<string.length; i++) {
    //        const unichar hs = [string characterAtIndex:i];
    //        NSString *string = [NSString stringWithFormat:@"%x", hs];
    //        [array addObject:string];
    //    }
    //
    //    [array sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
    //        NSString *string1 = (NSString *) obj1;
    //        NSString *string2 = (NSString *) obj2;
    //        return [string1 compare:string2];
    //    }];
    //    NSLog(@"%@", array);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeString) name:UITextFieldTextDidChangeNotification object:nil];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isIncludingEmoji]) {
        return NO;
    }
    return YES;
}

- (void) changeString
{
    self.m_textField.text = [self.m_textField.text removedEmojiString];
}

@end
