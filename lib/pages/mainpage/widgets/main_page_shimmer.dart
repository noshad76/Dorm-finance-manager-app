import 'package:expense_app/constants/const.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MainPageShimmer extends StatelessWidget {
  const MainPageShimmer({
    super.key,
    required this.height,
    required this.width,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: height * 0.4,
        child: ListView.separated(
          physics:
              const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) {
            return SizedBox(
              height: height * 0.006,
            );
          },
          itemCount: 4,
          itemBuilder: (context, index) {
            return Container(
              alignment: Alignment.centerRight,
              height: height * 0.09,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    width * 0.07),
                color: Constant.loginTextField,
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: width * 0.03,
                  ),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment
                            .spaceBetween,
                    children: [
                      SizedBox(
                        width: width * 0.01,
                      ),
                      Shimmer.fromColors(
                          baseColor: Constant
                              .sectionUnselected,
                          highlightColor: Constant
                              .mainPageCardbackground,
                          child: Container(
                            width: 100,
                            height: 20,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                          width *
                                              0.07),
                              color: Constant
                                  .loginTextField,
                            ),
                          )),
                      SizedBox(
                        width: width * 0.03,
                      ),
                      Shimmer.fromColors(
                          baseColor: Constant
                              .sectionUnselected,
                          highlightColor: Constant
                              .mainPageCardbackground,
                          child: Container(
                            width: width * 0.25,
                            height: width * 0.05,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                          width *
                                              0.07),
                              color: Constant
                                  .loginTextField,
                            ),
                          )),
                      SizedBox(
                        width: width * 0.01,
                      )
                    ],
                  ),
                  SizedBox(
                    height: width * 0.03,
                  ),
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.end,
                    children: [
                      Shimmer.fromColors(
                          baseColor: Constant
                              .sectionUnselected,
                          highlightColor: Constant
                              .mainPageCardbackground,
                          child: Container(
                            width: width * 0.4,
                            height: width * 0.05,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius
                                      .circular(
                                          width *
                                              0.07),
                              color: Constant
                                  .loginTextField,
                            ),
                          )),
                      const SizedBox(
                        width: 30,
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
  }
}
