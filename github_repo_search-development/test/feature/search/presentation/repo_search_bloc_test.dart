import 'package:flutter_test/flutter_test.dart';
import 'package:github_repo_search/features/repoList/presentation/bloc/repo_list_bloc.dart';
import 'package:github_repo_search/features/repoList/presentation/bloc/repo_list_state.dart';
import '../domain/data_repository_mock.dart.mocks.dart';

void main() {
  group('RepoListBloc Tests', () {
    late RepoListBloc bloc;
    late MockDataRepository mockDataRepository;

    setUp(() {
      mockDataRepository = MockDataRepository();
      bloc = RepoListBloc(mockDataRepository);
    });

    test('initial state is correct', () {
      expect(bloc.state, equals(RepoListInitialState()));
    });

    tearDown(() {
      bloc.close();
    });
  });
}
