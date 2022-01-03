import 'package:firebase/layout/social_layout.dart';
import 'package:firebase/modual/socail_register/social_register.dart';
import 'package:firebase/shared/components/components.dart';
import 'package:firebase/shared/components/constant.dart';
import 'package:firebase/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
import 'package:email_validator/email_validator.dart';

class SocialUserLogin extends StatefulWidget {
  @override
  _SocialUserLoginState createState() => _SocialUserLoginState();
}

class _SocialUserLoginState extends State<SocialUserLogin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginState>(
        listener: (context,state){
          if(state is SocialLoginSuccessState){
              CacheHelper.saveData(
                  key: 'uId',
                  value: state.uId
              ).then((value){
                uId = state.uId;
                navigateToAndFinish(context,SocialLayout());
              });
          }
          if(state is SocialLoginErrorState)
            showToast(text: state.error, state: ToastState.ERROR);

        },
        builder: (context,state){
          var cubit = SocialLoginCubit.get(context);
          return  Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'LOGIN',
                            style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black,
                            )
                        ),
                        Text(
                          'login now to communicate with friends',
                          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 30,),
                        defaultTextFormField(
                            controller: emailController,
                            label: 'Email Address',
                            prefixIcon:Icon(Icons.email_outlined),
                            type: TextInputType.emailAddress,
                            validate: (value){
                              if(value!.isEmpty)
                                return 'required';
                              else if (!EmailValidator.validate(value))
                                return 'required a valid email';
                              return null;
                            }
                        ),SizedBox(height: 15,),
                        defaultTextFormField(
                            controller: passwordController,
                            label: 'Password',
                            prefixIcon:Icon(Icons.lock_outline_sharp),
                            suffixIcon: isPassword?Icons.visibility_outlined:Icons.visibility_off_outlined,
                            isPassword :isPassword,
                            onPasPres: (){
                              setState(() {
                                isPassword = !isPassword;
                              });
                            },
                            type: TextInputType.visiblePassword,
                            validate: (value){
                              if(value!.isEmpty)
                                return 'required';
                              return null;
                            }
                        ),
                        SizedBox(height: 30,),
                        state is SocialLoginLoadingState?
                        Center(child: CircularProgressIndicator()) :
                        defaultButton(
                          text: 'login',
                          pressed: (){
                            if(formKey.currentState!.validate())
                              cubit.userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                          },
                        ),

                        SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?'),
                            defaultTextButton(
                                text: 'register',
                                onPressed: (){
                                  navigate(context,SocialRegisterScreen());
                                }
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );

        },
      ),
    );
  }
}
