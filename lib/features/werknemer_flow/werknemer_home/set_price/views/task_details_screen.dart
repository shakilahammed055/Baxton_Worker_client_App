// import 'package:baxton/core/common/styles/global_text_style.dart';
// import 'package:baxton/core/common/widgets/custom_continue_button.dart';
// import 'package:baxton/core/utils/constants/colors.dart';
// import 'package:baxton/core/utils/constants/icon_path.dart';
// import 'package:baxton/core/utils/constants/image_path.dart';
// import 'package:baxton/features/klant_flow/task_screen/screens/taakdetails_final.dart';
// import 'package:baxton/features/werknemer_flow/werknemer_home/set_price/controller/client_info_controller.dart';
// import 'package:baxton/features/werknemer_flow/werknemer_home/set_price/widget/client_info_card.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// // ignore: must_be_immutable
// class TaskDetailsScreen extends StatelessWidget {
//   TaskDetailsScreen({super.key});
//   ClientInfoController clientInfoController = Get.put(ClientInfoController());
//   // final ClientInfoModel info = ClientInfoModel(
//   //   location: '258 Cedar St',
//   //   dateTime: DateTime.now(),
//   // ); // Define 'info' here

//   @override
//   Widget build(BuildContext context) {
//     Get.put(ClientInfoController());
//     final dateStr = DateFormat('dd/MM/yyyy').format(DateTime.now());
//     final timeStr = DateFormat('HH:mm').format(DateTime.now());

//     return Scaffold(
//       appBar: AppBar(
//         leading: GestureDetector(
//           onTap: () => Get.back(),
//           child: Row(
//             children: [
//               const SizedBox(width: 16),
//               Image.asset(IconPath.arrowBack),
//             ],
//           ),
//         ),
//         centerTitle: true,
//         title: Text(
//           "Taakdetails",
//           style: getTextStyle(
//             color: AppColors.textPrimary,
//             fontSize: 24,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(15),
//           child: Column(
//             children: [
//               Container(
//                 width: double.infinity,
//                 height: 246,
//                 clipBehavior: Clip.antiAlias,
//                 decoration: ShapeDecoration(
//                   color: Colors.white,
//                   shape: RoundedRectangleBorder(
//                     side: BorderSide(width: 1, color: const Color(0xFFEBEBEB)),
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(9),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     spacing: 16,
//                     children: [
//                       SizedBox(
//                         width: 336,
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           spacing: 4,
//                           children: [
//                             Text(
//                               'Inspecteer Dak',
//                               textAlign: TextAlign.center,
//                               style: getTextStyle(
//                                 color: const Color(0xFF333333),
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),

//                             Text(
//                               'Neem de tijd om het dak grondig te inspecteren op eventuele schade. Kijk goed naar de shingles en zorg ervoor dat ze stevig vastzitten. Controleer ook of er geen scheuren of losse delen zijn die problemen kunnen veroorzaken. Vergeet niet om de randen en hoeken extra aandacht te geven, want daar ontstaan vaak de meeste problemen. Een goed onderhouden dak is essentieel voor de bescherming van je huis!',
//                               textAlign: TextAlign.center,
//                               style: getTextStyle(
//                                 color: const Color(0xFF666666),
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w400,
//                                 letterSpacing: -0.28,
//                                 lineHeight: 11,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       Row(
//                         mainAxisSize: MainAxisSize.min,
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         spacing: 16,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,

//                             spacing: 4,
//                             children: [
//                               Icon(
//                                 Icons.access_time,
//                                 size: 16,
//                                 color: Color(0xff1E90FF),
//                               ),
//                               Text(
//                                 '11:00 Am',
//                                 textAlign: TextAlign.center,
//                                 style: getTextStyle(
//                                   color: const Color(0xFF666666),
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.start,

