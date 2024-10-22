import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class DateAppBar extends StatelessWidget implements PreferredSizeWidget {
  final DateTime currentDate;
  final VoidCallback onRemoveDay;
  final VoidCallback onAddDay;
  final Future<void> Function(BuildContext) onSelectDate;

  const DateAppBar({
    super.key,
    required this.currentDate,
    required this.onRemoveDay,
    required this.onAddDay,
    required this.onSelectDate,
  });

  @override
  Widget build(BuildContext context) {
    // Obtenir la date actuelle et la formater
    String formattedDate =
        DateFormat('EEEE d MMMM yyyy', 'fr_FR').format(currentDate);
    List<String> dateParts = formattedDate.split(' ');

    return AppBar(
      title: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: onRemoveDay,
                  child: SvgPicture.asset(
                    'assets/icons/arrow-left.svg',
                    colorFilter:
                        ColorFilter.mode(Color(0xFFBFBEBE), BlendMode.srcIn),
                    width: 40,
                    height: 40,
                  ),
                ),
                Flexible(
                  child: GestureDetector(
                    onTap: () => onSelectDate(context),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: '${dateParts[0]} ${dateParts[1]}',
                          style: TextStyle(
                              fontFamily: "Londrina",
                              fontSize: 56,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF2E7984)) // Jour
                          ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: onAddDay,
                  child: SvgPicture.asset(
                    'assets/icons/arrow-right.svg',
                    colorFilter:
                        ColorFilter.mode(Color(0xFFBFBEBE), BlendMode.srcIn),
                    width: 40,
                    height: 40,
                  ),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: GestureDetector(
                    onTap: () => onSelectDate(context),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: '${dateParts[2]} ${dateParts[3]}',
                        style: TextStyle(
                          color:
                              Color(0xFF2E7984), // Couleur du texte de l'AppBar
                          fontSize: 20.0, // Jour
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        100.0,
      );
}
