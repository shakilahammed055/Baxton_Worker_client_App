import 'package:baxton/core/common/styles/global_text_style.dart';
import 'package:baxton/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';

import '../models/home_model.dart';

class ServiceContainer extends StatelessWidget {
  final Service service;

  const ServiceContainer({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color(0xffFFFFFF),
            border: Border.all(width: 1, color: Color(0xffEBEBEB)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      service.title,
                      style: getTextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 16,
                          color: AppColors.buttonPrimary,
                        ),
                        Text(
                          service.location,
                          style: getTextStyle(
                            color: Color(0xff666666),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  service.description,
                  style: getTextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff666666),
                    lineHeight: 11,
                  ),
                ),
                SizedBox(height: 21),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 29,
                          width: 85,
                          decoration: BoxDecoration(
                            color: Color(0xffE9F4FF),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: Text(
                                "Gepland",
                                style: getTextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.buttonPrimary,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          service.time,
                          style: getTextStyle(
                            color: Color(0xff666666),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 40,
                      width: 98,
                      decoration: BoxDecoration(
                        color: AppColors.buttonPrimary,
                        borderRadius: BorderRadius.circular(62),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Details",
                          style: getTextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
