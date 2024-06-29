import 'package:github_repo_search/features/repoList/data/github_api_service.dart';
import 'package:github_repo_search/features/repoList/data/repo_data_model.dart';

class DataRepository {
  Future<List<RepoDataModel>> getTrendingRepositories() => GithubApiService.getTrendingRepositories();
}
