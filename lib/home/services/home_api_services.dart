import 'package:dartz/dartz.dart';
import 'package:people_manager/models/user.dart';
import 'package:people_manager/utils/api_client.dart';
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
        return const Right('Error');
      }
    } catch (e) {
      return const Right('Error');
    }
  }
}
