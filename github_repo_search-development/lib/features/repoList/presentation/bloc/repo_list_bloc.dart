import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_repo_search/features/repoList/data/repo_data_model.dart';
import 'package:github_repo_search/features/repoList/domain/repository/data_repository.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'repo_list_event.dart';
import 'repo_list_state.dart';

class RepoListBloc extends Bloc<RepoListEvent, RepoListState>  {
  final DataRepository _dataRepository;
      List<RepoDataModel> uniqueRepositories = [];

    List<RepoDataModel> getUniqueRepositories(List<RepoDataModel> repositories) {
    return repositories.toSet().toList();
  }

  void getUniqueLanguageListForFilter(repos) {
    uniqueRepositories = [];
    uniqueRepositories.add(
      RepoDataModel(htmlUrl: '',
      watchersCount: 0,
      language: 'All',
      description: 'No description',
      name: 'Unnamed',
      owner: 'Unknown owner',
    ));
    uniqueRepositories.addAll(getUniqueRepositories(repos));
  }
    
  RepoListBloc(this._dataRepository) : super(RepoListInitialState()) {

    on<SelectLanguage>((event, emit) async {
      try {
        final currentState = state as RepoListLoadedState ;

         final filteredRepositories = event.language.language == "All"
          ? currentState.orignalRepo
          : currentState.orignalRepo.where((repo) =>
                  repo.language == event.language.language)
              .toList();
      emit(RepoListLoadedState(currentState.orignalRepo, filteredRepositories, event.language, currentState.uniqueRepositories));
      } catch (e) {
        emit(RepoListErrorState(e.toString()));
      }
    });

    on<RepoListRefreshRequested>((event, emit) async {
      try {
        final repos = await _dataRepository.getTrendingRepositories();
         getUniqueLanguageListForFilter(repos);
        emit(RepoListLoadedState(repos, repos, uniqueRepositories.first, uniqueRepositories));
      } catch (e) {
        emit(RepoListErrorState(e.toString()));
      }
    });

    on<ClearRepoList>((event, emit) {
      emit(RepoListInitialState());
    });
  }
  
}
