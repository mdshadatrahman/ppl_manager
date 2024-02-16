import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:people_manager/models/user.dart';
import 'package:people_manager/utils/api_client.dart';
import 'package:people_manager/utils/app_strings.dart';
import 'package:people_manager/utils/url.dart';

class HomeApiServices {
  static Future<Either<List<User>, String>> getUsers() async {
    try {
      final response = await ApiClient.instance.get(url: URL.user);

      if (response.statusCode == 200 && response.data != null) {
        final users = <User>[];
        if (response.data != null) {
          final data = response.data as List<dynamic>;
          for (var i = 0; i < data.length; i++) {
            users.add(User.fromJson(data[i] as Map<String, dynamic>));
          }
        }
        return Left(users);
      } else {
        return const Right(AppStrings.error);
      }
    } catch (e) {
      return const Right(AppStrings.error);
    }
  }

  static Future<Either<User, String>> createUsers(User user) async {
    try {
      final response = await ApiClient.instance.post(
        url: URL.user,
        body: user.toJson(),
      );

      if (response.statusCode == 201 && response.data != null) {
        return Left(User.fromJson(response.data!));
      } else {
        return const Right(AppStrings.error);
      }
    } on DioException catch (e) {
      return Right(e.message ?? AppStrings.error);
    } catch (e) {
      return const Right(AppStrings.error);
    }
  }

  static Future<Either<User, String>> updateUsers(User user) async {
    try {
      final response = await ApiClient.instance.put(
        url: '${URL.user}/${user.id}',
        body: user.toJson(),
      );

      if (response.statusCode == 200 && response.data != null) {
        return Left(User.fromJson(response.data!));
      } else {
        return const Right(AppStrings.error);
      }
    } on DioException catch (e) {
      return Right(e.message ?? AppStrings.error);
    } catch (e) {
      return const Right(AppStrings.error);
    }
  }
}
