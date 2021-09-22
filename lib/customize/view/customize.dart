import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'animated_toggle_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import "../bloc/customize_cubit.dart";
import "../bloc/customize_state.dart";
import '../model/customize_model.dart';

enum CustomizeCardType { CORRECTIONS, TRANSLATIONS }

extension CustomizeCardTypeExtension on CustomizeCardType {
  String get title {
    switch (this) {
      case CustomizeCardType.CORRECTIONS:
        return 'Corrections';
      case CustomizeCardType.TRANSLATIONS:
        return 'Translations';
    }
  }

  String get subTitle {
    switch (this) {
      case CustomizeCardType.CORRECTIONS:
        return 'How strictly will Slai treat your texts';
      case CustomizeCardType.TRANSLATIONS:
        return 'The translation button will be displayed next to the messages and error description';
    }
  }

  List<String> get summary {
    switch (this) {
      case CustomizeCardType.CORRECTIONS:
        return [
          'Slai will chat with you on different '
              'topics and ignore all the errors you make. '
              'Nonetheless, you can see your errors in your '
              'Statistics. Recommended for those who want to '
              'focus on fluency more than accuracy.',
          'Slai will highlight all errors he can find in '
              'your messages. Recommended for those who want to '
              'approach their learning in the most pedantic way possible.'
        ];
      case CustomizeCardType.TRANSLATIONS:
        return [
          'You will not see the translate button. '
              'Recommended for those who can already '
              'understand texts in English. This is much '
              'more effective approach to language learning '
              'and we strongly recommend you to activate '
              'this mode as soon as possible.',
          'You will see the button. It will show you the '
              'translation of the wanted text only if you '
              'press it. Recommended for starters and '
              'elementary students. This is not a very '
              'effective way to study English. We suggest '
              'that you use the button only in case you can '
              'not understand even one word. Try to guess the '
              'meaning of the sentence by the familiar words '
              'even if there are few.'
        ];
    }
  }

  List<String> get toggleOptions {
    switch (this) {
      case CustomizeCardType.CORRECTIONS:
        return ['Just chatting', 'Show all corrections'];
      case CustomizeCardType.TRANSLATIONS:
        return ['Only English', 'Show me the button'];
    }
  }

  List<Widget> get icons {
    switch (this) {
      case CustomizeCardType.CORRECTIONS:
        return [Icon(Icons.document_scanner), Icon(Icons.chat)];
      case CustomizeCardType.TRANSLATIONS:
        return [Icon(Icons.translate), Icon(Icons.not_accessible)];
    }
  }
}

class Customize extends StatefulWidget {
  @override
  _CustomizeState createState() => _CustomizeState();
}

