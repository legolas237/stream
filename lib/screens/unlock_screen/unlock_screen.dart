import 'package:basic_utils/basic_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:stream/blocs/auth/auth_bloc.dart';
import 'package:stream/config/config.dart';
import 'package:stream/models/remote/user.dart';
import 'package:stream/screens/tabs_screen/tabs_screen.dart';
import 'package:stream/screens/unlock_screen/bloc/unlock_account_bloc.dart';
import 'package:stream/theme/palette.dart';
import 'package:stream/theme/theme_provider.dart';
import 'package:stream/widgets/app_scaffold/app_scaffold.dart';
import 'package:stream/widgets/border_wrapper/border_wrapper.dart';
import 'package:stream/widgets/button/button.dart';
import 'package:stream/widgets/circular_sized_avatar/circular_sized_avatar.dart';
import 'package:stream/widgets/divider/divider.dart';
import 'package:stream/widgets/password_input/password_input.dart';
import 'package:stream/widgets/spinner/spinner.dart';
import 'package:stream/widgets/text_error/text_error.dart';

// ignore: must_be_immutable
class UnlockScreen extends StatefulWidget {
  static const routeName = '/unlock';

  UnlockScreen({Key? key}) : super(key: key);

  late Palette palette;

  late User user;

  @override
  State<StatefulWidget> createState() => _UnlockScreenState();
}

class _UnlockScreenState extends State<UnlockScreen> {
  String password = '';

