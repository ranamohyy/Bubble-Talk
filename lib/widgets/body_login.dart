part of 'package:buble_talk/auth/login/log_in_view/view.dart';

class BodyLogin extends StatelessWidget {
 const BodyLogin({super.key});


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text(
            "Welcome !",
            style: kTextStyle24white,
            textAlign: TextAlign.center,
          ),
          Text(
            "Sign in to continue",
            style: kTextStyle20white.copyWith(fontWeight: FontWeight.w100),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.026,
          ),

        ],
      ),
    );
  }
}
