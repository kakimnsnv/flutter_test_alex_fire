import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  int blockCount = 3;
  int timerSecs = 89;
  bool timeeer = true;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 200,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/top-bottom.png"),
                  fit: BoxFit.fill,
                  alignment: Alignment.center,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const DecorationBlock(
                      isTransparent: true,
                    ),
                    SizedBox(height: 16),
                    for (var i = 0; i < widget.blockCount; i++) ...[
                      const DecorationBlock(),
                      SizedBox(height: 16),
                    ],
                  ],
                ),
                SizedBox(width: 16),
                Column(
                  children: [
                    Row(
                      children: [
                        for (var i = 0; i < widget.blockCount; i++) ...[
                          const DecorationBlock(),
                          SizedBox(width: 16),
                        ],
                      ],
                    ),
                    SizedBox(height: 16),
                    for (var i = 0; i < widget.blockCount; i++) ...[
                      Row(
                        children: [
                          for (var i = 0; i < widget.blockCount; i++) ...[
                            Block(1),
                            SizedBox(width: 16),
                          ]
                        ],
                      ),
                      SizedBox(height: 16),
                    ]
                  ],
                ),
              ],
            ),
            Container(
              height: 200,
              decoration: ShapeDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/top-bottom.png"),
                  fit: BoxFit.fill,
                  alignment: Alignment.center,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 25),
                      if (widget.timeeer)
                        Expanded(
                          child: Timeer(
                            timerSecs: widget.timerSecs,
                            callback: () {
                              setState(() {
                                widget.timerSecs = widget.timerSecs;
                                widget.blockCount = widget.blockCount;
                              });
                            },
                          ),
                        ),
                      if (!widget.timeeer)
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xffCC620C),
                            ),
                            child: Text("timer: 0"),
                          ),
                        ),
                      SizedBox(width: 25),
                      Expanded(
                          child: GestureDetector(
                        onTapDown: (_) {
                          setState(() {
                            widget.blockCount = widget.blockCount;
                            widget.timeeer = false;
                          });
                        },
                        onTapUp: (_) {
                          setState(() {
                            widget.timeeer = true;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                          alignment: Alignment.center,
                          decoration: ShapeDecoration(
                            gradient: RadialGradient(
                              colors: [
                                const Color(0xff97D450),
                                const Color(0xff74BD3E),
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(width: 1, color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            shadows: [
                              BoxShadow(
                                color: const Color(0xff266E00),
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Text(
                            "restart",
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
                          ),
                        ),
                      )),
                      SizedBox(width: 25),
                    ],
                  ),
                  GestureDetector(
                    onTapDown: (_) {
                      setState(() {
                        widget.blockCount = (++widget.blockCount > 5) ? 3 : widget.blockCount++;
                        switch (widget.blockCount) {
                          case 3:
                            widget.timerSecs = 89;
                          case 4:
                            widget.timerSecs = 149;
                          case 5:
                            widget.timerSecs = 209;
                          default:
                            widget.timerSecs = 89;
                        }
                        ;
                        widget.timeeer = false;
                      });
                    },
                    onTapUp: (_) {
                      setState(() {
                        widget.timeeer = true;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                      alignment: Alignment.center,
                      decoration: ShapeDecoration(
                        gradient: RadialGradient(
                          colors: [
                            const Color(0xff97D450),
                            const Color(0xff74BD3E),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Colors.white),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        shadows: [
                          BoxShadow(
                            color: const Color(0xff266E00),
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        "change level",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 20),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Timeer extends StatefulWidget {
  const Timeer({super.key, required this.timerSecs, required this.callback});
  final int timerSecs;
  final Function() callback;

  @override
  State<Timeer> createState() => _TimeerState();
}

class _TimeerState extends State<Timeer> {
  late Timer timer;
  late int timerSecs;

  @override
  void initState() {
    timerSecs = widget.timerSecs;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (timerSecs > 0) {
          timerSecs--;
        } else {
          widget.callback();
          timerSecs = widget.timerSecs;
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffCC620C),
      ),
      child: Text("timer: $timerSecs"),
    );
  }
}

class DecorationBlock extends StatelessWidget {
  const DecorationBlock({
    super.key,
    this.isTransparent = false,
  });

  final bool isTransparent;
  final Color color = const Color(0xff57eed7);
  final Color color1 = const Color(0xff10ad97);
  final Color shadowColor = const Color(0xff10AD97);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 42,
      height: 42,
      decoration: isTransparent
          ? const BoxDecoration(color: Colors.transparent)
          : ShapeDecoration(
              gradient: RadialGradient(
                colors: [
                  color,
                  color1,
                ],
              ),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1, color: Colors.white),
                borderRadius: BorderRadius.circular(10),
              ),
              shadows: [
                BoxShadow(
                  color: shadowColor,
                  offset: Offset(0, 2),
                ),
              ],
            ),
    );
  }
}

class Block extends StatefulWidget {
  Block(
    this.value, {
    super.key,
  });

  int value = 1;
  bool isTapDown = false;

  @override
  State<Block> createState() => _BlockState();
}

class _BlockState extends State<Block> {
  Color get color {
    switch (widget.value) {
      case 1:
        return const Color(0xff97D450);
      case 2:
        return const Color(0xff507AD4);
      case 3:
        return const Color(0xffB137DB);
      case 4:
        return const Color(0xffFFAA3B);
      case 5:
        return const Color(0xffFF3B3B);
      default:
        return Colors.transparent;
    }
  }

  Color get color1 {
    switch (widget.value) {
      case 1:
        return const Color(0xff74BD3E);
      case 2:
        return const Color(0xff3E4DBD);
      case 3:
        return const Color(0xff8617AB);
      case 4:
        return const Color(0xffFF8531);
      case 5:
        return const Color(0xffDE1717);
      default:
        return Colors.transparent;
    }
  }

  Color get shadowColor {
    switch (widget.value) {
      case 1:
        return const Color(0xff266E00);
      case 2:
        return const Color(0xff000F6E);
      case 3:
        return const Color(0xff47006E);
      case 4:
        return const Color(0xff9A4800);
      case 5:
        return const Color(0xff870000);
      default:
        return Colors.transparent;
    }
  }

  increment() {
    setState(() {
      widget.value = widget.value++ % 5 + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: increment,
      onTapDown: (_) {
        setState(() {
          widget.isTapDown = true;
        });
      },
      onTapUp: (_) {
        setState(() {
          widget.isTapDown = false;
        });
      },
      child: Container(
        alignment: Alignment.center,
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [
              color,
              color1,
            ],
          ),
          border: Border(
            bottom: BorderSide(
              color: Colors.white,
              width: 1,
            ),
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            if (!widget.isTapDown)
              BoxShadow(
                color: shadowColor,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Text(
          widget.value.toString(),
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 25),
        ),
      ),
    );
  }
}
