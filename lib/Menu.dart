import 'package:flutter/material.dart';
import './Profileinfo.dart';
import 'package:adobe_xd/page_link.dart';
import './History.dart';
import './Myreport.dart';
import './About.dart';
import 'login.dart';
import 'Find.dart';
import 'package:flutter_svg/flutter_svg.dart';
class Menu extends StatelessWidget {
  Menu({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: 812.0,
            decoration: BoxDecoration(
              color: const Color(0xffffffff),
              border: Border.all(width: 1.0, color: const Color(0xff707070)),
            ),
          ),
          Container(
            height: 263.0,
            decoration: BoxDecoration(
              color: const Color(0xff4db8ac),
              boxShadow: [
                BoxShadow(
                  color: const Color(0x52000000),
                  offset: Offset(0, 3),
                  blurRadius: 6,
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: Offset(0.0, 303.0),
            child: Container(
              height: 64.0,
              decoration: BoxDecoration(
                color: const Color(0x21b1b1b1),
              ),
            ),
          ),
          Container(
            
            alignment: Alignment.topCenter,
            padding: EdgeInsets.fromLTRB(0,150, 0, 0),
            child: SizedBox(
              height: 35.0,
              child: Text(
                'Hi , USERNAME',
                style: TextStyle(
                  fontFamily: 'Segoe UI',
                  fontSize: 27,
                  color: const Color(0xffffffff),
                  fontWeight: FontWeight.w600,
                  shadows: [
                    Shadow(
                      color: const Color(0x00000000),
                      offset: Offset(0, 3),
                      blurRadius: 6,
                    )
                  ],
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ),

          Transform.translate(
            offset: Offset(125.0, 700.0),
            child: PageLink(
              links: [
                PageLinkInfo(
                  transition: LinkTransition.Fade,
                  ease: Curves.easeOut,
                  duration: 0.3,
                  pageBuilder: () => Find(),
                ),
              ],
              child: SizedBox(

                height: 35.0,
                child: Text(
                  'Find',
                  style: TextStyle(

                    fontFamily: 'Segoe UI',
                    fontSize: 22,
                    color: const Color(0xffb1b1b1),
                    fontWeight: FontWeight.w600,
                    shadows: [
                      Shadow(
                        color: const Color(0x00000000),
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      )
                    ],
                  ),
                  textAlign: TextAlign.center,

                ),
              ),
            ),
          ),

          Transform.translate(
            offset: Offset(101.0, 389.0),
            child: PageLink(
              links: [
                PageLinkInfo(
                  transition: LinkTransition.Fade,
                  ease: Curves.easeOut,
                  duration: 0.3,
                  pageBuilder: () => History(),
                ),
              ],
              child: Container(
                alignment: Alignment.center,
                width: 173.0,
                height: 35.0,
                child: Text(
                  'HISTORY',
                  style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 22,
                    color: const Color(0xffb1b1b1),
                    fontWeight: FontWeight.w600,
                    shadows: [
                      Shadow(
                        color: const Color(0x00000000),
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      )
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(101.0, 460.0),
            child: PageLink(
              links: [
                PageLinkInfo(
                  transition: LinkTransition.Fade,
                  ease: Curves.easeOut,
                  duration: 0.3,
                  pageBuilder: () => Myreport(),
                ),
              ],
              child: SizedBox(
                width: 173.0,
                height: 35.0,
                child: Text(
                  'MY REPoRTS',
                  style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 22,
                    color: const Color(0xffb1b1b1),
                    fontWeight: FontWeight.w600,
                    shadows: [
                      Shadow(
                        color: const Color(0x00000000),
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      )
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(56.0, 531.0),
            child: PageLink(
              links: [
                PageLinkInfo(
                  transition: LinkTransition.Fade,
                  ease: Curves.easeOut,
                  duration: 0.3,
                  pageBuilder: () => About(),
                ),
              ],
              child: SizedBox(
                width: 263.0,
                height: 35.0,
                child: Text(
                  'About us',
                  style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 22,
                    color: const Color(0xffb1b1b1),
                    fontWeight: FontWeight.w600,
                    shadows: [
                      Shadow(
                        color: const Color(0x00000000),
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      )
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(56.0, 737.0),
            child: PageLink(
              links: [
                PageLinkInfo(
                  transition: LinkTransition.Fade,
                  ease: Curves.easeOut,
                  duration: 0.3,
                  pageBuilder: () => login(),
                ),
              ],
              child: SizedBox(
                width: 263.0,
                height: 35.0,
                child: Text(
                  'LOGout',
                  style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize: 22,
                    color: const Color(0xffd35f71),
                    fontWeight: FontWeight.w600,
                    shadows: [
                      Shadow(
                        color: const Color(0x00000000),
                        offset: Offset(0, 3),
                        blurRadius: 6,
                      )
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0.0, 374.0),
            child: Container(
              height: 64.0,
              decoration: BoxDecoration(
                color: const Color(0x21b1b1b1),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0.0, 445.0),
            child: Container(
              height: 64.0,
              decoration: BoxDecoration(
                color: const Color(0x21b1b1b1),
              ),
            ),
          ),
          Transform.translate(
            offset: Offset(0.0, 516.0),
            child: Container(
              height: 64.0,
              decoration: BoxDecoration(
                color: const Color(0x21b1b1b1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
