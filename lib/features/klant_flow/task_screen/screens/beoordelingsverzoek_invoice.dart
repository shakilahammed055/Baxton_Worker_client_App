import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/common/widgets/custom_continue_button.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:baxton/core/utils/constants/icon_path.dart';
import 'package:baxton/features/klant_flow/task_screen/controller/request_controller.dart';
import 'package:baxton/features/klant_flow/task_screen/screens/back_to_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class BetalingsbeheerInvoiceScreen extends StatelessWidget {
  BetalingsbeheerInvoiceScreen({super.key});

  final RequestController requestController = Get.put(RequestController());

  @override
  Widget build(BuildContext context) {
    // Trigger invoice fetch when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (requestController.shouldFetchInvoice.value &&
          requestController.serviceRequest.value != null &&
          requestController.serviceRequest.value!.invoiceId != null) {
        requestController.getInvoice();
      }
    });

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Betalingsbeheer",
          style: getTextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: Obx(() {
        final invoice = requestController.invoice.value;
        if (invoice == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = invoice.data;
        final totalPrice = data.serviceDetail.fold(
          0,
          (sum, item) => sum + item.taskPrice,
        );

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Factuur Genereren",
                      style: getTextStyle(
                        color: AppColors.primaryGold,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                Text(
                  "80% Voltooid",
                  style: getTextStyle(
                    color: const Color(0xff0072C3),
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 32,
                  lineHeight: 14.0,
                  percent: 0.8, // Hardcoded to 80%
                  backgroundColor: Colors.grey[300],
                  progressColor: const Color(0xff0043CE),
                  barRadius: const Radius.circular(10),
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                ),
                const SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xffFBF6E6),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: 148,
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                          color: Color(0xffF3E2B0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.asset(IconPath.logo1, height: 42, width: 119),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "adres:",
                                  style: getTextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.primaryGold,
                                  ),
                                ),
                                Text(
                                  " ${data.companyInfo.city}, ${data.companyInfo.state}",
                                  style: getTextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff5B4400),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Telefoon:",
                                  style: getTextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.primaryGold,
                                  ),
                                ),
                                Text(
                                  " ${data.companyInfo.phone}",
                                  style: getTextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff5B4400),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "E-mail:",
                                  style: getTextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.primaryGold,
                                  ),
                                ),
                                Text(
                                  " ${data.companyInfo.email}",
                                  style: getTextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xff5B4400),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 95,
                                  child: Text(
                                    'Invoice Number: ${data.invoiceNumber}',
                                    style: getTextStyle(
                                      color: const Color(0xff5B4400),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      lineHeight: 9,
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Datum uitgegeven: ${DateFormat('dd MMMM yyyy').format(data.serviceRequestDetails.updatedAt)}',
                                      textAlign: TextAlign.center,
                                      style: getTextStyle(
                                        color: const Color(0xff5B4400),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                        lineHeight: 8,
                                      ),
                                    ),
                                    Text(
                                      'Vervaldatum: ${DateFormat('dd MMMM yyyy').format(data.serviceRequestDetails.updatedAt.add(const Duration(days: 14)))}',
                                      textAlign: TextAlign.center,
                                      style: getTextStyle(
                                        color: const Color(0xff5B4400),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(12),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    width: 1,
                                    color: Color(0xFFEBEBEB),
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Klantinformatie',
                                    style: getTextStyle(
                                      color: const Color(0xFF333333),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Naam',
                                        style: getTextStyle(
                                          color: const Color(0xFF666666),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.28,
                                        ),
                                      ),
                                      Text(
                                        data.clientInfo.name,
                                        textAlign: TextAlign.center,
                                        style: getTextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Telefoonnummer',
                                        style: getTextStyle(
                                          color: Color(0xFF666666),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.28,
                                        ),
                                      ),
                                      Text(
                                        data.clientInfo.phone,
                                        textAlign: TextAlign.center,
                                        style: getTextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'E-mail',
                                        style: getTextStyle(
                                          color: const Color(0xFF666666),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.28,
                                        ),
                                      ),
                                      Text(
                                        data.clientInfo.email,
                                        textAlign: TextAlign.center,
                                        style: getTextStyle(
                                          color: const Color(0xFF333333),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Stad',
                                        style: getTextStyle(
                                          color: const Color(0xFF666666),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.28,
                                        ),
                                      ),
                                      Text(
                                        data.clientInfo.location,
                                        textAlign: TextAlign.center,
                                        style: getTextStyle(
                                          color: const Color(0xFF333333),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Postcode',
                                        style: getTextStyle(
                                          color: const Color(0xFF666666),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.28,
                                        ),
                                      ),
                                      Text(
                                        data.clientInfo.postalCode,
                                        textAlign: TextAlign.center,
                                        style: getTextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(12),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1,
                                    color: Color(0xFFEBEBEB),
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Medewerkerinformatie',
                                    style: getTextStyle(
                                      color: const Color(0xFF333333),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      lineHeight: 10,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Naam',
                                        style: getTextStyle(
                                          color: Color(0xFF666666),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.28,
                                        ),
                                      ),
                                      Text(
                                        data.workerInfo.name,
                                        textAlign: TextAlign.center,
                                        style: getTextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Telefoonnummer',
                                        style: getTextStyle(
                                          color: Color(0xFF666666),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.28,
                                        ),
                                      ),
                                      Text(
                                        data.workerInfo.phone,
                                        textAlign: TextAlign.center,
                                        style: getTextStyle(
                                          color: Color(0xFF333333),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(12),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1,
                                    color: Color(0xFFEBEBEB),
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Servicedetails',
                                    style: getTextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  ...data.serviceDetail.map(
                                    (service) => Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 4,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            service.taskName,
                                            style: getTextStyle(
                                              color: Color(0xFF666666),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: -0.28,
                                            ),
                                          ),
                                          Text(
                                            '€${service.taskPrice}',
                                            textAlign: TextAlign.center,
                                            style: getTextStyle(
                                              color: Color(0xFF1E90FF),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.symmetric(vertical: 8),
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 1,
                                          color: Color(0xFFEBEBEB),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Totaal',
                                        style: getTextStyle(
                                          color: Color(0xFF666666),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.28,
                                        ),
                                      ),
                                      Text(
                                        '€$totalPrice',
                                        textAlign: TextAlign.center,
                                        style: getTextStyle(
                                          color: Color(0xFF1E90FF),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(12),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 1,
                                    color: Color(0xFFEBEBEB),
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Betalingsdetails',
                                    style: getTextStyle(
                                      color: Color(0xFF333333),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Banknaam',
                                        style: getTextStyle(
                                          color: Color(0xFF666666),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.28,
                                        ),
                                      ),
                                      Text(
                                        data.bankInfo.bankName,
                                        textAlign: TextAlign.center,
                                        style: getTextStyle(
                                          color: Color(0xFF1E90FF),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'IBAN',
                                        style: getTextStyle(
                                          color: Color(0xFF666666),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.28,
                                        ),
                                      ),
                                      Text(
                                        data.bankInfo.iban,
                                        textAlign: TextAlign.center,
                                        style: getTextStyle(
                                          color: Color(0xFF1E90FF),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'BIC/SWIFT',
                                        style: getTextStyle(
                                          color: Color(0xFF666666),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: -0.28,
                                        ),
                                      ),
                                      Text(
                                        data.bankInfo.bicOrSwift,
                                        textAlign: TextAlign.center,
                                        style: getTextStyle(
                                          color: Color(0xFF1E90FF),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(15),
                              decoration: ShapeDecoration(
                                color: Color(0x33FF3B30).withValues(alpha: 0.2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Bij het doen van de betaling, gelieve het factuurnummer (${data.invoiceNumber}) als betalingsreferentie of beschrijving op te nemen. Dit zorgt ervoor dat uw betaling correct aan uw taak en factuur wordt gekoppeld.',
                                textAlign: TextAlign.center,
                                style: getTextStyle(
                                  color: Color(0xFFFF3B30),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  lineHeight: 12,
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                CustomContinueButton(
                  onTap: () {
                    // Stop invoice fetching
                    requestController.stopInvoiceFetching();

                    // Navigate to BackToHome
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BackToHome()),
                    );
                  },
                  title: "Betalen",
                  backgroundColor: AppColors.buttonPrimary,
                  textColor: AppColors.textWhite,
                ),
                SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    // Implement invoice download logic here
                  },
                  child: Container(
                    width: double.infinity,
                    height: 44,
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFF1E90FF)),
                        borderRadius: BorderRadius.circular(62),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 20,
                          height: 20,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(),
                          child: Image.asset(IconPath.downloaddocument),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Factuur Downloaden',
                          style: getTextStyle(
                            color: Color(0xFF1E90FF),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
