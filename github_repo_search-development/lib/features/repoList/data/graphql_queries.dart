const String getTrendingRepository = r'''
query GetTrendingRepositories() {
  search(query: "stars:>100", type: REPOSITORY, first: 20) {
    edges {
      node {
        ... on Repository {
          name
          description
          htmlUrl: url
          watchers {
            totalCount
          }
          language: primaryLanguage {
            name
          }
          owner {
            login
          }
        }
      }
    }
  }
}
''';
