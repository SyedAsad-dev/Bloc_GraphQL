import 'package:equatable/equatable.dart';
import 'package:github_repo_search/features/repoList/data/repo_data_model.dart';

abstract class RepoListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RepoListInitialState extends RepoListState {}

class RepoListLoadingState extends RepoListState {}

class RepoListLoadedState extends RepoListState {
  final List<RepoDataModel> repos;
  final RepoDataModel? selectedLanguage;
  final List<RepoDataModel> uniqueRepositories;
   final List<RepoDataModel> orignalRepo;

  RepoListLoadedState(this.orignalRepo, this.repos, this.selectedLanguage, this.uniqueRepositories);

  @override
  List<Object?> get props => [orignalRepo, repos,  {selectedLanguage}, uniqueRepositories,];
}

class RepoListErrorState extends RepoListState {
  final String message;

  RepoListErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
