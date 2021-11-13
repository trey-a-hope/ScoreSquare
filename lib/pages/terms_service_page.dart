import 'package:flutter/material.dart';

class TermsServicePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Terms & Services',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Text(
                'Intellectual Property',
                style: Theme.of(context).textTheme.headline3,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'You acknowledge that we or our licensors retain all proprietary right, title, and interest in the Services, our name, logo, or other marks, and any related intellectual property right, including, without limitation, all modifications, enhancements, derivative works, and upgrades thereto. You agree that you will not use or register any trademark, service mark, business name, domain name or social media account name or is similar to any of these.',
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'User-Generated Content',
                style: Theme.of(context).textTheme.headline3,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'The Services may contain information, text, links, graphic, photos, videos, or other materials(“Content”), including Content created with or submitted to the Services by you or through your Account(“Your Content”). We take no responsibility for and we do not expressly or implicit endorse any of Your Content.  By submitting Your Content to the Services, you represent and warrant that you have all right, power, and authority necessary to grant the rights to Your Content contained within these Terms. Because you. Alone are responsible for Your Content, you may expose yourself to liability if you post or share Content without all necessary rights.',
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Prohibited Uses',
                style: Theme.of(context).textTheme.headline3,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'By used our Services, you agree on behalf of yourself, your users, and your attendees, not to (1) modify, prepare derivative works of, or reverse engineer, our Services; (2) knowingly use our Services in a way that abuses our networks, user accounts, or the Services; (3) transmit through the Services any harassing, indecent, obscene, fraudulent, or unlawful material; (4) market, or resell the Services to any third party; (5) use the Services in violation of applicable laws, or regulations; (6) use the Services to send unauthorized advertising, or spam; (7) harvest, collect, or gather user data without their consent; or (8) transmit through the Services any material that my infringe the intellectual property, privacy, or other rights of their parties.',
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Limitation of Liability',
                style: Theme.of(context).textTheme.headline3,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'You agree that Critic shall, in no event, be liable for any consequential, incidental, indirect, special, punitive, or other loss or damage whatsoever or for loss of business profits, business interruption, computer failure, loss of business information, or other loss arising out of or caused by your use of inability to use the service, even if Critic has been advised of the possibility of such damage. In no event shall Critic’s entire liability to you in respect of any service, whether direct or indirect, exceed the fees paid by you towards such service.',
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Right to Terminate Accounts',
                style: Theme.of(context).textTheme.headline3,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'If you fail, or Critic suspects on reasonable grounds that you have failed, to comply with any of the provisions of this Agreement, Critic may, without notice to you: (1) terminate this Agreement; and/or (2) terminate your license to the software; and/or (3) preclude your access to the Services.',
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'Governing Law and Jurisdiction',
                style: Theme.of(context).textTheme.headline3,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                'These Terms of Service are governed by the laws of Ohio, and all parties submit to the non-exclusive jurisdiction of the courts of this State.',
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
