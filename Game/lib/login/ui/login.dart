import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:game/login/bloc/login_bloc.dart';
import 'package:game/utils/router.dart';
import 'package:game/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:game/widgets/appbar_widget.dart';
import 'package:game/widgets/circularimage_widget.dart';

class LogInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(),
      child: Scaffold(
        appBar: AppBarWidget(),
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              Navigator.pushNamed(context, Routing.homeRoute,
                  arguments: state.user);
            }
          },
          builder: (context, state) {
            return BlocBuilder<LoginBloc, LoginState>(
              builder: (context, state) {
                if (state is LoginSuccess) {
                  //  TODO : imeplement success todo...
                  
                } else if (state is LoginFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('${state.loginError}'),
                    duration: Duration(seconds: 1),
                  ));
                }

                return Container(
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        child: CircularImageWidget(
                            size: Utils.getDeviceSize(context).height * 0.7),
                      ),
                      Builder(
                        builder: (context) {
                          return SignInButton(
                            Buttons.Google,
                            onPressed: () => BlocProvider.of<LoginBloc>(context)
                                .add(LoginClickedEvent()),
                            elevation: 8,
                          );
                        },
                      )
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
