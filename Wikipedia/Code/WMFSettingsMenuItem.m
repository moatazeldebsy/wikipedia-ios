#import "WMFSettingsMenuItem.h"
#import "Wikipedia-Swift.h"

@interface WMFSettingsMenuItem ()

@property (nonatomic, assign, readwrite) WMFSettingsMenuItemType type;

@property (nonatomic, copy, readwrite) NSString *title;

@property (nonatomic, copy, readwrite) NSString *iconName;

@property (nonatomic, copy, readwrite) UIColor *iconColor;

@property (nonatomic, assign, readwrite) BOOL isSystemIcon;

@property (nonatomic, assign, readwrite) WMFSettingsMenuItemDisclosureType disclosureType;

@property (nonatomic, copy, readwrite) NSString *disclosureText;

@end

@implementation WMFSettingsMenuItem

+ (WMFSettingsMenuItem *)itemForType:(WMFSettingsMenuItemType)type {
    switch (type) {
        case WMFSettingsMenuItemType_LoginAccount: {
            // SINGLETONTODO
            NSString *userName = [MWKDataStore shared].authenticationManager.loggedInUsername;

            NSString *loginString = (userName) ? WMFCommonStrings.account : WMFLocalizedStringWithDefaultValue(@"main-menu-account-login", nil, nil, @"Log in", @"Button text for logging in. {{Identical|Log in}}");

            return
                [[WMFSettingsMenuItem alloc] initWithType:type
                                                    title:loginString
                                                 iconName:@"settings-user"
                                                iconColor: userName ? [UIColor settingsOrange] : [UIColor settingsGrey]
                                           disclosureType:WMFSettingsMenuItemDisclosureType_ViewControllerWithDisclosureText
                                           disclosureText:userName
                                               isSwitchOn:NO];
        }
        case WMFSettingsMenuItemType_ApplePay: {
            return
                [[WMFSettingsMenuItem alloc] initWithType:type
                                                    title:WMFLocalizedStringWithDefaultValue(@"settings-donate-apple-pay", nil, nil, @"Donate Via Apple Pay", @"Title for button letting user make a donation via Apple Pay.")
                                                 iconName:@"applelogo"
                                                iconColor:[UIColor blackColor]
                                             isSystemIcon: YES
                                           disclosureType:WMFSettingsMenuItemDisclosureType_ViewController
                                           disclosureText:nil
                                               isSwitchOn:NO];
        }
        case WMFSettingsMenuItemType_Support: {
            NSString *title = (WMFFeatureFlags.needsApplePay) ? WMFLocalizedStringWithDefaultValue(@"settings-donate-web", nil, nil, @"Donate Via the Web", @"Title for button letting user make a donation via a web browser.") : WMFLocalizedStringWithDefaultValue(@"settings-support", nil, nil, @"Support Wikipedia", @"Title for button letting user make a donation.");
               return  [[WMFSettingsMenuItem alloc] initWithType:type
                                                    title:title
                                                 iconName:@"settings-support"
                                                iconColor:[UIColor settingsRed]
                                           disclosureType:WMFSettingsMenuItemDisclosureType_ExternalLink
                                           disclosureText:nil
                                               isSwitchOn:NO];
        }
        case WMFSettingsMenuItemType_SearchLanguage: {
            return
                [[WMFSettingsMenuItem alloc] initWithType:type
                                                    title:[WMFCommonStrings myLanguages]
                                                 iconName:@"settings-language"
                                                iconColor:[UIColor settingsBlue]
                                           disclosureType:WMFSettingsMenuItemDisclosureType_ViewControllerWithDisclosureText
                                           disclosureText:[MWKDataStore.shared.languageLinkController.appLanguage.languageCode uppercaseString]
                                               isSwitchOn:NO];
        }
        case WMFSettingsMenuItemType_Search: {
            return
                [[WMFSettingsMenuItem alloc] initWithType:type
                                                    title:[WMFCommonStrings searchTitle]
                                                 iconName:@"settings-search"
                                                iconColor:[UIColor wmf_green50]
                                             isSystemIcon: NO
                                           disclosureType:WMFSettingsMenuItemDisclosureType_ViewController
                                           disclosureText:nil
                                               isSwitchOn:NO];
        }
        case WMFSettingsMenuItemType_ExploreFeed: {
            return
                [[WMFSettingsMenuItem alloc] initWithType:type
                                                    title:[WMFCommonStrings exploreFeedTitle]
                                                 iconName:@"settings-explore"
                                                iconColor:[UIColor settingsBlueLight]
                                           disclosureType:WMFSettingsMenuItemDisclosureType_ViewControllerWithDisclosureText
                                           disclosureText:[NSUserDefaults standardUserDefaults].defaultTabType != WMFAppDefaultTabTypeExplore ? @"Off" : @"On"
                                               isSwitchOn:NO];
        }
        case WMFSettingsMenuItemType_Notifications: {
            return
                [[WMFSettingsMenuItem alloc] initWithType:type
                                                    title:[WMFCommonStrings pushNotifications]
                                                 iconName:@"settings-notifications"
                                                iconColor:[UIColor settingsRed]
                                           disclosureType:WMFSettingsMenuItemDisclosureType_ViewController
                                           disclosureText:nil
                                               isSwitchOn:NO];
        }
        case WMFSettingsMenuItemType_Appearance: {
            return
                [[WMFSettingsMenuItem alloc] initWithType:type
                                                    title:WMFCommonStrings.readingPreferences
                                                 iconName:@"settings-appearance"
                                                iconColor:[UIColor base0]
                                           disclosureType:WMFSettingsMenuItemDisclosureType_ViewControllerWithDisclosureText
                                           disclosureText:WMFAppearanceSettingsViewController.disclosureText
                                               isSwitchOn:NO];
        }
        case WMFSettingsMenuItemType_StorageAndSyncing: {
            return
                [[WMFSettingsMenuItem alloc] initWithType:type
                                                    title:[WMFCommonStrings settingsStorageAndSyncing]
                                                 iconName:@"settings-saved-articles"
                                                iconColor:[UIColor settingsBlue2]
                                           disclosureType:WMFSettingsMenuItemDisclosureType_ViewControllerWithDisclosureText
                                           disclosureText:nil
                                               isSwitchOn:NO];
        }
        case WMFSettingsMenuItemType_PrivacyPolicy: {
            return
                [[WMFSettingsMenuItem alloc] initWithType:type
                                                    title:WMFLocalizedStringWithDefaultValue(@"main-menu-privacy-policy", nil, nil, @"Privacy policy", @"Button text for showing privacy policy {{Identical|Privacy policy}}")
                                                 iconName:@"settings-privacy"
                                                iconColor:[UIColor settingsPurple]
                                           disclosureType:WMFSettingsMenuItemDisclosureType_ExternalLink
                                           disclosureText:nil
                                               isSwitchOn:NO];
        }
        case WMFSettingsMenuItemType_Terms: {
            return
                [[WMFSettingsMenuItem alloc] initWithType:type
                                                    title:WMFLocalizedStringWithDefaultValue(@"main-menu-terms-of-use", nil, nil, @"Terms of Use", @"Button text for showing site terms of use {{Identical|Terms of use}}")
                                                 iconName:@"settings-terms"
                                                iconColor:[UIColor settingsGrey2]
                                           disclosureType:WMFSettingsMenuItemDisclosureType_ExternalLink
                                           disclosureText:nil
                                               isSwitchOn:NO];
        }
        case WMFSettingsMenuItemType_SendUsageReports: {
            BOOL loggingEnabled = [WMFEventLoggingService sharedInstance].isEnabled;
            return
                [[WMFSettingsMenuItem alloc] initWithType:type
                                                    title:WMFLocalizedStringWithDefaultValue(@"preference-title-eventlogging-opt-in", nil, nil, @"Send usage reports", @"Title of preference that when checked enables data collection of user behavior.")
                                                 iconName:@"settings-analytics"
                                                iconColor:[UIColor settingsGreen]
                                           disclosureType:WMFSettingsMenuItemDisclosureType_Switch
                                           disclosureText:nil
                                               isSwitchOn:loggingEnabled];
        }
        case WMFSettingsMenuItemType_StorageAndSyncingDebug: {
            return
                [[WMFSettingsMenuItem alloc] initWithType:type
                                                    title:@"Reading list danger zone"
                                                 iconName:@"settings-zero"
                                                iconColor:[UIColor settingsDarkBlue]
                                           disclosureType:WMFSettingsMenuItemDisclosureType_ViewController
                                           disclosureText:nil
                                               isSwitchOn:NO];
        }
        case WMFSettingsMenuItemType_ZeroFAQ: {
            return
                [[WMFSettingsMenuItem alloc] initWithType:type
                                                    title:WMFLocalizedStringWithDefaultValue(@"main-menu-zero-faq", nil, nil, @"Wikipedia Zero FAQ", @"Button text for showing the Wikipedia Zero Frequently Asked Questions (FAQ) document")
                                                 iconName:@"settings-faq"
                                                iconColor:[UIColor settingsGrey2]
                                           disclosureType:WMFSettingsMenuItemDisclosureType_ExternalLink
                                           disclosureText:nil
                                               isSwitchOn:NO];
        }
        case WMFSettingsMenuItemType_RateApp: {
            return
                [[WMFSettingsMenuItem alloc] initWithType:type
                                                    title:WMFLocalizedStringWithDefaultValue(@"main-menu-rate-app", nil, nil, @"Rate the app", @"Button text for showing the app in the app store so user can rate the app")
                                                 iconName:@"settings-rate"
                                                iconColor:[UIColor settingsOrange2]
                                           disclosureType:WMFSettingsMenuItemDisclosureType_ExternalLink
                                           disclosureText:nil
                                               isSwitchOn:NO];
        }
        case WMFSettingsMenuItemType_SendFeedback: {
            return
                [[WMFSettingsMenuItem alloc] initWithType:type
                                                    title:WMFLocalizedStringWithDefaultValue(@"settings-help-and-feedback", nil, nil, @"Help and feedback", @"Title for showing showing a screen that displays the FAQ and allows users to submit bug reports")
                                                 iconName:@"settings-help-and-feedback"
                                                iconColor:[UIColor settingsRed]
                                           disclosureType:WMFSettingsMenuItemDisclosureType_ViewController
                                           disclosureText:nil
                                               isSwitchOn:NO];
        }
        case WMFSettingsMenuItemType_About: {
            return
                [[WMFSettingsMenuItem alloc] initWithType:type
                                                    title:WMFLocalizedStringWithDefaultValue(@"main-menu-about", nil, nil, @"About the app", @"Button for showing information about the app.")
                                                 iconName:@"settings-about"
                                                iconColor:[UIColor base0]
                                           disclosureType:WMFSettingsMenuItemDisclosureType_ViewController
                                           disclosureText:nil
                                               isSwitchOn:NO];
        }
        case WMFSettingsMenuItemType_ClearCache: {
            return
                [[WMFSettingsMenuItem alloc] initWithType:type
                                                    title:WMFLocalizedStringWithDefaultValue(@"settings-clear-cache", nil, nil, @"Clear cached data", @"Title for the 'Clear cached data' settings row")
                                                 iconName:@"settings-clear-cache"
                                                iconColor:[UIColor settingsYellow]
                                           disclosureType:WMFSettingsMenuItemDisclosureType_None
                                           disclosureText:nil
                                               isSwitchOn:NO];
        }
    }
}

- (instancetype)initWithType:(WMFSettingsMenuItemType)type
                       title:(NSString *)title
                    iconName:(NSString *)iconName
                   iconColor:(UIColor *)iconColor
                   isSystemIcon:(BOOL)isSystemIcon
              disclosureType:(WMFSettingsMenuItemDisclosureType)disclosureType
              disclosureText:(NSString *)disclosureText
                  isSwitchOn:(BOOL)isSwitchOn {
    self = [super init];
    if (self) {
        self.type = type;
        self.title = title;
        self.iconName = iconName;
        self.iconColor = iconColor;
        self.isSystemIcon = isSystemIcon;
        self.disclosureType = disclosureType;
        self.disclosureText = disclosureText;
        self.isSwitchOn = isSwitchOn;
    }
    return self;
}

@end