class _CustomizeState extends State<Customize> {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    //CustomizeAnswer customizeInfo = loadCustomize();
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Color(0xFF282948),
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        centerTitle: true,
        title: Text('Customize',
            style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold)),
      ),
      backgroundColor: Color(0xFF282948),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: BlocBuilder<CustomizeCubit, CustomizeState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is LoadedState) {
              return Column(
                children: [
                  CustomizeCard(
                    CustomizeCardType.CORRECTIONS,
                    _scrollController,
                    state.customizeInfo.correctErrors,
                  ),
                  CustomizeCard(
                    CustomizeCardType.TRANSLATIONS,
                    _scrollController,
                    state.customizeInfo.showTranslations,
                  ),
                ],
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomizeCard extends StatefulWidget {
  final CustomizeCardType type;
  final ScrollController _scrollController;
  final bool isFirstOption;

  CustomizeCard(this.type, this._scrollController, this.isFirstOption);

  @override
  _CustomizeCardState createState() =>
      _CustomizeCardState(type, _scrollController, isFirstOption);
}

class _CustomizeCardState extends State<CustomizeCard> {
  final CustomizeCardType type;
  final ScrollController _scrollController;
  final bool isFirstOption;

  _CustomizeCardState(
    this.type,
    this._scrollController,
    this.isFirstOption,
  );

  bool isSummaryVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12.0, bottom: 12, left: 17, right: 17),
      child: Container(
        width: double.infinity,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          color: Color(0xFFF7F4FD),
          child: Padding(
            padding: const EdgeInsets.only(
                bottom: 24.0, top: 24, left: 16, right: 16),
            child: Column(children: [
              Text(
                type.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF282948)),
              ),
              SizedBox(height: 8),
              Text(
                type.subTitle,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Color(0xFF282948)),
              ),
              SizedBox(height: 32),
              BlocBuilder<CustomizeCubit, CustomizeState>(
                builder: (context, state) {
                  if (type == CustomizeCardType.CORRECTIONS) {
                    if (state is LoadedState) {
                      return AnimatedToggle(
                        values: type.toggleOptions,
                        initialPosition: !state.customizeInfo.correctErrors,
                        textColor: Colors.white,
                        backgroundColor: Color(0xFFF8F8F7),
                        buttonColor: Color(0xFF282948),
                        shadows: [],
                        onToggleCallback: (index) {
                          context.read<CustomizeCubit>().changeParams(
                                CustomizeModel(
                                  correctErrors:
                                      !state.customizeInfo.correctErrors,
                                  showTranslations:
                                      state.customizeInfo.showTranslations,
                                ),
                              );
                        },
                      );
                    } else {
                      return Container();
                    }
                  } else {
                    if (state is LoadedState) {
                      return AnimatedToggle(
                        values: type.toggleOptions,
                        initialPosition: !state.customizeInfo.showTranslations,
                        textColor: Colors.white,
                        backgroundColor: Color(0xFFF8F8F7),
                        buttonColor: Color(0xFF282948),
                        shadows: [],
                        onToggleCallback: (index) {
                          context.read<CustomizeCubit>().changeParams(
                                CustomizeModel(
                                  correctErrors:
                                      state.customizeInfo.correctErrors,
                                  showTranslations:
                                      !state.customizeInfo.showTranslations,
                                ),
                              );
                        },
                      );
                    } else {
                      return Container();
                    }
                  }
                },
              ),
              SizedBox(height: 24),
              SummaryButton(
                  width: MediaQuery.of(context).size.width * 0.5,
                  onPressed: () {
                    setState(() {
                      isSummaryVisible = !isSummaryVisible;
                    });

                    Future.delayed(Duration(milliseconds: 10), () {
                      setState(() {
                        if (type == CustomizeCardType.TRANSLATIONS) {
                          _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent,
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease);
                        }
                      });
                    });
                  }
                  //Scrollable.ensureVisible(dataKey.currentContext ?? context);
                  ),
              Offstage(
                offstage: !isSummaryVisible,
                child: Padding(
                  padding: EdgeInsets.only(top: 16.0),
                  child: Text(
                    type.summary[isFirstOption ? 0 : 1],
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

class SummaryButton extends StatefulWidget {
  final double width;
  final Function onPressed;

  SummaryButton({required this.width, required this.onPressed});

  @override
  _SummaryButtonState createState() => _SummaryButtonState(width, onPressed);
}

class _SummaryButtonState extends State<SummaryButton> {
  final double width;
  final Function onPressed;
  bool isPressed = false;

  _SummaryButtonState(this.width, this.onPressed);

  final ButtonStyle style = ElevatedButton.styleFrom(
      padding: EdgeInsets.zero,
      primary: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)));

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
        setState(() {
          isPressed = !isPressed;
        });
      },
      style: style,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF282948).withOpacity(0.04),
              offset: Offset(0, 24),
              blurRadius: 32,
            ),
            BoxShadow(
              color: Color(0xFF282948).withOpacity(0.06),
              offset: Offset(0, 16),
              blurRadius: 24,
            ),
            BoxShadow(
              color: Color(0xFF282948).withOpacity(0.04),
              offset: Offset(0, 4),
              blurRadius: 8,
            ),
            BoxShadow(
              color: Color(0xFF282948).withOpacity(0.04),
              offset: Offset(0, 0),
              blurRadius: 1,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                    child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isPressed ? "Ok" : "What's this?",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF282948)),
                    )
                  ],
                )),
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      height: 24, width: 24, child: Icon(Icons.light_mode))),
            ],
          ),
        ),
      ),
    );
  }
}
