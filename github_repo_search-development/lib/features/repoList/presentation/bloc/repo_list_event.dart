import 'package:github_repo_search/features/repoList/data/repo_data_model.dart';

abstract class RepoListEvent {}

class RepoListRefreshRequested extends RepoListEvent {}

class ClearRepoList extends RepoListEvent {}

class SelectLanguage extends RepoListEvent {
  final RepoDataModel language;

   SelectLanguage(this.language);

  List<RepoDataModel?> get props => [language];
}