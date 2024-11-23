import 'package:buble_talk/contacs_view/view.dart';
import 'package:buble_talk/manager/home_chats_bloc/chats_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../utils/constans.dart';
import '../../widgets/custom_shape_chats.dart';
import '../chat_page/view.dart';

class MyChatsView extends StatefulWidget {
  const MyChatsView({super.key});

  static String id = 'MyChatsView';
  @override
  State<MyChatsView> createState() => _MyChatsViewState();
}

class _MyChatsViewState extends State<MyChatsView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatsBloc()..add(ChatsEvent()),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Text('My Chats',
                  style: kTextStyle24white.copyWith(color: Colors.black)),
            ),
            Expanded(
              child: BlocBuilder<ChatsBloc, ChatsStates>(
                  builder: (context, state) {
                if (state is ChatsLoading) {
                  return const CircularProgressIndicator();
                }
                if (state is ChatsSuccess) {
                  return ListView.builder(
                    itemCount: state.list.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ChatPageView(
                                  user:state.list[index],
                                )));
                      },
                      child: CustomShapeChats(
                        text: state.list[index].email,
                        child: Text(
                          state.list[index].email[0].toUpperCase(),
                          style: kTextStyle24white,
                        ),
                      ),
                    ),
                  );
                }
                return const SizedBox();
              }),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: FloatingActionButton(

                backgroundColor: Colors.red,
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ContactsView()));
                    // addUser();
                  },
                  child: const Icon(
                    Icons.add,size: 27,color: Colors.white,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
