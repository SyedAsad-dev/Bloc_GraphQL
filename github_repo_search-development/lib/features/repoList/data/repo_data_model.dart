class RepoDataModel {
  final String htmlUrl;
  final int watchersCount;
  final String language;
  final String description;
  final String name;
  final String owner;

  RepoDataModel({
    required this.htmlUrl,
    required this.watchersCount,
    required this.language,
    required this.description,
    required this.name,
    required this.owner,
  });

  static List<RepoDataModel> mapJSONStringToList(List<dynamic> jsonList) {
    return jsonList.map((r) => RepoDataModel(
      htmlUrl: r['html_url'] as String? ?? '',
      watchersCount: r['watchers'] != null ? r['watchers']['totalCount'] as int? ?? 0 : 0,
      language: r['language'] != null ? r['language']['name'] as String? ?? 'Unknown' : 'Unknown',
      description: r['description'] as String? ?? 'No description',
      name: r['name'] as String? ?? 'Unnamed',
      owner: r['owner'] != null ?  r['owner']['login'] as String? ?? 'Unknown owner' : 'Unknown owner',
    )).toList();
  }

    @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RepoDataModel && runtimeType == other.runtimeType && language == other.language;

  @override
  int get hashCode => language.hashCode;

}
