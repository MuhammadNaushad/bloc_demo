import 'package:bloc_demo/bloc_demo/blocs/app_blocs.dart';
import 'package:bloc_demo/bloc_demo/blocs/app_events.dart';
import 'package:bloc_demo/bloc_demo/blocs/app_states.dart';
import 'package:bloc_demo/bloc_demo/model/user_model.dart';
import 'package:bloc_demo/bloc_demo/repo/repositories.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (BuildContext context) => UserBloc(UserRepository()),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('The BloC App'),
          notificationPredicate: (notification) {
            return true;
          },
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: blocBody(),
      ),
    );
  }

  Widget blocBody() {
    return BlocProvider(
      create: (context) => UserBloc(
        UserRepository(),
      )..add(LoadUserEvent()),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UserLoadedState) {
            List<UserModel> userList = state.users;
            return ListView.builder(
                itemCount: userList.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    child: Column(
                      children: [
                        Card(
                            color: Theme.of(context).primaryColor,
                            child: ListTile(
                                title: Text(
                                  '${userList[index].firstName}  ${userList[index].lastName}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  '${userList[index].email}',
                                  style: const TextStyle(color: Colors.white),
                                ),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      userList[index].avatar.toString()),
                                ))),
                        const Divider(
                          height: 20,
                          thickness: 5,
                          indent: 50,
                          endIndent: 50,
                        ),
                        const ColoredBox(
                          color: Colors.amber,
                          child: Center(
                            child: Text('Above'),
                          ),
                        ),
                        LinearProgressIndicator(
                          value: controller.value,
                          color: Colors.red,
                          semanticsLabel: 'Linear progress indicator',
                        ),
                      ],
                    ),
                  );
                });
          } else if (state is UserErrorState) {
            return const Center(
              child: Text("Error"),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
