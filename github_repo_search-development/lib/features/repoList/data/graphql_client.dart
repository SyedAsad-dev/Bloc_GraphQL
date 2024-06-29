import 'package:graphql_flutter/graphql_flutter.dart';

GraphQLClient getGraphQLClient(String? githubToken) {
  final HttpLink httpLink = HttpLink(
    'https://api.github.com/graphql',
    defaultHeaders: {
      'Authorization': 'Bearer $githubToken',
    },
  );

  return GraphQLClient(
    cache: GraphQLCache(),
    link: httpLink,
  );
}
