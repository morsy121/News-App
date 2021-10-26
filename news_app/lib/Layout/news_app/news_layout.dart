import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/Layout/cubit/cubit.dart';
import 'package:news_app/Layout/cubit/states.dart';
import 'package:news_app/modules/search/search_screen.dart';
import 'package:news_app/shared/components/components.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';


class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsStates>(
      listener: (context , state){},
      builder: (context , state)
      {
        var cubit = NewsCubit.get(context);

        return Scaffold(
          appBar: AppBar(
            title: Text('News App'),
            actions: [
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: ()
                  {
                    navigateTo(context, SearchScreen(),);
                  }),
              IconButton(
                  icon: Icon(Icons.brightness_4_outlined),
                  onPressed: ()
                  {
                      AppCubit.get(context).changeAppMode();
                  }),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNavBar(index);
            },
            items:cubit.bottomItems,
          ),
        );
      },
    );
  }
}


class AppCubit extends Cubit<AppStates>{

  AppCubit() : super( AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  bool isDark = true;

  void changeAppMode ({bool fromShared})
  {
    if(fromShared!= null)
      {
        isDark = fromShared;
        emit(AppChangeModeState());
      }
    else
      {
        isDark = !isDark ;
        CacheHelper.putBoolean(key: 'isDark' , value:isDark).then((value){
          emit(AppChangeModeState());
        });
      }

  }

}
