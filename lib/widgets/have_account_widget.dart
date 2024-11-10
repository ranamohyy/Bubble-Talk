part of 'package:buble_talk/auth/register/register_view/view.dart';
class CustomHaveAccountWidget extends StatelessWidget {
  const CustomHaveAccountWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account?',
          style: kTextStyle14White,
        ),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(
            ' Login ',
            style: kTextStyle14White.copyWith(
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
