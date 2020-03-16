//
//  Constants.swift
//  WAStickersThirdParty
//
//  Created by Benjamin Lim on 3/26/19.
//  Copyright © 2019 WhatsApp. All rights reserved.
//

import Foundation

struct HTTP {
    //http://cimbstickers.rpddev.com/octa/public/api/stickersandgif
    //  http://cimbstickers.rpddev.com/cimb-stickers-web/public/api/v1/stickers
    static let API_URL = "http://cimbstickers.rpddev.com/cimb-stickers-web/public"
    static let GET_ALL_STICKERS = API_URL + "/api/v1/stickers"
    static let POST_SUGGESTION = API_URL + "/api/v1/suggestion"
    static let API_STORAGE = "http://cimbstickers.rpddev.com/cimb-stickers-web/public/storage/"
    
    static let BASE_URL = "http://cimbstickers.rpddev.com/octa/public/api/"
    static let IMAGE_BASE_URL = "http://cimbstickers.rpddev.com/octa/public/stickers/"
    
    static let STICKERS_GIF = BASE_URL + "stickersandgif"
    static let FRAMES = BASE_URL + "frames"
    static let TYPEFACES = BASE_URL + "typefaces"
    
}

struct Constants {
    static let APP_VERSION = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    static let APP_COPYRIGHT = "Copyright © 2019 CIMB Bank Berhad (13491-P)"
    // static let APP_COPYRIGHT = "Copyright © 2019 CIMB Group Holdings Berhad (Company No. 50841-W)"
    // Layouts
    static let currentWindow = UIApplication.shared.keyWindow
    static let screenSize: CGRect = UIScreen.main.bounds
    static let screenWidth = screenSize.width
    static let screenHeight = screenSize.height
    static let statusBarHeight = UIApplication.shared.statusBarFrame.height
    static let FONT_FAMILY = "Helvetica"
    static let FONT_FAMILY_BOLD = "HelveticaNeue-Bold"
    static let FONT_FAMILY_SEMIBOLD = "HelveticaNeue-Medium"
    static let FONT_FAMILY_BOLDITALIC = "HelveticaNeue-BoldItalic"
    
    struct Layout {
        static let stickerTableViewCellHeight: CGFloat = 120
        static let stickerCollectViewHeight: CGFloat = 120
    }
    
}

