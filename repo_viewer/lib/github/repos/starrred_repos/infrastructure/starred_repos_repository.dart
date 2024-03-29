import 'package:dartz/dartz.dart';
import 'package:repo_viewer/core/domain/fresh.dart';
import 'package:repo_viewer/core/infrastructure/network_exceptions.dart';
import 'package:repo_viewer/github/core/domain/github_failure.dart';
import 'package:repo_viewer/github/core/domain/github_repo.dart';
import 'package:repo_viewer/github/core/infrastructure/github_repo_dto.dart';
import 'package:repo_viewer/github/repos/starrred_repos/infrastructure/starred_repos_local_service.dart';
import 'package:repo_viewer/github/repos/starrred_repos/infrastructure/starred_repos_remote_service.dart';

class StarredReposRepository {
  final StarredReposRemoteService _remoteService;
  final StarredReposLocalService _localService;

  StarredReposRepository(
    this._remoteService,
    this._localService,
  );

  Future<Either<GithubFailure, Fresh<List<GithubRepo>>>> getStarredReposPage(
      int page) async {
    try {
      final remotePageItems = await _remoteService.getStarredReposPage(page);
      return right(
        await remotePageItems.when(
          noConnection: (maxPage) async => Fresh.no(
            await _localService.getPage(page).then((_) async => _.toDomain()),
            isNextPageAvailable: page < maxPage,
          ),
          notModified: (maxPage) async => Fresh.no(
            await _localService.getPage(page).then((_) async => _.toDomain()),
            isNextPageAvailable: page < maxPage,
          ),
          withNewData: (data, maxPage) async {
            await _localService.upsertPage(data, page);
            return Fresh.yes(
              (data as List<GithubRepoDTO>).toDomain(),
              isNextPageAvailable: page < maxPage,
            );
          },
        ),
      );
    } on RestApiException catch (e) {
      return left(
        GithubFailure.api(e.errorCode),
      );
    }
  }
}

extension DTOListToDomainList on List<GithubRepoDTO> {
  List<GithubRepo> toDomain() {
    return map((e) => e.toDomain()).toList();
  }
}
