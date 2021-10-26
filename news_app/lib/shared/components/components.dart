import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/web_view_screen.dart';




Widget buildArticleItem(article , context)=>InkWell(
  onTap: (){
    navigateTo(context, WebViewScreen(article['url']),);
  },
  child:   Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 120.0,
          height: 120.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
                image: article['urlToImage']==null?NetworkImage('https://www.salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled-1150x647.png'):
                NetworkImage('${article['urlToImage']}'),
                fit: BoxFit.cover
            ),
            //  NetworkImage('${article['urlToImage']}')
          ),
        ),
        SizedBox(width: 20.0,),
        Expanded(
          child: Container(
            height: 120.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${article['title']}',
                    style:Theme.of(context).textTheme.bodyText1,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${article['publishedAt']}',
                  style: TextStyle(
                      color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);

Widget articleBuilder(list , context ,{isSearch = false} )=> ConditionalBuilder(
  condition: list.length>0,
  builder: (context)=>ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context , index)=>buildArticleItem(list[index] , context),
    separatorBuilder: (context , index)=>Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20 ,
        end: 20,
      ),
      child: Container(height: 0.5, color: Colors.grey[200],),
    ),
    itemCount: 16,
  ),
  fallback: (context)=>isSearch ? Container() :  Center(child: CircularProgressIndicator()),
);


Widget defaultFormField ({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange ,
  Function onTap,
  bool isPassword = false,
  @required Function vaildate ,
  @required String lable,
  @required IconData prefix,
  IconData suffix ,
  Function suffixPressd,
}) => TextFormField(
  style: TextStyle(
    color: Colors.deepOrange,
  ),
  controller:  controller,
  keyboardType: type,
  obscureText: isPassword,
  onFieldSubmitted:onSubmit,
  onChanged: onChange,
  onTap: onTap,
  validator: vaildate,
  decoration:InputDecoration
    (
    labelText: lable,
    prefixIcon:Icon(prefix),
    suffixIcon: suffix != null ? IconButton(
      onPressed: suffixPressd,
      icon:
      Icon(
        Icons.remove_red_eye,
      ),
    ) : null,
    border:OutlineInputBorder(),
  ),
);





























void navigateTo (context , widget)=>Navigator.push(
  context,
  MaterialPageRoute(
    builder:(context) => widget,
  ),
);