struct App {
    static let termsAndConditions = """
    Terms of Access and Use for Octo Stickers by CIMB\n\n
    The following terms and conditions govern your access and use of the Octo Stickers by CIMB application as well as the download and use of the Octo Stickers by CIMB (“Terms”).\n\n
    By using or accessing the Octo Stickers by CIMB application, you (“User”) acknowledge that you have read, understand, and agree to be bound by these Terms, including Octo Stickers by CIMB application’s privacy notice located at the end of this document (“Privacy Notice”).\n\n
    This application, the services and the Octo Stickers by CIMB are operated, administered, maintained and developed by CIMB Group Holdings Berhad (Company No. 50841-W  ) ("We", "us" or "our", as the case may be) and our third party vendor.  This Octo Stickers by CIMB app allows you as User to save the Octo Stickers by CIMB (“Content”) from within the app, and share the Content on third party services or social media platforms.\n\n
    If you do not agree to all of these Terms, or you have no authority or do not meet the eligibility requirements, you should cease any and all access or use of the Octo Stickers by CIMB app and its Content.\n\n
    General Rules\n\n
    You understand and agree that:\n\n
    1.    Your access of this application, use of the services and download or use of the Content shall be in accordance with all legislation and regulations governing the same at all times.\n
    2.    This Octo Stickers by CIMB app does not monitor and is not responsible for User Content or User activities on other applications, services and platforms.\n
    3.    Your use of this Octo Stickers by CIMB app and Content is purely for personal purposes only and you may not use them for commercial purposes.\n
    4.    The Content including any graphic, text, script, music, sound, image, art, video and other multimedia work or any combination is protected by trademark, copyright and other applicable intellectual property or proprietary rights owned exclusively by us. You do not acquire ownership rights to any Content downloaded from this Octo Sticker app.\n
    5.    You must not modify or adapt the Octo Stickers by CIMB app, or create or modify another website or mobile application to create a false impression that it is associated with us.\n
    6.    You agree not to hack or attempt to gain unauthorised access into this app and the services provided by the app; abuse, misuse or disrupt the security of the app; or otherwise provide inaccurate or false information on the app or services provided by the app.\n
    7.    You are not to copy, duplicate, reproduce, transfer, give access to, distribute or exploit any part of the Octo Stickers by CIMB app in any medium without our prior written consent and authorisation.\n
    8.    You must not resell or charge others for the use of or access to the Octo Stickers by CIMB app and its Content.\n
    9.    You must not modify or adapt the Content, or use the Content for any abusive, defamatory, illegal or unauthorized purpose, hate speech, verbal violence or in a way that constitutes a criminal offence, infringes another person\'s rights, gives rise to any civil liability, encourages racism, promotes hatred, contains pornography or paedophilia, contains any viruses or deleterious files and/or is objectionable to public morals and decency.\n
    10.    You must also not use the Content to transmit any worms, viruses, or other destructive code.\n
    11.    You agree to review the Octo Stickers by CIMB app website periodically for any modifications, amendments or updates to these Terms.\n
    12.    You also agree and are aware that this Octo Stickers by CIMB app is supported by advertising revenue and may display advertisements and promotions on the app or Content which may not be identified as paid, sponsored or commercial content.\n\n
    
    We reserve the right, for any reason and without notice at any time, to:\n\n
    1.    Modify, amend or update these Terms or Content at our sole discretion. We will post the updated Terms to the Octo Stickers by CIMB app and your continued use of the Octo Stickers by CIMB app and/or the Content will constitute your agreement and acceptance to such amendments of the Terms.  If you do not agree with any amendment, you should immediately terminate your use of the Octo Stickers by CIMB app and the Content.\n
    2.    Modify, alter or terminate this Octo Stickers by CIMB application at our sole discretion.\n
    3.    Refuse or deny access to the Octo Stickers by CIMB application to anyone or any party.\n
    4.    Remove any Content and/or accounts at our sole discretion.  Accounts and Content that we may remove include accounts with Content that are unlawful, offensive, threatening, libelous, defamatory, obscene or otherwise objectionable or violates any party’s intellectual property or these Terms.\n
    5.    Modify or change the manner, mode, and extent of any advertising and promotions, whether or not such advertisements and promotions are paid, sponsored or consist of commercial content.\n\n
    Severability and Waiver\n
    If any provisions of these Terms are invalid or unenforceable, that offending clause shall not affect the validity or enforceability of the other Terms.  If we do not enforce any of these Terms, it shall not be construed as having waived our rights to enforce the same.\n\n
    Governing Law and Jurisdiction\n
    These Terms, your access and use of the Octo Stickers by CIMB app, the services of the app and the Content are governed by Malaysian laws and you agree to submit and be bound by the exclusive jurisdiction of Malaysian Courts.\n\n
    Contact Us\n
    If you know or are aware of any misuse of the Octo Stickers by CIMB app or Content or any violation of the Terms or Privacy Policy or have queries or require additional information on the Octo Stickers by CIMB app or Content, please send an email to cimb.stickers@reprisedigital.com\n
    
    © CIMB Group Holdings Berhad (Company No. 50841-W) 2019
    """
    
