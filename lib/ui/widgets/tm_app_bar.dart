

import 'package:flutter/material.dart';
import 'package:task_manager/ui/screens/update_profile_screen.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget{
  const TMAppBar({
    super.key, this.fromProfileScreen,

  });

final bool? fromProfileScreen;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return AppBar(
      backgroundColor: Colors.green,

      title: GestureDetector(
        onTap:(){
          if(fromProfileScreen ?? false){
            return;
          }
          _onTapProfileSection(context);
        },
        child: Row(
          children: [
            CircleAvatar(
              radius: 16,
            ),
            SizedBox(width: 8,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Shad Islam',style: textTheme.bodyLarge?.copyWith(
                    color: Colors.white,
                  ),),
                  Text('shadislam999@gmail.com',style: textTheme.bodySmall?.copyWith(color: Colors.white),),
        
                ],
        
              ),
            ),
            IconButton(onPressed: (){}, icon: Icon(Icons.logout),
            ),
        
          ],
        ),
      ),
    );

  }

  void _onTapProfileSection(BuildContext context){
    Navigator.push(context,MaterialPageRoute(builder: (context)=> UpdateProfileScreen()));
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}