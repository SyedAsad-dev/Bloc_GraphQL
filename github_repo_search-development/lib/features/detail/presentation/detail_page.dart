import 'package:flutter/material.dart';
import 'package:github_repo_search/features/repoList/data/repo_data_model.dart';

class DetailsPage extends StatelessWidget {
  final RepoDataModel repo;

  const DetailsPage({required this.repo, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(repo.name),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(repo.name, style: Theme.of(context).textTheme.titleLarge),
                    Text('Owner: ${repo.owner}', style: Theme.of(context).textTheme.titleMedium),
                    Text('Language: ${repo.language}', style: Theme.of(context).textTheme.titleMedium),
                    SizedBox(height: 8),
                    Text('Description: ${repo.description}', style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