    static let termsAndConditionsInit =
    """
Terms & Conditions of Access and Use for Octo Lenses by CIMB application (“Terms”)
The following terms and conditions govern your access and use of the Octo Lenses by CIMB application (“App”) as well as the download and use of the App and its contents comprising of the Octo lenses (“Content”).
By downloading, using or accessing the App and its Content, you (“User”) acknowledge that you have read, understand, and agree to be bound by these Terms, including the privacy notice located at the end of this document (“Privacy Notice”).
This Application, the services and the Content are created, developed, operated, administered and maintained by CIMB Group Holdings Berhad (Company No. 195601000197 / 50841-W ) ("We", "us" or "our", as the case may be) and our third party vendor(s). This App allows you as a User to save the Content from within the App onto your mobile device, and share or add, save or paste or use the Content on any media format and/or third party services or social media platforms.
If you do not agree to all of these Terms, or you have no authority or do not meet the eligibility requirements, you should cease any and all access or use of the App and its Content.
General Rules
You understand and agree that:
Your access of and to this App, use of the services and download or use of the Content shall be in accordance with all legislation and regulations governing the same at all times.
The App does not monitor and is not responsible for User Content or User activities on other applications, services and platforms.  In this regard, we and our third party vendor(s) are also not liable or responsible for User Content or User activities on any applications, services and platforms.
Your use of both the App and Content is purely for personal purposes only and at your own risk, and you cannot use them for commercial purposes.
The Content including any graphic, information, text, data, script, music, sound, image, art, video and other multimedia work or any combination is protected by trademark, copyright and other applicable intellectual property or proprietary rights owned exclusively by us. You do not acquire ownership rights to the App or any Content downloaded from this App but a limited and revocable license to reproduce and display the Content.
You must not modify, hack or adapt the App, or create or modify another website or mobile application to create a false impression that it is associated with us.
You agree not to hack or attempt to gain unauthorised access into this App and the services provided by the App; abuse, misuse or disrupt the security of the App; or otherwise provide or spread inaccurate or false information on the App or services provided by the App.
You are not to copy, duplicate, reproduce, transfer, give access to, distribute or exploit any part of the App.
You must not resell or charge others for the use of, or access to the App and its Content.
You remain solely liable and responsible for all Content or media format that you use, post, broadcast or display on all applications, services and platforms.
You are also liable and responsible for all conduct and activity that occurs in or under your name or your account on those other applications, services and platforms which may carry any Content.
You must not adapt, modify or disturb the Content in any manner, or add, paste, broadcast, display or use the Content for any abusive, defamatory, illegal or unauthorized purpose, hate speech, verbal violence or in a way that constitutes a criminal offence, infringes another person's rights, gives rise to any civil liability, encourages racism, promotes hatred, contains nudity/partial nudity, pornography or paedophilia, contains any viruses or deleterious files and/or is objectionable to public morals and decency.  In particular, there must not be any such Content or defamatory statement or material directed against us.
You must also not use the App or Content to transmit any worms, viruses, or other destructive code.
You agree to review these Terms periodically for any modifications, amendments or updates to these Terms which will be posted to the App.
You also agree and are aware that this App may be supported by advertising revenue and may display advertisements and promotions on the App or Content which may not be identified as paid, sponsored or commercial content.
We reserve the right, for any reason and without notice at any time, to:
Modify, amend or update these Terms at our sole discretion. We will post the updated Terms to the App and your continued use of the App and/or Content will constitute your agreement and acceptance to such amended Terms. If you do not agree with any amendment, you should immediately terminate your use of the App and the Content.
Modify, alter or terminate this App or Content or any part thereof at our sole discretion.
Refuse or deny access to the App or Content to anyone or any party.
Remove any Content at our sole discretion. Content that we may remove include Content that are unlawful, offensive, threatening, libelous, defamatory, obscene or otherwise objectionable or violates any party’s intellectual property or these Terms.
Modify or change the manner, mode, and extent of any advertising and promotions, whether or not such advertisements and promotions are paid, sponsored or consist of commercial content.
Severability and Waiver
If any provisions of these Terms are invalid or unenforceable, that offending clause shall not affect the validity or enforceability of the other Terms. If we do not enforce any of these Terms, it shall not be construed as having waived our rights to enforce the same.
Governing Law & Jurisdiction
These Terms, your access and use of this App, the services of the App and the Content are governed by Malaysian laws and you agree to submit and be bound by the exclusive jurisdiction of Malaysian Courts.
Contact Us
If you know or are aware of any misuse of the App or Content or any violation of the Terms or Privacy Notice or have queries or require additional information on the App or Content, please send an email to cimb.stickers@reprisedigital.com
© CIMB Group Holdings Berhad (Company No. 195601000197 / 50841-W) 2019

"""
//    """
//Before you can start using Octo Stickers by CIMB, you must first agree to our Terms and Conditions.\n\n
//Terms of Access and Use for Octo Stickers by CIMB\n\n
//The following terms and conditions govern your access and use of the Octo Stickers by CIMB application as well as the download and use of the Octo Stickers by CIMB (“Terms”).\n\n
//By using or accessing the Octo Stickers by CIMB application, you (“User”) acknowledge that you have read, understand, and agree to be bound by these Terms, including Octo Stickers by CIMB application’s privacy notice located at the end of this document (“Privacy Notice”).\n\n
//This application, the services and the Octo Stickers by CIMB are operated, administered, maintained and developed by CIMB Group Holdings Berhad (Company No. 50841-W  ) ("We", "us" or "our", as the case may be) and our third party vendor.  This Octo Stickers by CIMB app allows you as User to save the Octo Stickers by CIMB (“Content”) from within the app, and share the Content on third party services or social media platforms.\n\n
//If you do not agree to all of these Terms, or you have no authority or do not meet the eligibility requirements, you should cease any and all access or use of the Octo Stickers by CIMB app and its Content.\n\n
//General Rules\n\n
//    You understand and agree that:\n\n
//    1.    Your access of this application, use of the services and download or use of the Content shall be in accordance with all legislation and regulations governing the same at all times.\n
//    2.    This Octo Stickers by CIMB app does not monitor and is not responsible for User Content or User activities on other applications, services and platforms.\n
//    3.    Your use of this Octo Stickers by CIMB app and Content is purely for personal purposes only and you may not use them for commercial purposes.\n
//    4.    The Content including any graphic, text, script, music, sound, image, art, video and other multimedia work or any combination is protected by trademark, copyright and other applicable intellectual property or proprietary rights owned exclusively by us. You do not acquire ownership rights to any Content downloaded from this Octo Sticker app.\n
//    5.    You must not modify or adapt the Octo Stickers by CIMB app, or create or modify another website or mobile application to create a false impression that it is associated with us.\n
//    6.    You agree not to hack or attempt to gain unauthorised access into this app and the services provided by the app; abuse, misuse or disrupt the security of the app; or otherwise provide inaccurate or false information on the app or services provided by the app.\n
//    7.    You are not to copy, duplicate, reproduce, transfer, give access to, distribute or exploit any part of the Octo Stickers by CIMB app in any medium without our prior written consent and authorisation.\n
//    8.    You must not resell or charge others for the use of or access to the Octo Stickers by CIMB app and its Content.\n
//    9.    You must not modify or adapt the Content, or use the Content for any abusive, defamatory, illegal or unauthorized purpose, hate speech, verbal violence or in a way that constitutes a criminal offence, infringes another person\'s rights, gives rise to any civil liability, encourages racism, promotes hatred, contains pornography or paedophilia, contains any viruses or deleterious files and/or is objectionable to public morals and decency.\n
//    10.    You must also not use the Content to transmit any worms, viruses, or other destructive code.\n
//    11.    You agree to review the Octo Stickers by CIMB app website periodically for any modifications, amendments or updates to these Terms.\n
//    12.    You also agree and are aware that this Octo Stickers by CIMB app is supported by advertising revenue and may display advertisements and promotions on the app or Content which may not be identified as paid, sponsored or commercial content.\n\n
//
//    We reserve the right, for any reason and without notice at any time, to:\n\n
//    1.    Modify, amend or update these Terms or Content at our sole discretion. We will post the updated Terms to the Octo Stickers by CIMB app and your continued use of the Octo Stickers by CIMB app and/or the Content will constitute your agreement and acceptance to such amendments of the Terms.  If you do not agree with any amendment, you should immediately terminate your use of the Octo Stickers by CIMB app and the Content.\n
//    2.    Modify, alter or terminate this Octo Stickers by CIMB application at our sole discretion.\n
//    3.    Refuse or deny access to the Octo Stickers by CIMB application to anyone or any party.\n
//    4.    Remove any Content and/or accounts at our sole discretion.  Accounts and Content that we may remove include accounts with Content that are unlawful, offensive, threatening, libelous, defamatory, obscene or otherwise objectionable or violates any party’s intellectual property or these Terms.\n
//    5.    Modify or change the manner, mode, and extent of any advertising and promotions, whether or not such advertisements and promotions are paid, sponsored or consist of commercial content.\n\n
//    Severability and Waiver\n
//    If any provisions of these Terms are invalid or unenforceable, that offending clause shall not affect the validity or enforceability of the other Terms.  If we do not enforce any of these Terms, it shall not be construed as having waived our rights to enforce the same.\n\n
//    Governing Law and Jurisdiction\n
//    These Terms, your access and use of the Octo Stickers by CIMB app, the services of the app and the Content are governed by Malaysian laws and you agree to submit and be bound by the exclusive jurisdiction of Malaysian Courts.\n\n
//    Contact Us\n
//    If you know or are aware of any misuse of the Octo Stickers by CIMB app or Content or any violation of the Terms or Privacy Policy or have queries or require additional information on the Octo Stickers by CIMB app or Content, please send an email to cimb.stickers@reprisedigital.com\n
//
//    © CIMB Group Holdings Berhad (Company No. 50841-W) 2019
//"""

