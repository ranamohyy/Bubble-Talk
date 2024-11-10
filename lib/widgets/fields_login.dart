part of 'package:buble_talk/auth/login/log_in_view/view.dart';
class FieldsLogin extends StatefulWidget {
   FieldsLogin({super.key,required this.passwordController,required this.emailController});
  TextEditingController emailController,passwordController;

  @override
  State<FieldsLogin> createState() => _FieldsLoginState();
}

class _FieldsLoginState extends State<FieldsLogin> {
  @override
  Widget build(BuildContext context) {
    return  AutofillGroup(
      child: Column(
        children: [
          MyInput(
            autofillHints: const [AutofillHints.email],
            controller:widget.emailController,
            validator: (value) {
              return Utils.validateEmail(value!);
            },
            text: 'Enter Your Email',
          ),
          const SizedBox(
            height: 8,
          ),
          MyInput(
            autofillHints: const [AutofillHints.password],

            obscureText: true,
            validator: (value) {
              return Utils.validatePassword(value!);
            },
            controller:widget.passwordController,
            text: 'Enter Password',
          ),
        ],
      ),
    );
  }
}
