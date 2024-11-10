part of 'package:buble_talk/auth/login/log_in_view/view.dart';


class NotHaveAccountWidget extends StatelessWidget {
  const NotHaveAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
      const SizedBox(
      height: 40,),
        const Text(
          'Don\'t have an account?',
          style: kTextStyle14White,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RegisterView.id);
          },
          child: Text(
            ' Create New Account',
            style: kTextStyle14White.copyWith(
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
