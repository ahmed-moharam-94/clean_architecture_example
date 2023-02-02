import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_app/features/posts/presentation/blocs/add_delete_update_bloc/add_delete_update_bloc.dart';
import 'package:flutter_clean_architecture_app/features/posts/presentation/blocs/get_refresh_bloc/posts_bloc.dart';
import 'application//app_theme.dart';
import 'application//di.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/posts/presentation/screens/post_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.instance<PostsBloc>()),
        BlocProvider(create: (_) => di.instance<AddDeleteUpdatePostBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Clean Architecture',
        theme: themeData,
        home: const PostsScreen(),
      ),
    );
  }
}