  @override
  Widget build(BuildContext context) {
    // Get theme palette
    widget.palette = ThemeProvider.of(context)!.appTheme.palette;

    widget.user = BlocProvider.of<AuthBloc>(context).state.user!;

    return ScaffoldWidget(
      resizeToAvoidBottomInset: false,
      appBarBackgroundColor: widget.palette.scaffoldColor(1.0),
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: AppLocalizations.of(context)!.unlock,
      actions: [
        Row(
          children: [
            CircularSizedAvatarWidget(
                backgroundColor: widget.palette.secondaryBrandColor(0.1),
                size: 30.0,
                backgroundImage: NetworkImage(widget.user.profilePicture ?? '')
            ),
            const SizedBox(width: 16.0),
          ],
        ),
      ],
      body: BorderlessWrapperWidget(
        top: true,
        bottom: false,
        child: Column(
          children: [
            BlocConsumer<UnlockAccountBloc, UnlockAccountState>(
              listener: (context, state) {
                if(state.status == UnlockStatus.unlocked) {
                  Navigator.pushNamedAndRemoveUntil(context, TabsScreen.routeName, (route) => false,);
                }
              },
              builder: (context, state) {
                return  Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      vertical: Constants.verticalPadding,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            left: Constants.horizontalPadding,
                            right: MediaQuery.of(context).size.width * 0.1,
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.helloUser(
                              widget.user.smallName(),
                            ),
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.subtitle1!.merge(
                              const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Padding(
                          padding: EdgeInsets.only(
                            left: Constants.horizontalPadding,
                            right: MediaQuery.of(context).size.width * 0.1,
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.confirmIdentity,
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.caption!.merge(
                              const TextStyle(
                                fontSize: 13.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        PasswordInputWidget(
                          readOnly: state.status == UnlockStatus.processing,
                          hintText: AppLocalizations.of(context)!.yourPassword,
                          verifyStrong: false,
                          onChanged: (value) {
                            setState(() {
                              password = value.toString();
                            });
                          },
                          helperText: () {
                            if(state.status == UnlockStatus.error && state.messages is Map) {
                              var message = '';

                              if((state.messages as Map).keys.contains('password')){
                                message = (state.messages['password'] as List).first.toString();
                              }

                              if((state.messages as Map).keys.contains('telephone')){
                                message = (state.messages['telephone'] as List).first.toString();
                              }

                              return Padding(
                                  padding: const EdgeInsets.only(
                                    left: Constants.horizontalPadding,
                                    right: Constants.horizontalPadding,
                                    bottom: Constants.verticalPadding,
                                  ),
                                  child: TextErrorWidget(
                                    text: message,
                                  )
                              );
                            }

                            return const SizedBox();
                          },
                        ),
                        DividerWidget(),
                        _buildActions(state),
                      ],
                    ),
                  ),
                );
              },
            ),
            Container(
             padding: const EdgeInsets.symmetric(
               vertical: Constants.verticalPadding,
             ),
             child:  Column(
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 const SizedBox(height: 16.0),
                 Padding(
                   padding: EdgeInsets.symmetric(
                     horizontal: MediaQuery.of(context).size.width * 0.1,
                   ),
                   child: Text(
                     AppLocalizations.of(context)!.useAnotherAccount,
                     textAlign: TextAlign.center,
                     style: Theme.of(context).textTheme.caption!.merge(
                       const TextStyle(
                         fontSize: 12.0,
                         fontWeight: FontWeight.w400,
                       ),
                     ),
                   ),
                 ),
                 const SizedBox(height: 16.0),
                 Padding(
                   padding: EdgeInsets.symmetric(
                     horizontal: MediaQuery.of(context).size.width * 0.04,
                   ),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       SizedBox(
                         height: 34.0,
                         child: ButtonWidget(
                           onPressed: () {},
                           enabled: true,
                           child: ButtonWidget.buttonTextChild(
                             context: context,
                             enabled: true,
                             text: AppLocalizations.of(context)!.useAnotherAccountAction,
                             textStyle: Theme.of(context).textTheme.subtitle1!.merge(
                             TextStyle(
                               color: widget.palette.secondaryBrandColor(1),
                               fontSize: 13.0,
                               fontWeight: FontWeight.w600,
                             ),
                             ),
                           ),
                           style: ButtonStyleWrapper(
                             palette: widget.palette,
                             enabled: true,
                           ).build(context).copyWith(
                             backgroundColor: MaterialStateColor.resolveWith((states) {
                               return widget.palette.secondaryBrandColor(0.1);
                             },
                             ),
                             overlayColor: MaterialStateColor.resolveWith((states) {
                               return widget.palette.secondaryBrandColor(0.2);
                             }),
                           ),
                         ),
                       ),
                     ],
                   ),
                 ),
               ],
             ),
           ),
          ],
        ),
      ),
    );
  }

  // Render

  Widget _buildActions(UnlockAccountState state) {
    var canUnlock = StringUtils.isNotNullOrEmpty(password) && state.status != UnlockStatus.processing;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Constants.horizontalPadding,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildErrorWrapper(state),
          const SizedBox(height: 20.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ButtonWidget(
                onPressed: () {
                  if(canUnlock) {
                    BlocProvider.of<UnlockAccountBloc>(context).add(
                      UnlockAccount(
                        phoneNumber: widget.user.userDetail.telephone,
                        password: password
                      ),
                    );
                  }
                },
                enabled: canUnlock,
                child: ButtonWidget.buttonTextChild(
                  context: context,
                  enabled: canUnlock,
                  text: AppLocalizations.of(context)!.continueAction,
                ),
              ),
              const SizedBox(width: 28.0),
              if(state.status == UnlockStatus.processing) SizedBox(
                height: 18.0,
                width: 18.0,
                child: SpinnerWidget(
                  strokeWidth: 1.8,
                  colors: AlwaysStoppedAnimation<Color>(
                    widget.palette.secondaryBrandColor(1.0),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildErrorWrapper(UnlockAccountState state) {
    if(state.status == UnlockStatus.error && (state.messages== null || state.messages is String)) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          vertical: Constants.verticalPadding,
        ),
        child: TextErrorWidget(
          text: state.messages ?? AppLocalizations.of(context)!.somethingWrong,
        ),
      );
    }

    return const SizedBox();
  }
}