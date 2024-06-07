import 'package:flutter/material.dart';

class popupWidget extends StatefulWidget {
  const popupWidget({super.key});

  @override
  State<popupWidget> createState() => _popupWidgetState();
}

class _popupWidgetState extends State<popupWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Stack(
              children: [
                Text("Mravlag Manor 3",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    )),
                Text("Last Updated 21:31",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ))
              ],
            ),
            // Image.asset(
            //   "assets/Vector.png",
            //   width: 12,
            //   height: 12,
            // )
          ],
        ),
        Stack(
          children: [
            Text("Air Quality Measures",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                )),
            Column(
              children: [
                Row(
                  children: [
                    Text("AQI",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        )),
                    Row(
                      children: [
                        Column(
                          children: [
                            Stack(
                              children: [
                                Image.asset(
                                  "assets/Ellipse 1.png",
                                  width: 40,
                                  height: 40,
                                ),
                                Text("30",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ))
                              ],
                            )
                          ],
                        ),
                        Text("Good",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ))
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    Stack(
                      children: [
                        Text("pm2.5",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            )),
                        Text("μg/m³",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ))
                      ],
                    ),
                    Stack(
                      children: [
                        Column(
                          children: [
                            Stack(
                              children: [
                                Image.asset(
                                  "assets/Ellipse 1.png",
                                  width: 40,
                                  height: 40,
                                ),
                                Text("100",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ))
                              ],
                            )
                          ],
                        ),
                        Text("Unhealthy",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ))
                      ],
                    )
                  ],
                )
              ],
            )
          ],
        ),
        Text("View Device History",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ))
      ],
    );
  }
}
