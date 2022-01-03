import 'package:email_validator/email_validator.dart';
import 'package:firebase/layout/social_layout.dart';
import 'package:firebase/shared/components/components.dart';
import 'package:firebase/shared/components/constant.dart';
import 'package:firebase/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';
import 'cubit/state.dart';

class SocialRegisterScreen extends StatefulWidget {

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<SocialRegisterScreen> {
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit,SocialRegisterState>(
        listener: (context,state){
          if(state is SocialCreateSuccessState){
            CacheHelper.saveData(
                key: 'uId',
                value: state.uId
            ).then((value){
              uId = state.uId;
              navigateToAndFinish(context,SocialLayout());
            });
          }
          if(state is SocialRegisterErrorState)
            showToast(text: state.error, state: ToastState.ERROR);
          if(state is SocialCreateErrorState){
            showToast(
                text: state.error,
                state: ToastState.ERROR
            );
          }
          if(state is SocialRegisterErrorState){
            showToast(
                text: state.error,
                state: ToastState.ERROR
            );
          }
        },
        builder: (context,state){
          var cubit = SocialRegisterCubit.get(context);
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
                            'REGISTER',
                            style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black,
                            )
                        ),
                        Text(
                          'Register now to communicate with friends',
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
                        ),
                        SizedBox(height: 10,),
                        defaultTextFormField(
                            controller: nameController,
                            label: 'Full Name',
                            prefixIcon:Icon(Icons.person_outline),
                            type: TextInputType.name,
                            validate: (value){
                              if(value!.isEmpty)
                                return 'required';
                              return null;
                            }
                        ),
                        SizedBox(height: 10,),
                        defaultTextFormField(
                            controller: phoneController,
                            label: 'Phone Number',
                            prefixIcon:Icon(Icons.phone_outlined),
                            type: TextInputType.number,
                            validate: (value){
                              if(value!.isEmpty)
                                return 'required';
                              return null;
                            }
                        ),
                        SizedBox(height: 10,),
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
                        state is SocialRegisterLoadingState?
                        Center(child: CircularProgressIndicator()) :
                        defaultButton(
                          text: 'register',
                          pressed: (){
                            if(formKey.currentState!.validate())
                              cubit.userRegister(
                                  email: emailController.text,
                                  name: nameController.text,
                                  phone: phoneController.text,
                                  password: passwordController.text);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );;
        },
      ),
    );
  }
}
