import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_repo_search/core/utils/constants/app_strings.dart';
import 'package:github_repo_search/features/detail/presentation/detail_page.dart';
import 'package:github_repo_search/features/repoList/data/repo_data_model.dart';
import 'package:github_repo_search/features/repoList/presentation/bloc/repo_list_bloc.dart';
import 'package:github_repo_search/features/repoList/presentation/bloc/repo_list_event.dart';
import 'package:github_repo_search/features/repoList/presentation/bloc/repo_list_state.dart';
import '../repoList/presentation/pages/github_item.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RepoListBloc>().add(RepoListRefreshRequested());
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepoListBloc, RepoListState>(
        builder: (context, state) { 
          if (state is RepoListLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is RepoListLoadedState) {
          return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.appBarTitleHome),
        actions: [
           DropdownButton<RepoDataModel>(
            value: state.selectedLanguage,
            items: state.uniqueRepositories.map((RepoDataModel language) {
              return DropdownMenuItem<RepoDataModel>(
                value: language,
                child: Text(language.language),
              );
            }).toList(),
            onChanged: (RepoDataModel? newValue) {
              BlocProvider.of<RepoListBloc>(context)
                  .add(SelectLanguage(newValue!));
            },
          ),
        ],
      ),
      body: RefreshIndicator(
              onRefresh: () async {
                context.read<RepoListBloc>().add(RepoListRefreshRequested());
              },
              child: ListView.builder(
                itemCount: state.repos.length,
                itemBuilder: (BuildContext context, int index) {
                  final repo = state.repos[index];
                  return GithubItem(
                    repo: repo,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DetailsPage(repo: repo),
                      ),
                    ),
                  );
                },
              ),
            )
        
      
    );
    }
       else if (state is RepoListErrorState) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text(AppStrings.pullToRefresh));
    
        });
  }
}