//                             spacing: 4,
//                             children: [
//                               Icon(
//                                 Icons.location_on_outlined,
//                                 size: 16,
//                                 color: Color(0xff1E90FF),
//                               ),
//                               Text(
//                                 'New York',
//                                 style: getTextStyle(
//                                   color: const Color(0xFF666666),
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               ClientInfoCard(label: 'Naam', value: clientInfoController.clientInfo.customerName ?? ""),
//               SizedBox(height: 10),
//               ClientInfoCard(label: 'Locatie', value: clientInfoController.clientInfo.location),
//               SizedBox(height: 10),
//               ClientInfoCard(
//                 label: 'Telefoonnummer',
//                 value:
//                     clientInfoController.clientInfo.isNotEmpty
//                         ? clientInfoController.clientInfo.customerPhone ?? ""
//                         : "",
//               ),
//               SizedBox(height: 10),
//               ClientInfoCard(label: 'Gewenste datum', value: dateStr),
//               SizedBox(height: 10),
//               ClientInfoCard(label: 'Gewenste tijd', value: '$timeStr uur'),
//               SizedBox(height: 40),
//               SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {},
//                   style: ElevatedButton.styleFrom(
//                     side: BorderSide(color: AppColors.borderColor2),

//                     backgroundColor: AppColors.secondaryGold,
//                     foregroundColor: AppColors.primaryGold,
//                   ),
//                   child: Text("\$5000"),
//                 ),
//               ),

