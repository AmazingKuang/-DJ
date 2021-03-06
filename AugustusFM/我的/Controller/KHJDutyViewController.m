//
//  KHJDutyViewController.m
//  AugustusFM
//
//  Created by dllo on 16/8/5.
//  Copyright © 2016年 dllo. All rights reserved.
//

#import "KHJDutyViewController.h"
#import "JXLDayAndNightMode.h"
@interface KHJDutyViewController ()

@end

@implementation KHJDutyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"相关声明";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:@"btn_back_n"] imageWithRenderingMode:1] style:UIBarButtonItemStylePlain target:self action:@selector(didClickedBarButton)];
    NSString *str = @"请务必认真阅读和理解本《用户服务协议》（以下简称《协议》）中规定的所有权利和限制。除非您接受本《协议》条款，否则您无权注册、登录或使用本协 议所涉及的相关服务。您一旦注册、登录、使用或以任何方式使用本《协议》所涉及的相关服务的行为将视为对本《协议》的接受，即表示您同意接受本《协议》各 项条款的约束。如果您不同意本《协议》中的条款，请不要注册、登录或使用本《协议》相关服务。 本《协议》是用户与本软件之间的法律协议。\n\n1. 服务内容\n1.1 本软件为网站的所有者及经营者，完全按照其发布的服务条款和操作规则提供基于互联网以及移动互联网的相关服务（以下简称网络服务）网络服务的具体内容由本软件根据实际情况提供。\n1.2 您一旦注册成功成为用户，您将得到一个密码和帐号，您需要对自己在帐户中的所有活动和事件负全责。如果由于您的过失导致您的帐号和密码脱离您的控制，则由此导致的针对您、或任何第三方造成的损害，您将承担全部责任。\n1.3 用户理解并接受，仅提供相关的网络服务，除此之外与相关网络服务有关的设备（如个人电脑、手机、及其他与接入互联网或移动互联网有关的装置）及所需的费用（如为接入互联网而支付的电话费及上网费、为使用移动网而支付的手机费）均应由用户自行负担。\n\n2. 用户使用规则\n2.1 用户在申请使用本软件网络服务时，必须向本软件提供准确的个人资料，如个人资料有任何变动，必须及时更新。因用户提供个人资料不准确、不真实而引发的一切后果由用户承担。\n2.2 用户不应将其帐号、密码转让、出借或以任何脱离用户控制的形式交由他人使用。如用户发现其帐号遭他人非法使用，应立即通知本软件。因黑客行为或用户的保管疏忽导致帐号、密码遭他人非法使用，本软件不承担任何责任。\n2.3 用户应当为自身注册帐户下的一切行为负责，因用户行为而导致的用户自身或其他任何第三方的任何损失或损害，本软件不承担责任。\n2.4 用户理解并接受我喜欢网提供的服务中可能包括广告，用户同意在使用过程中显示本软件和第三方供应商、合作伙伴提供的广告。\n2.5 用户在使用本软件网络服务过程中，必须遵循以下原则：\n2.5.1 遵守中国有关的法律和法规；\n2.5.2 遵守所有与网络服务有关的网络协议、规定和程序；\n2.5.3 不得为任何非法目的而使用网络服务系统；\n2.5.4 不得利用本软件网络服务系统进行任何可能对互联网或移动网正常运转造成不利影响的行为；\n2.5.5 不得利用本软件提供的网络服务上传、展示或传播任何虚假的、骚扰性的、中伤他人的、辱骂性的、恐吓性的、庸俗淫秽的或其他任何非法的信息资料；\n2.5.6 不得侵犯本软件和其他任何第三方的专利权、著作权、商标权、名誉权或其他任何合法权益；\n2.5.7 不得利用本软件网络服务系统进行任何不利于本软件的行为；\n2.5.8 如发现任何非法使用用户帐号或帐号出现安全漏洞的情况，应立即通告本软件。\n2.6 如用户在使用网络服务时违反任何上述规定，本软件或其授权的人有权要求用户改正或直接采取一切必要的措施（包括但不限于更改或删除用户收藏的内容等、暂停或终止用户使用网络服务的权利）以减轻用户不当行为造成的影响。\n\n3. 服务变更、中断或终止\n3.1 鉴于网络服务的特殊性，用户同意本软件有权根据业务发展情况随时变更、中断或终止部分或全部的网络服务而无需通知用户，也无需对任何用户或任何第三方承担任何责任；\n3.2 用户理解，本软件需要定期或不定期地对提供网络服务的平台（如互联网网站、移动网络等）或相关的设备进行检修或者维护，如因此类情况而造成网络服务在合理时间内的中断，本软件无需为此承担任何责任，但本软件应尽可能事先进行通告。\n3.3 如发生下列任何一种情形，本软件有权随时中断或终止向用户提供本《协议》项下的网络服务（包括收费网络服务）而无需对用户或任何第三方承担任何责任：\n3.3.1 用户提供的个人资料不真实；\n3.3.2 用户违反本《协议》中规定的使用规则。\n\n4. 知识产权\n4.1 提供的网络服务中包含的任何文本、图片、图形、音频和/或视频资料均受版权、商标和/或其它财产所有权法律的保护，未经相关权利人同意，上述资料均不得用于任何商业目的。\n4.2 为提供网络服务而使用的任何软件（包括但不限于软件中所含的任何图象、照片、动画、录像、录音、音乐、文字和附加程序、随附的帮助材料）的一切权利均属于 该软件的著作权人，未经该软件的著作权人许可，用户不得对该软件进行反向工程（reverse engineer）、反向编译（decompile）或反汇编（disassemble）。\n\n5. 隐私保护\n5.1 保护用户隐私是本软件的一项基本政策，本软件保证不对外公开或向第三方提供单个用户的注册资料及用户在使用网络服务时存储在本软件的非公开内容，但下列情况除外：\n5.1.1 事先获得用户的明确授权；\n5.1.2 根据有关的法律法规要求；\n5.1.3 按照相关政府主管部门的要求；\n5.1.4 为维护社会公众的利益；\n5.1.5 为维护本软件的合法权益。\n5.2 本软件可能会与第三方合作向用户提供相关的网络服务，在此情况下，如该第三方同意承担与本软件同等的保护用户隐私的责任，则本软件有权将用户的注册资料等提供给该第三方。\n5.3 在不透露单个用户隐私资料的前提下，本软件有权对整个用户数据库进行分析并对用户数据库进行商业上的利用。\n5.4 本软件制定了以下四项隐私权保护原则，指导我们如何来处理产品中涉及到用户隐私权和用户信息等方面的问题：\n（1） 利用我们收集的信息为用户提供有价值的产品和服务。\n（2） 开发符合隐私权标准和隐私权惯例的产品。\n（3） 将个人信息的收集透明化，并由权威第三方监督。\n（4） 尽最大的努力保护我们掌握的信息。\n\n6. 免责声明\n6.1 本软件不担保网络服务一定能满足用户的要求，也不担保网络服务不会中断，对网络服务的及时性、安全性、准确性也都不作担保。\n6.2 本软件不保证为向用户提供便利而设置的外部链接的准确性和完整性，同时，对于该等外部链接指向的不由本软件实际控制的任何网页上的内容，本软件不承担任何责任。\n6.3 对于因电信系统或互联网网络故障、计算机故障或病毒、信息损坏或丢失、计算机系统问题或其它任何不可抗力原因而产生损失，本软件不承担任何责任，但将尽力减少因此而给用户造成的损失和影响。\n\n7. 法律及争议解决\n7.1 本协议适用中华人民共和国法律。\n7.2 因本协议引起的或与本协议有关的任何争议，各方应友好协商解决；协商不成的，任何一方均可将有关争议提交至北京仲裁委员会并按照其届时有效的仲裁规则仲裁；仲裁裁决是终局的，对各方均有约束力。\n\n8. 其他条款\n8.1 如果本协议中的任何条款无论因何种原因完全或部分无效或不具有执行力，或违反任何适用的法律，则该条款被视为删除，但本协议的其余条款仍应有效并且有约束力。\n8.2 本软件有权随时根据有关法律、法规的变化以及公司经营状况和经营策略的调整等修改本协议，而无需另行单独通知用户。用户可随时通过网站浏览最新服务协议条 款。当发生有关争议时，以最新的协议文本为准。如果不同意本软件对本协议相关条款所做的修改，用户有权停止使用网络服务。如果用户继续使用网络服务，则视 为用户接受本软件对本协议相关条款所做的修改。\n8.3 本软件在法律允许最大范围对本协议拥有解释权与修改权。\n";
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [self.view addSubview:textView];
    [textView release];
    textView.text = str;
    textView.showsVerticalScrollIndicator = NO;
    textView.font = [UIFont systemFontOfSize:18 * lFitHeight];
    [textView setEditable:NO];
    
    [self.view jxl_setDayMode:^(UIView *view) {
        view.backgroundColor = [UIColor whiteColor];
        textView.backgroundColor = [UIColor whiteColor];
    } nightMode:^(UIView *view) {
        view.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
        textView.backgroundColor = [UIColor colorWithRed:0.00 green:0.11 blue:0.22 alpha:1.00];
        textView.textColor = [UIColor whiteColor];
    }];
    
    
    
}
- (void)didClickedBarButton{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
