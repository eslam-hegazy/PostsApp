import 'package:art2/features/posts/data/data_source/post_local_date_source.dart';
import 'package:art2/features/posts/data/data_source/post_remote_date_sourece.dart';
import 'package:art2/features/posts/domain/usecases/delete_post.dart';
import 'package:art2/features/posts/domain/usecases/insert_post.dart';
import 'package:art2/features/posts/domain/usecases/update_post.dart';
import 'package:art2/features/posts/presentation/bloc/add_delete_update_post.dart/bloc/add_delete_update_bloc.dart';
import 'package:art2/features/posts/presentation/pages/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'package:art2/features/posts/data/reposatory/post_reposatory_impl.dart';
import 'package:art2/features/posts/domain/usecases/get_all_posts.dart';
import 'package:art2/features/posts/presentation/bloc/posts/posts_bloc.dart';

import 'core/network/network_info.dart';
import 'features/posts/presentation/pages/home_scree.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  runApp(MyApp(
    sharedPreferences: sharedPreferences,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.sharedPreferences,
  }) : super(key: key);
  final SharedPreferences sharedPreferences;
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PostsBloc(
              GetAllPostsUseCase(
                postRepository: PostRepositoryImpl(
                  basePostRemoteDataSource:
                      PostRemoteDateSource(client: Client()),
                  basePostLocalDateSource:
                      PostLocalDateSource(sharedPreferences: sharedPreferences),
                  baseNetWorkInfo: NetWorkInfo(
                      internetConnectionChecker: InternetConnectionChecker()),
                ),
              ),
            )..add(GetAllPostsEvent()),
          ),
          BlocProvider(
            create: (context) => AddDeleteUpdateBloc(
              insertPostUseCase: InsertPostUseCase(
                postRepository: PostRepositoryImpl(
                  basePostRemoteDataSource:
                      PostRemoteDateSource(client: Client()),
                  basePostLocalDateSource:
                      PostLocalDateSource(sharedPreferences: sharedPreferences),
                  baseNetWorkInfo: NetWorkInfo(
                      internetConnectionChecker: InternetConnectionChecker()),
                ),
              ),
              deletePostUseCase: DeletePostUseCase(
                postRepository: PostRepositoryImpl(
                  basePostRemoteDataSource:
                      PostRemoteDateSource(client: Client()),
                  basePostLocalDateSource:
                      PostLocalDateSource(sharedPreferences: sharedPreferences),
                  baseNetWorkInfo: NetWorkInfo(
                      internetConnectionChecker: InternetConnectionChecker()),
                ),
              ),
              upDatePostUseCase: UpDatePostUseCase(
                postRepository: PostRepositoryImpl(
                  basePostRemoteDataSource:
                      PostRemoteDateSource(client: Client()),
                  basePostLocalDateSource:
                      PostLocalDateSource(sharedPreferences: sharedPreferences),
                  baseNetWorkInfo: NetWorkInfo(
                      internetConnectionChecker: InternetConnectionChecker()),
                ),
              ),
            ),
          )
        ],
        child: const MaterialApp(
          title: "Posts App",
          debugShowCheckedModeBanner: false,
          home: SplashScreen(),
        ),
      );
    });
  }
}
