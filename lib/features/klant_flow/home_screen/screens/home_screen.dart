// home_screen.dart

import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/core/utils/constants/image_path.dart';
import 'package:baxton/features/klant_flow/home_screen/controller/home_controller.dart';
import 'package:baxton/features/klant_flow/home_screen/widgets/infocard.dart';
import 'package:baxton/features/klant_flow/home_screen/widgets/service_widget.dart';
import 'package:baxton/features/klant_flow/notification/screens/notification_screen.dart';

import 'package:flutter/material.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/common/widgets/custom_icon_button.dart';

import '../models/home_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = HomeController();
    final List<Service> services = controller.getFirstTwoServices();

    return Scaffold(
      backgroundColor: Color(0xffFAFAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hallo",
                              style: getTextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            SizedBox(width: 4),
                            Image.asset(IconPath.hi, height: 20, width: 20),
                            SizedBox(width: 4),
                            Text(
                              "Russell!",
                              style: getTextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Welkom terug",
                          style: getTextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NotificationScreen(),
                              ),
                            );
                          },
                          child: Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                              color: Color(0xffFBF6E6),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.asset(
                              'assets/icons/notifications.png',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 17,
                      color: AppColors.buttonPrimary,
                    ),
                    Text(
                      "21 Baker Street, London",
                      style: getTextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Container(
                  height: 133,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color:
                        AppColors.primaryGold, // This will be behind the image
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: AssetImage(
                        ImagePath.card
                      ), 
                      fit: BoxFit.cover, // Adjust to cover entire container
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      "Van Schimmel tot \nOnderhoud-wij Hebben \nHet Gedekt.",
                      style: getTextStyle(
                        color: AppColors.textFifth,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),
                CustomIconButton(
                  text: "Vraag Service Aan",
                  icon: Icons.add,
                  onTap: () {},
                  buttonColor: AppColors.buttonPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  textColor: Colors.white,
                  iconColor: Colors.white,
                  isPrefix: false,
                ),
                SizedBox(height: 40),
                Text(
                  "Aangevraagde Service",
                  style: getTextStyle(
                    fontSize: 24,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 20),

                for (Service service in services)
                  ServiceContainer(service: service),
                  SizedBox(
                    height: 20,

                  ),
                  GestureDetector(
                    onTap: () {
                      
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Bekijk Alles",
                          style: getTextStyle(
                            color: AppColors.primaryGold,
                            fontSize: 16,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                        Icon(Icons.arrow_right_alt,
                        color: AppColors.primaryGold,
                        )
                      ],
                    ),
                  ),
                SizedBox(height: 40),

                //our service
                Text(
                  "Onze Diensten",
                  style: getTextStyle(
                    fontSize: 24,
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 16),
                InfoCard(
                  title: "Schimmelinspecties & \nBehandelingen",
                  description:
                      "Door inspecties en effectieve behandelingen om \nschimmelproblemen te voorkomen en op te lossen",
                  iconPath: IconPath.moldinspection,
                  
                ),
                SizedBox(height: 12),
                InfoCard(
                  title: "Voor- en na-inspecties van \nhuurwoningen & Nazorg",
                  description:
                      "Wij bieden inspecties voor en na de overdracht van \nonroerend goed en verzorgen alle nazorg met \nbetrekking tot leveringsproblemen.",
                  iconPath: IconPath.prepostinspection,
                  backgroundColor: Color(0xffF1CBBC),
                ),
                SizedBox(height: 12),
                InfoCard(
                  title: "Vochtbeheersing",
                  description:
                      "Wij bieden oplossingen voor vochtproblemen om \nonroerend goed droog en veilig te houden",
                  iconPath: IconPath.moisturecontrol,
                  backgroundColor: Color(0xff4BBBEB),
                ),
                SizedBox(height: 12),
                InfoCard(
                  title: "Stucwerk",
                  description:
                      "Alle soorten stucwerk, van renovatie tot afwerking, \nmet aandacht voor detail",
                  iconPath: IconPath.stucco,
                  backgroundColor: Color(0xffF1CBBC),
                ),
                SizedBox(height: 12),
                InfoCard(
                  title: "Schilderen & Coaten",
                  description:
                      "Professionele binnen- en buitenschilder- en \ncoatingdiensten voor perfecte resultaten",
                  iconPath: IconPath.painting,
                  backgroundColor: Color(0xffFFD039),
                ),
                SizedBox(height: 12),
                InfoCard(
                  title: "Nicotinevlekkenverwijdering",
                  description:
                      "Effectieve verwijdering van nicotinevlekken om een \nschone en frisse binnenomgeving te herstellen.",
                  iconPath: IconPath.nicotine,
                  backgroundColor: Color(0xff7A6D79),
                ),
                SizedBox(height: 12),
                InfoCard(
                  title: "Reddersteam & Nooddienst (24/7)",
                  description:
                      "Ons reddersteam is 24/7 beschikbaar voor opruiming \nen ontruiming na brand-, water- of rookschade of in \ngeval van overlijden.",
                  iconPath: IconPath.recueteam,
                  backgroundColor: Color(0xffFD4755),
                ),
                SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