//               SizedBox(height: 30),
//               Column(
//                 spacing: 20,
//                 children: [
//                   SizedBox(
//                     width: 361,
//                     child: Text(
//                       'Taakchecklist',
//                       style: TextStyle(
//                         color: const Color(0xFF333333),
//                         fontSize: 18,
//                         fontFamily: 'Roboto',
//                         fontWeight: FontWeight.w600,
//                         height: 1.20,
//                       ),
//                     ),
//                   ),
//                   Column(
//                     spacing: 12,
//                     children: [
//                       Container(
//                         width: double.infinity,
//                         height: 60,
//                         clipBehavior: Clip.antiAlias,
//                         decoration: ShapeDecoration(
//                           color: const Color(0xFFFBF6E6),
//                           shape: RoundedRectangleBorder(
//                             side: BorderSide(
//                               width: 1,
//                               color: const Color(0xFFD9A300),
//                             ),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             spacing: 12,
//                             children: [
//                               Icon(
//                                 Icons.check_box,
//                                 size: 26,
//                                 color: AppColors.buttonPrimary,
//                               ),
//                               Text(
//                                 'Inspecteer het dak op zichtbare schade',
//                                 textAlign: TextAlign.center,
//                                 style: getTextStyle(
//                                   color: const Color(0xFF333333),
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Container(
//                         width: double.infinity,
//                         height: 60,
//                         clipBehavior: Clip.antiAlias,
//                         decoration: ShapeDecoration(
//                           color: const Color(0xFFFBF6E6),
//                           shape: RoundedRectangleBorder(
//                             side: BorderSide(
//                               width: 1,
//                               color: const Color(0xFFD9A300),
//                             ),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             spacing: 12,
//                             children: [
//                               Icon(
//                                 Icons.check_box,
//                                 size: 26,
//                                 color: AppColors.buttonPrimary,
//                               ),
//                               Text(
//                                 'Zoek naar schimmel of watervlekken',
//                                 textAlign: TextAlign.center,
//                                 style: getTextStyle(
//                                   color: const Color(0xFF333333),
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Container(
//                         width: double.infinity,
//                         height: 60,
//                         clipBehavior: Clip.antiAlias,
//                         decoration: ShapeDecoration(
//                           color: const Color(0xFFFBF6E6),
//                           shape: RoundedRectangleBorder(
//                             side: BorderSide(
//                               width: 1,
//                               color: const Color(0xFFD9A300),
//                             ),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             spacing: 12,
//                             children: [
//                               Icon(
//                                 Icons.check_box,
//                                 size: 26,
//                                 color: AppColors.buttonPrimary,
//                               ),
//                               Text(
//                                 'Maak fotos van eventuele schade',
//                                 textAlign: TextAlign.center,
//                                 style: getTextStyle(
//                                   color: const Color(0xFF333333),
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Container(
//                         width: double.infinity,
//                         height: 60,
//                         clipBehavior: Clip.antiAlias,
//                         decoration: ShapeDecoration(
//                           color: const Color(0xFFFBF6E6),
//                           shape: RoundedRectangleBorder(
//                             side: BorderSide(
//                               width: 1,
//                               color: const Color(0xFFD9A300),
//                             ),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             spacing: 12,
//                             children: [
//                               Icon(
//                                 Icons.check_box,
//                                 size: 26,
//                                 color: AppColors.buttonPrimary,
//                               ),
//                               Text(
//                                 'Rapporteer aan de administratie',
//                                 textAlign: TextAlign.center,
//                                 style: getTextStyle(
//                                   color: const Color(0xFF333333),
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Container(
//                         width: double.infinity,
//                         height: 60,
//                         clipBehavior: Clip.antiAlias,
//                         decoration: ShapeDecoration(
//                           color: const Color(0xFFFBF6E6),
//                           shape: RoundedRectangleBorder(
//                             side: BorderSide(
//                               width: 1,
//                               color: const Color(0xFFD9A300),
//                             ),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             spacing: 24,
//                             children: [
//                               Icon(
//                                 Icons.check_box,
//                                 size: 26,
//                                 color: AppColors.buttonPrimary,
//                               ),
//                               Text(
//                                 'Vraag om handtekening van de klant',
//                                 textAlign: TextAlign.center,
//                                 style: getTextStyle(
//                                   color: const Color(0xFF333333),
//                                   fontSize: 16,
//                                   fontWeight: FontWeight.w400,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: 32),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     children: [
//                       Image.asset(ImagePath.before, height: 150, width: 173),
//                       SizedBox(height: 8),
//                       Text(
//                         "Foto van tevoren",
//                         style: getTextStyle(
//                           fontSize: 16,
//                           color: AppColors.primaryGold,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       Image.asset(ImagePath.after, height: 150, width: 173),
//                       SizedBox(height: 8),
//                       Text(
//                         "Na Foto",
//                         style: getTextStyle(
//                           fontSize: 16,
//                           color: AppColors.primaryGold,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: 40),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   "Uw Handtekening",
//                   style: getTextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.textPrimary,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 12),
//               Container(
//                 height: 190,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Color(0xff000000).withValues(alpha: .2),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               SizedBox(height: 40),
//               Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   "Laat een beoordeling achter",
//                   style: getTextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.textPrimary,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 12),
//               TextField(
//                 maxLines: 3,
//                 decoration: InputDecoration(
//                   filled: true,
//                   fillColor: Color(0xffC0C0C0).withValues(
//                     alpha: 0.2,
//                   ), // use withOpacity instead of withValues(alpha: .2)

//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(4.0),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16),
//               // Align(
//               //   alignment: Alignment.centerLeft,
//               //   child: Container(
//               //     height: 40,
//               //     width: 105,
//               //     decoration: BoxDecoration(
//               //       border: Border.all(color: Color(0xffC0C0C0), width: 1),
//               //       borderRadius: BorderRadius.circular(12),
//               //     ),
//               //     child: Obx(
//               //       () => DropdownButton<int>(
//               //         //value: taskController.selectedValue.value,
//               //         icon: Padding(
//               //           padding: EdgeInsets.only(
//               //             left: 25,
//               //           ), // Adjust right padding here
//               //           child: Image.asset(
//               //             IconPath.dropdown,
//               //             height: 20, // Optional: control icon size
//               //             width: 20,
//               //           ),
//               //         ),
//               //         style: TextStyle(
//               //           color: AppColors.textPrimary,
//               //           fontSize: 18,
//               //           fontWeight: FontWeight.w600,
//               //         ),
//               //         underline: Container(
//               //           height: 2,
//               //           color: Colors.transparent,
//               //         ),
//               //         onChanged: (int? newValue) {
//               //           // if (newValue != null) {
//               //           //   taskController.selectedValue.value =
//               //           //       newValue; // update observable here
//               //           // }
//               //         },
//               //         items:
//               //             <int>[1, 2, 3, 4, 5].map<DropdownMenuItem<int>>((
//               //               int value,
//               //             ) {
//               //               return DropdownMenuItem<int>(
//               //                 value: value,
//               //                 child: Padding(
//               //                   padding: const EdgeInsets.all(8.0),
//               //                   child: Row(
//               //                     children: [
//               //                       Text(value.toString()),
//               //                       SizedBox(width: 8),
//               //                       Image.asset(
//               //                         IconPath.star,
//               //                         height: 15,
//               //                         width: 15,
//               //                       ),
//               //                     ],
//               //                   ),
//               //                 ),
//               //               );
//               //             }).toList(),
//               //       ),
//               //     ),
//               //   ),
//               // ),
//               SizedBox(height: 32),
//               CustomContinueButton(
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => TaakdetailsFinalScreen(),
//                     ),
//                   );
//                 },
//                 title: "Indienen",
//                 backgroundColor: AppColors.buttonPrimary,
//                 textColor: AppColors.textWhite,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