    static let privacyPolicy =
    
    """
    Privacy Notice for Octo Lenses by CIMB (the “application” or “app”)
    Type of Data Collected
    This application does not collect any sensitive data from Users but it will collect unique device identifiers, usage data, geographic location and interaction with social media platforms for advertising and analytics. If a User contacts us, Users will be required to leave their contact information such as e-mail address.
    Use of Data Collected
    The data collected will be used for analytics, firebase analytic for app, infrastructure monitoring, crashlytics, and usage of contents downloaded from the app (“Content”) on external social networks and platforms.
    Disclosure of Data
    The data collected may be disclosed to companies within the CIMB Group which may be residing, located, carrying on business, incorporated or constituted within or outside Malaysia as well as our appointed third party developer and/or vendors.
    Retention of Data
    The data collected will be used for analysis and retained for as long as required to facilitate such analysis but no longer than 7 years from the date of collection.
    Changes to this Privacy Notice
    We reserve the right to modify, amend or update this Privacy Notice at our sole discretion and will post the revised Privacy Notice to the app. Your continued use of the app or the Contents will constitute your agreement and acceptance to such amendments of the Privacy Notice.
    Governing Law and Jurisdiction
    This Privacy Notice is governed by Malaysian laws and you agree to submit and be bound by the exclusive jurisdiction of Malaysian Courts.
    © CIMB Group Holdings Berhad (Company No. 195601000197 / 50841-W) 2019
    """
    
//    """
//Privacy Notice for Octo Stickers by CIMB application\n\n
//Type of Data Collected\n\n
//This application does not collect any sensitive data from Users but it will collect unique device identifiers,  usage  data,  geographic  location  and  interaction  with social  media platforms  for advertising  and  analytics. If  a  User  contacts  us,  Users  will  be  required  to  leave  their  contact information such as e-mail address.\n\n
//Use of Data Collected\nThe data collected will be used for analytics, firebase analytic for app, infrastructure monitoring, crashlytics, and usage of Content on external social networks and platforms.\n\n
//Disclosure of Data\nThe data collected may be disclosed to companies within the CIMB Group which may be residing, located, carrying on business, incorporated or constituted within or outside Malaysia\'s as well as our appointed third party developer and/or vendors.\n\n
//Retention of Data\nThe data collected will be used for analysis and retained for as long as required to facilitate such analysis but no longer than 7 years from the date of collection.\n\n
//Changes to this Privacy Notice\nWe reserve the right to modify, amend or update this Privacy Notice at our sole discretion and will post the revised Privacy Notice to the Octo Stickers by CIMB app. Your continued use of the Octo Stickers by CIMB app or the Content will constitute your agreement or acceptance to such amendments of the Privacy Notice.\n\n
//Governing Law and Jurisdiction
//This Privacy Notice is governed by Malaysian laws and you agree to submit and be bound by the exclusive jurisdiction of Malaysia Courts. © CIMB Group Holdings Berhad
//"""
}
