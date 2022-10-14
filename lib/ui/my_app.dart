import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../business/block_factory.dart';
import '../business/main_bloc.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final MainBloc _mainBloc;

  @override
  void initState() {
    super.initState();
    _mainBloc = BlocFactory.instance.get<MainBloc>();
    _mainBloc.add(MainBlocEvent.init());
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<MainBloc>(
      create: (_) => _mainBloc,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }

  @override
  void dispose() {
    _mainBloc.dispose();
    super.dispose();
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<MainBlocState>(
        stream: context.read<MainBloc>().state,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final state = snapshot.data;
            return state!.map<Widget>(
                loading: (_) => Scaffold(
                      appBar: AppBar(
                        title: Text('Demo'),
                      ),
                      body: Center(child: Text('Initinalizing')),
                    ),
                loaded: (state) => Scaffold(
                      appBar: AppBar(
                        title: Text('Demo'),
                      ),
                      body: Center(
                        child: Text(
                          state.userData.name,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      floatingActionButton: FloatingActionButton(
                        onPressed: () => context.read<MainBloc>().add(MainBlocEvent.setUser(userId: state.userData.id + 1)),
                        tooltip: 'Increment',
                        child: Icon(Icons.add),
                      ),
                    ));
          } else {
            return CircularProgressIndicator();
          }
        });
  }
}
