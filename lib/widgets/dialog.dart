import 'package:flutter/material.dart';

class Dialogs {
  static Future<void> showLoadingDialog(
      BuildContext context, {GlobalKey key, String title, String description, String icon, bool barrierDismissible}) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (BuildContext context) {
          return Scaffold(
            key: key,
            backgroundColor: Colors.transparent,
            body: InkWell(
              onTap: (){
                if(barrierDismissible){
                  Navigator.of(context).pop();
                }else{
                  return;
                }
              },
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20,),
                      Center(
                          child: (icon=="success")?
                          Icon(Icons.check_circle,
                            color: Colors.green[300],
                            size: 50,
                          ):
                          (icon=="failed"?
                          Icon(Icons.cancel,
                            color: Colors.red[300],
                            size: 50,
                          ):
                          Icon(Icons.info,
                            color: Colors.blue[300],
                            size: 50,                      )
                          )
                      ),
                      SizedBox(height: 10,),
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: Text(title, textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey[400]
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        child: Text(description, textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 14
                          ),
                        ),
                      ),
                      SizedBox(height: 40,),
                    ],
                  ),
                ),
              ),
            )
          );
        });
  }

  static Future<bool> confirmDialog(BuildContext context, String message)async{
    return await showDialog(context: context, builder: (context) => WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: AlertDialog(
        title: Text(message),
        actions: <Widget>[
          IconButton(
            onPressed: (){
              Navigator.of(context).pop(false);
            },
            icon: Icon(Icons.close, color: Colors.red,),
          ),
          IconButton(
            onPressed: (){
              Navigator.of(context).pop(true);
            },
            icon: Icon(Icons.check, color: Colors.green,),
          )
        ],
      ),
    ));
  }
}

