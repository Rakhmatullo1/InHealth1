import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/dark_theme_provider.dart';

class PrivacyNPolicyWidget extends StatelessWidget {
  static const routeName = '/health-n-police';
  const PrivacyNPolicyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Provider.of<ThemeNotifier>(context, listen: false).isDark()
        ? Colors.white
        : Colors.black;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Privacy and Policy',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              RichText(
                text: TextSpan(
                  text: '1. ',
                  children: const [
                    TextSpan(
                        text: 'Introduction',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Montserrat'),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              RichText(
                  text: TextSpan(
                      text: 'Welcome to ',
                      style: TextStyle(color: color, fontFamily: 'Montserrat'),
                      children: const [
                    TextSpan(
                        text: 'InHealth',
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ])),
              const SizedBox(
                height: 5,
              ),
              RichText(
                  text: TextSpan(
                text: 'InHealth ',
                children: const [
                  TextSpan(
                      text: '(“us”, “we”, or “our”) operates ',
                      style: TextStyle(fontWeight: FontWeight.normal)),
                  TextSpan(
                      text: 'fayzullo.uz ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: '(hereinafter referred to as ',
                      style: TextStyle(fontWeight: FontWeight.normal)),
                  TextSpan(
                      text: '“Service”',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Montserrat')),
                  TextSpan(
                      text: ')',
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Montserrat'))
                ],
                style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat'),
              )),
              const SizedBox(
                height: 5,
              ),
              RichText(
                  text: TextSpan(
                      text: 'Our Privacy Policy governs your visit to ',
                      style: TextStyle(color: color, fontFamily: 'Montserrat'),
                      children: const [
                    TextSpan(
                        text: 'fayzullo.uz',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                        text:
                            ', and explains how we collect, safeguard and disclose information that results from your use of our Service.',
                        style: TextStyle(fontWeight: FontWeight.normal))
                  ])),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'We use your data to provide and improve Service. By using Service, you agree to the collection and use of information in accordance with this policy. Unless otherwise defined in this Privacy Policy, the terms used in this Privacy Policy have the same meanings as in our Terms and Conditions.',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 5,
              ),
              RichText(
                  text: TextSpan(
                      text: 'Our Terms and Conditions (',
                      style: TextStyle(color: color, fontFamily: 'Montserrat'),
                      children: const [
                    TextSpan(
                        text: '“Terms”',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                        text:
                            ' govern all use of our Service and together with the Privacy Policy constitutes your agreement with us (',
                        style: TextStyle(fontWeight: FontWeight.normal)),
                    TextSpan(
                        text: '“agreement”',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: ')',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Montserrat'))
                  ])),
              const SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                  text: '2. ',
                  children: const [
                    TextSpan(
                        text: 'Definitions',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Montserrat'),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              RichText(
                  text: TextSpan(
                text: 'SERVICE ',
                children: const [
                  TextSpan(
                      text:
                          'means the fayzullo.uz website operated by InHealth',
                      style: TextStyle(fontWeight: FontWeight.normal))
                ],
                style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat'),
              )),
              const SizedBox(
                height: 5,
              ),
              RichText(
                  text: TextSpan(
                text: 'PERSONAL DATA ',
                children: const [
                  TextSpan(
                      text:
                          'means data about a living individual who can be identified from those data (or from those and other information either in our possession or likely to come into our possession).',
                      style: TextStyle(fontWeight: FontWeight.normal))
                ],
                style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat'),
              )),
              const SizedBox(
                height: 5,
              ),
              RichText(
                  text: TextSpan(
                text: 'USAGE DATA ',
                children: const [
                  TextSpan(
                      text:
                          'is data collected automatically either generated by the use of Service or from Service infrastructure itself (for example, the duration of a page visit)',
                      style: TextStyle(fontWeight: FontWeight.normal))
                ],
                style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat'),
              )),
              const SizedBox(
                height: 5,
              ),
              RichText(
                  text: TextSpan(
                text: 'COOKIES ',
                children: const [
                  TextSpan(
                      text:
                          'are small files stored on your device (computer or mobile device).',
                      style: TextStyle(fontWeight: FontWeight.normal))
                ],
                style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat'),
              )),
              const SizedBox(
                height: 5,
              ),
              RichText(
                  text: TextSpan(
                text: 'DATA CONTROLLER ',
                children: const [
                  TextSpan(
                      text:
                          'means a natural or legal person who (either alone or jointly or in common with other persons) determines the purposes for which and the manner in which any personal data are, or are to be, processed. For the purpose of this Privacy Policy, we are a Data Controller of your data.',
                      style: TextStyle(fontWeight: FontWeight.normal))
                ],
                style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat'),
              )),
              const SizedBox(
                height: 5,
              ),
              RichText(
                  text: TextSpan(
                text: 'DATA PROCESSORS (OR SERVICE PROVIDERS) ',
                children: const [
                  TextSpan(
                      text:
                          'means any natural or legal person who processes the data on behalf of the Data Controller. We may use the services of various Service Providers in order to process your data more effectively.',
                      style: TextStyle(fontWeight: FontWeight.normal))
                ],
                style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat'),
              )),
              const SizedBox(
                height: 5,
              ),
              RichText(
                  text: TextSpan(
                text: 'DATA SUBJECT ',
                children: const [
                  TextSpan(
                      text:
                          'is any living individual who is the subject of Personal Data.',
                      style: TextStyle(fontWeight: FontWeight.normal))
                ],
                style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat'),
              )),
              const SizedBox(
                height: 5,
              ),
              RichText(
                  text: TextSpan(
                text: 'THE USER ',
                children: const [
                  TextSpan(
                      text:
                          'is the individual using our Service. The User corresponds to the Data Subject, who is the subject of Personal Data.',
                      style: TextStyle(fontWeight: FontWeight.normal))
                ],
                style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat'),
              )),
              const SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                  text: '3. ',
                  children: const [
                    TextSpan(
                        text: 'Information Collection and Use',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Montserrat'),
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                  'We collect several different types of information for various purposes to provide and improve our Service to you.',
                  textAlign: TextAlign.justify),
              const SizedBox(
                height: 10,
              ),
              RichText(
                text: TextSpan(
                  text: '4. ',
                  children: const [
                    TextSpan(
                        text: 'Types of Data Collected',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Montserrat'),
                ),
              ),
              const SizedBox(height: 5),
              const Text(
                'Personal Data',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 5,
              ),
              RichText(
                  text: TextSpan(
                text:
                    'While using our Service, we may ask you to provide us with certain personally identifiable information that can be used to contact or identify you (',
                children: const [
                  TextSpan(
                      text: '“Personal Data”',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          '). Personally identifiable information may include, but is not limited to:',
                      style: TextStyle(fontWeight: FontWeight.normal))
                ],
                style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Montserrat'),
              )),
              const SizedBox(height: 5),
              const Text(
                '0.1. Email address',
              ),
              const SizedBox(height: 5),
              const Text(
                '0.2. First name and last name',
              ),
              const SizedBox(height: 5),
              const Text(
                '0.3. Phone number',
              ),
              const SizedBox(height: 5),
              const Text(
                '0.4. Address, Country, State, Province, ZIP/Postal code, City',
              ),
              const SizedBox(height: 5),
              const Text(
                '0.5. Cookies and Usage Data',
              ),
              const SizedBox(height: 5),
              const Text(
                'We may use your Personal Data to contact you with newsletters, marketing or promotional materials and other information that may be of interest to you. You may opt out of receiving any, or all, of these communications from us by following the unsubscribe link.',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 5),
              const Text(
                'Usage Data',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              RichText(
                  text: TextSpan(
                text:
                    'We may also collect information that your browser sends whenever you visit our Service or when you access Service by or through any device (',
                children: const [
                  TextSpan(
                      text: '“Usage Data”',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: ').',
                      style: TextStyle(fontWeight: FontWeight.normal))
                ],
                style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Montserrat'),
              )),
              const SizedBox(height: 10),
              const Text(
                'This Usage Data may include information such as your computer’s Internet Protocol address (e.g. IP address), browser type, browser version, the pages of our Service that you visit, the time and date of your visit, the time spent on those pages, unique device identifiers and other diagnostic data.',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              const Text(
                'When you access Service with a device, this Usage Data may include information such as the type of device you use, your device unique ID, the IP address of your device, your device operating system, the type of Internet browser you use, unique device identifiers and other diagnostic data',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 5),
              const Text(
                'Tracking Cookies Data',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'We use cookies and similar tracking technologies to track the activity on our Service and we hold certain information.',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              const Text(
                'You can instruct your browser to refuse all cookies or to indicate when a cookie is being sent. However, if you do not accept cookies, you may not be able to use some portions of our Service.',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              const Text(
                'Examples of Cookies we use:',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              RichText(
                  text: TextSpan(
                text: '0.1. ',
                children: const [
                  TextSpan(
                      text: 'Session Cookies: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: 'We use Session Cookies to operate our Service.',
                      style: TextStyle(fontWeight: FontWeight.normal))
                ],
                style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Montserrat'),
              )),
              const SizedBox(height: 10),
              RichText(
                  text: TextSpan(
                text: '0.2. ',
                children: const [
                  TextSpan(
                      text: 'Preference Cookies: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          'We use Preference Cookies to remember your preferences and various settings.',
                      style: TextStyle(fontWeight: FontWeight.normal))
                ],
                style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Montserrat'),
              )),
              const SizedBox(height: 10),
              RichText(
                  text: TextSpan(
                text: '0.3. ',
                children: const [
                  TextSpan(
                      text: 'Security Cookies: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: 'We use Security Cookies for security purposes.',
                      style: TextStyle(fontWeight: FontWeight.normal))
                ],
                style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Montserrat'),
              )),
              const SizedBox(height: 10),
              RichText(
                  text: TextSpan(
                text: '0.4. ',
                children: const [
                  TextSpan(
                      text: 'Advertising Cookies: ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          'Advertising Cookies are used to serve you with advertisements that may be relevant to you and your interests.',
                      style: TextStyle(fontWeight: FontWeight.normal))
                ],
                style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.normal,
                    fontFamily: 'Montserrat'),
              )),
              const SizedBox(height: 5),
              const Text(
                'Other Data',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'While using our Service, we may also collect the following information: sex, age, date of birth, place of birth, passport details, citizenship, registration at place of residence and actual address, telephone number (work, mobile), details of documents on education, qualification, professional training, employment agreements, NDA agreements, information on bonuses and compensation, information on marital status, family members, social security (or other taxpayer identification) number, office location and other data.',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: '5. ',
                  children: const [
                    TextSpan(
                        text: 'Use of Data',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Montserrat'),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                  'InHealth uses the collected data for various purposes:'),
              const SizedBox(height: 10),
              const Text('0.1. to provide and maintain our Service;'),
              const SizedBox(height: 10),
              const Text('0.2. to notify you about changes to our Service;'),
              const SizedBox(height: 10),
              const Text(
                  '0.3. to allow you to participate in interactive features of our Service when you choose to do so;'),
              const SizedBox(height: 10),
              const Text('0.4. to provide customer support;'),
              const SizedBox(height: 10),
              const Text(
                  '0.5. to gather analysis or valuable information so that we can improve our Service;'),
              const SizedBox(height: 10),
              const Text('0.6. to monitor the usage of our Service;'),
              const SizedBox(height: 10),
              const Text(
                  '0.7. to detect, prevent and address technical issues;'),
              const SizedBox(height: 10),
              const Text(
                  '0.8. to fulfil any other purpose for which you provide it;'),
              const SizedBox(height: 10),
              const Text(
                  '0.9. to carry out our obligations and enforce our rights arising from any contracts entered into between you and us, including for billing and collection;'),
              const SizedBox(height: 10),
              const Text(
                  '0.10. to provide you with notices about your account and/or subscription, including expiration and renewal notices, email-instructions, etc.;'),
              const SizedBox(height: 10),
              const Text(
                  '0.11. to provide you with news, special offers and general information about other goods, services and events which we offer that are similar to those that you have already purchased or enquired about unless you have opted not to receive such information;'),
              const SizedBox(height: 10),
              const Text(
                  '0.12. in any other way we may describe when you provide the information;'),
              const SizedBox(height: 10),
              const Text('0.13. for any other purpose with your consent.'),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: '6. ',
                  children: const [
                    TextSpan(
                        text: 'Retention of Data',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Montserrat'),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                  'We will retain your Personal Data only for as long as is necessary for the purposes set out in this Privacy Policy. We will retain and use your Personal Data to the extent necessary to comply with our legal obligations (for example, if we are required to retain your data to comply with applicable laws), resolve disputes, and enforce our legal agreements and policies.',
                  textAlign: TextAlign.justify),
              const SizedBox(height: 10),
              const Text(
                  'We will also retain Usage Data for internal analysis purposes. Usage Data is generally retained for a shorter period, except when this data is used to strengthen the security or to improve the functionality of our Service, or we are legally obligated to retain this data for longer time periods.',
                  textAlign: TextAlign.justify),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: '7. ',
                  children: const [
                    TextSpan(
                        text: 'Transfer of Data',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Montserrat'),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                  'Your information, including Personal Data, may be transferred to - and maintained on - computers located outside of your state, province, country or other governmental jurisdiction where the data protection laws may differ from those of your jurisdiction.',
                  textAlign: TextAlign.justify),
              const SizedBox(height: 10),
              const Text(
                  'If you are located outside Uzbekistan and choose to provide information to us, please note that we transfer the data, including Personal Data, to Uzbekistan and process it there.',
                  textAlign: TextAlign.justify),
              const SizedBox(height: 10),
              const Text(
                  'Your consent to this Privacy Policy followed by your submission of such information represents your agreement to that transfer.',
                  textAlign: TextAlign.justify),
              const SizedBox(height: 10),
              const Text(
                  'nHealth will take all the steps reasonably necessary to ensure that your data is treated securely and in accordance with this Privacy Policy and no transfer of your Personal Data will take place to an organisation or a country unless there are adequate controls in place including the security of your data and other personal information.',
                  textAlign: TextAlign.justify),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: '8. ',
                  children: const [
                    TextSpan(
                        text: 'Disclosure of Data',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Montserrat'),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                  'We may disclose personal information that we collect, or you provide:',
                  textAlign: TextAlign.justify),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: '0.1. ',
                  children: const [
                    TextSpan(
                        text: 'Business Transaction.',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Montserrat'),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                  'If we or our subsidiaries are involved in a merger, acquisition or asset sale, your Personal Data may be transferred.',
                  textAlign: TextAlign.justify),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: '0.2. ',
                  children: const [
                    TextSpan(
                        text:
                            'Other cases. We may disclose your information also:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Montserrat'),
                ),
              ),
              const SizedBox(height: 10),
              const Text('0.2.1. to our subsidiaries and affiliates;',
                  textAlign: TextAlign.justify),
              const SizedBox(height: 10),
              const Text(
                  '0.2.2. to contractors, service providers, and other third parties we use to support our business;'),
              const SizedBox(height: 10),
              const Text(
                  '0.2.3. to fulfill the purpose for which you provide it;'),
              const SizedBox(height: 10),
              const Text(
                  '0.2.4. for the purpose of including your company\'s logo on our website;'),
              const SizedBox(height: 10),
              const Text(
                  '0.2.5. for any other purpose disclosed by us when you provide the information;'),
              const SizedBox(height: 10),
              const Text('0.2.6. with your consent in any other cases;'),
              const SizedBox(height: 10),
              const Text(
                  '0.2.7. if we believe disclosure is necessary or appropriate to protect the rights, property, or safety of the Company, our customers, or others.'),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: '9. ',
                  children: const [
                    TextSpan(
                        text: 'Security of Data',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Montserrat'),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'The security of your data is important to us but remember that no method of transmission over the Internet or method of electronic storage is 100% secure. While we strive to use commercially acceptable means to protect your Personal Data, we cannot guarantee its absolute security.',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: '10. ',
                  children: const [
                    TextSpan(
                        text:
                            'Your Data Protection Rights Under General Data Protection Regulation (GDPR)',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Montserrat'),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'If you are a resident of the European Union (EU) and European Economic Area (EEA), you have certain data protection rights, covered by GDPR.',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              const Text(
                'We aim to take reasonable steps to allow you to correct, amend, delete, or limit the use of your Personal Data.',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              const Text(
                'We aim to take reasonable steps to allow you to correct, amend, delete, or limit the use of your Personal Data.',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text:
                      'If you wish to be informed what Personal Data we hold about you and if you want it to be removed from our systems, please email us at ',
                  children: const [
                    TextSpan(
                        text: 'omonovrahmatullo9@gmail.com.',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Montserrat'),
                ),
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text:
                      'If you wish to be informed what Personal Data we hold about you and if you want it to be removed from our systems, please email us at ',
                  children: const [
                    TextSpan(
                        text: 'omonovrahmatullo9@gmail.com.',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Montserrat'),
                ),
              ),
              const Text(
                  'In certain circumstances, you have the following data protection rights:',
                  textAlign: TextAlign.justify),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  '0.1. the right to access, update or to delete the information we have on you;',
                  textAlign: TextAlign.justify),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  '0.2. the right of rectification. You have the right to have your information rectified if that information is inaccurate or incomplete;',
                  textAlign: TextAlign.justify),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  '0.3. the right to object. You have the right to object to our processing of your Personal Data;',
                  textAlign: TextAlign.justify),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  '0.4. the right of restriction. You have the right to request that we restrict the processing of your personal information;',
                  textAlign: TextAlign.justify),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  '0.5. the right to data portability. You have the right to be provided with a copy of your Personal Data in a structured, machine-readable and commonly used format;',
                  textAlign: TextAlign.justify),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  '0.6. the right to withdraw consent. You also have the right to withdraw your consent at any time where we rely on your consent to process your personal information;',
                  textAlign: TextAlign.justify),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  'Please note that we may ask you to verify your identity before responding to such requests. Please note, we may not able to provide Service without some necessary data.',
                  textAlign: TextAlign.justify),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  'You have the right to complain to a Data Protection Authority about our collection and use of your Personal Data. For more information, please contact your local data protection authority in the European Economic Area (EEA).',
                  textAlign: TextAlign.justify),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: '11. ',
                  children: const [
                    TextSpan(
                        text:
                            'Your Data Protection Rights under the California Privacy Protection Act (CalOPPA)',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Montserrat'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  'CalOPPA is the first state law in the nation to require commercial websites and online services to post a privacy policy. The law’s reach stretches well beyond California to require a person or company in the United States (and conceivable the world) that operates websites collecting personally identifiable information from California consumers to post a conspicuous privacy policy on its website stating exactly the information being collected and those individuals with whom it is being shared, and to comply with this policy.',
                  textAlign: TextAlign.justify),
              const SizedBox(
                height: 10,
              ),
              const Text('According to CalOPPA we agree to the following:',
                  textAlign: TextAlign.justify),
              const SizedBox(
                height: 10,
              ),
              const Text('0.1. users can visit our site anonymously;',
                  textAlign: TextAlign.justify),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  '0.2. our Privacy Policy link includes the word “Privacy”, and can easily be found on the home page of our website;',
                  textAlign: TextAlign.justify),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  '0.3. users will be notified of any privacy policy changes on our Privacy Policy Page;',
                  textAlign: TextAlign.justify),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text:
                      '0.4. users are able to change their personal information by emailing us at . ',
                  children: const [
                    TextSpan(
                        text: 'omonovrahmatullo9@gmail.com.',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Montserrat'),
                ),
              ),
              const SizedBox(height: 10),
              const Text('Our Policy on “Do Not Track” Signals:',
                  textAlign: TextAlign.justify),
              const SizedBox(height: 10),
              const Text(
                  'We honor Do Not Track signals and do not track, plant cookies, or use advertising when a Do Not Track browser mechanism is in place. Do Not Track is a preference you can set in your web browser to inform websites that you do not want to be tracked.',
                  textAlign: TextAlign.justify),
              const SizedBox(height: 10),
              const Text(
                  'You can enable or disable Do Not Track by visiting the Preferences or Settings page of your web browser.',
                  textAlign: TextAlign.justify),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: '12. ',
                  children: const [
                    TextSpan(
                        text:
                            'Your Data Protection Rights under the California Consumer Privacy Act (CCPA)',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Montserrat'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'If you are a California resident, you are entitled to learn what data we collect about you, ask to delete your data and not to sell (share) it. To exercise your data protection rights, you can make certain requests and ask us:',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                '0.1. What personal information we have about you. If you make this request, we will return to you:',
                textAlign: TextAlign.justify,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  '0.0.1. The categories of personal information we have collected about you.',
                  textAlign: TextAlign.justify),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  '0.0.2. The categories of sources from which we collect your personal information.',
                  textAlign: TextAlign.justify),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  '0.0.3. The business or commercial purpose for collecting or selling your personal information.',
                  textAlign: TextAlign.justify),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  '0.0.4. The categories of third parties with whom we share personal information.',
                  textAlign: TextAlign.justify),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  '0.0.5. The specific pieces of personal information we have collected about you.',
                  textAlign: TextAlign.justify),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  '0.0.6. A list of categories of personal information that we have sold, along with the category of any other company we sold it to. If we have not sold your personal information, we will inform you of that fact.',
                  textAlign: TextAlign.justify),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  '0.0.7. A list of categories of personal information that we have disclosed for a business purpose, along with the category of any other company we shared it with.',
                  textAlign: TextAlign.justify),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  'Please note, you are entitled to ask us to provide you with this information up to two times in a rolling twelve-month period. When you make this request, the information provided may be limited to the personal information we collected about you in the previous 12 months.',
                  textAlign: TextAlign.justify),
              const SizedBox(
                height: 10,
              ),
              const Text(
                '0.2. To delete your personal information. If you make this request, we will delete the personal information we hold about you as of the date of your request from our records and direct any service providers to do the same. In some cases, deletion may be accomplished through de-identification of the information. If you choose to delete your personal information, you may not be able to use certain functions that require your personal information to operate.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                '0.3. To stop selling your personal information. We don’t sell or rent your personal information to any third parties for any purpose. We do not sell your personal information for monetary consideration. However, under some circumstances, a transfer of personal information to a third party, or within our family of companies, without monetary consideration may be considered a “sale” under California law. You are the only owner of your Personal Data and can request disclosure or deletion at any time.',
                textAlign: TextAlign.justify,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  'If you submit a request to stop selling your personal information, we will stop making such transfers.',
                  textAlign: TextAlign.justify),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  'Please note, if you ask us to delete or stop selling your data, it may impact your experience with us, and you may not be able to participate in certain programs or membership services which require the usage of your personal information to function. But in no circumstances, we will discriminate against you for exercising your rights.',
                  textAlign: TextAlign.justify),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text:
                      'To exercise your California data protection rights described above, please send your request(s) by email:',
                  children: const [
                    TextSpan(
                        text: ' omonovrahmatullo9@gmail.com',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Montserrat'),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                  'Your data protection rights, described above, are covered by the CCPA, short for the California Consumer Privacy Act. To find out more, visit the official California Legislative Information website. The CCPA took effect on 01/01/2020.',
                  textAlign: TextAlign.justify),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: '13. ',
                  children: const [
                    TextSpan(
                        text: 'Service Providers',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Montserrat'),
                ),
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text:
                      'We may employ third party companies and individuals to facilitate our Service (',
                  children: const [
                    TextSpan(
                        text: '“Service Providers”',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(
                        text:
                            '), provide Service on our behalf, perform Service-related services or assist us in analysing how our Service is used.')
                  ],
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Montserrat'),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'These third parties have access to your Personal Data only to perform these tasks on our behalf and are obligated not to disclose or use it for any other purpose.',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: '14. ',
                  children: const [
                    TextSpan(
                        text: 'Analytics',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Montserrat'),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'We may use third-party Service Providers to monitor and analyze the use of our Service.',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: '15. ',
                  children: const [
                    TextSpan(
                        text: 'CI/CD tools',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Montserrat'),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'We may use third-party Service Providers to automate the development process of our Service.',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: '16. ',
                  children: const [
                    TextSpan(
                        text: 'Behavioral Remarketing',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Montserrat'),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'We may use remarketing services to advertise on third party websites to you after you visited our Service. We and our third-party vendors use cookies to inform, optimise and serve ads based on your past visits to our Service.',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: '17. ',
                  children: const [
                    TextSpan(
                        text: 'Links to Other Sites',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Montserrat'),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Our Service may contain links to other sites that are not operated by us. If you click a third party link, you will be directed to that third party’s site. We strongly advise you to review the Privacy Policy of every site you visit.',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              const Text(
                'We have no control over and assume no responsibility for the content, privacy policies or practices of any third party sites or services.',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              const Text(
                'For example, the outlined privacy policy has been made using PolicyMaker.io, a free tool that helps create high-quality legal documents. PolicyMaker’s privacy policy generator is an easy-to-use tool for creating a privacy policy for blog, website, e-commerce store or mobile app.',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: '18. ',
                  children: const [
                    TextSpan(
                        text: 'Children\'s Privacy',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Montserrat'),
                ),
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text:
                      'Our Services are not intended for use by children under the age of 18 (',
                  children: const [
                    TextSpan(
                        text: '“Child”',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: ' or '),
                    TextSpan(
                        text: '“Children”',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextSpan(text: ').'),
                  ],
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Montserrat'),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'We do not knowingly collect personally identifiable information from Children under 18. If you become aware that a Child has provided us with Personal Data, please contact us. If we become aware that we have collected Personal Data from Children without verification of parental consent, we take steps to remove that information from our servers.',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: '19. ',
                  children: const [
                    TextSpan(
                        text: 'Changes to This Privacy Policy',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Montserrat'),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page.',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              const Text(
                'We will let you know via email and/or a prominent notice on our Service, prior to the change becoming effective and update “effective date” at the top of this Privacy Policy.',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              const Text(
                'You are advised to review this Privacy Policy periodically for any changes. Changes to this Privacy Policy are effective when they are posted on this page.',
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: '20. ',
                  children: const [
                    TextSpan(
                        text: 'Contact Us',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Montserrat'),
                ),
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text:
                      'If you have any questions about this Privacy Policy, please contact us by email: ',
                  children: const [
                    TextSpan(
                        text: 'omonovrahmatullo9@gmail.com',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'Montserrat'),
                ),
              ),
              const SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }
}
