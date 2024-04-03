import 'package:flutter/material.dart';
import 'package:khata_sathi/utils/routes.dart';

class DashBoardPage extends StatelessWidget {
  const DashBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(padding: EdgeInsets.all(16),child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  child: Container(
                    height: 150,
                    width: 180,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("INCOME",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500),),
                        SizedBox(height: 20,),
                        Text("150000",style: TextStyle(fontSize: 18),)
                      ],
                    ),
                  ),
                ),
                Card(
                  child: Container(
                    height: 150,
                    width: 180,
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("EXPANSE",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w500),),
                        SizedBox(height: 20,),
                        Text("15000",style: TextStyle(fontSize: 18),)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),),
      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        Navigator.of(context).pushNamed(MyRoutes.add);
      },label: const Text("Add"),icon: const Icon(Icons.note)),
    );
  }
}
