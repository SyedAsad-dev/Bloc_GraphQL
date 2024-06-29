import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:github_repo_search/features/repoList/data/graphql_client.dart';
import 'package:github_repo_search/features/repoList/data/graphql_queries.dart';
import 'package:github_repo_search/features/repoList/data/repo_data_model.dart';
import 'dart:async';
import 'package:graphql_flutter/graphql_flutter.dart';

class GithubApiService {
  static Future<List<RepoDataModel>> getTrendingRepositories() async {
    final apiKey = dotenv.env['githubToken'];
    final client = getGraphQLClient(apiKey);
      final options = QueryOptions(
        document: gql(getTrendingRepository),
      );
      final result = await client.query(options);

      if (result.hasException) {
         return [];
      }
        final repositories = result.data?['search']['edges']
            .map((edge) => edge['node'])
            .toList();
    return RepoDataModel.mapJSONStringToList(repositories);
  }

}
