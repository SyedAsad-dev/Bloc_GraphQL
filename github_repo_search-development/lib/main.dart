import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'core/utils/theme/app_theme.dart';
import 'features/repoList/domain/repository/data_repository.dart';
import 'features/home/home_page.dart';
import 'features/repoList/presentation/bloc/repo_list_bloc.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(
    BlocProvider<RepoListBloc>(
      create: (context) => RepoListBloc(DataRepository()),
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GitHub ',
      theme: AppTheme.darkTheme,
      home: BlocProvider(
        create: (context) => RepoListBloc(DataRepository()),
        child: Home(),
      ),
    );
  }
}
