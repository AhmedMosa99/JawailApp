import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobil_shop/compount/details.dart';

class MobileList extends StatefulWidget {
  final id;
  final qty;
  final price;
  final screen;
  final screen_protect;
  final screen_res;
  final system;
  final ram;
  final name;
  final camera_main;
  final image;
  final cpu;
  final memory;
  final battery;


 MobileList({this.qty,this.id,this.price, this.screen, this.screen_protect, this.screen_res, this.system, this.ram, this.name, this.camera_main, this.image, this.cpu, this.memory, this.battery});

  @override
  _MobileListState createState() => _MobileListState();
}

class _MobileListState extends State<MobileList> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context){
        return Details(
          qty: widget.qty,
          id: widget.id,
          price: widget.price,
          screen: widget.screen,
          screen_protect: widget.screen_protect,
          system: widget.system,
          screen_res: widget.screen_res,
          cpu: widget.cpu,
          camera_main: widget.camera_main,
          battery: widget.battery,
          name: widget.name,
         ram: widget.ram,
          memory: widget.memory,
         image : widget.image,
        );
      })),
      child: Container(
        height: MediaQuery.of(context).size.height/3.5,
        width: MediaQuery.of(context).size.width,
        child: Card(
          child: Column(
            children: [
              Center(
                child: Text(
                widget.name,
                  //textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      child: Image.network(
                        '${widget.image}',
                        fit: BoxFit.contain,

                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                  flex:5,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                        alignment: Alignment.topRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [

                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "الكاميرا :",
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  widget.camera_main,
                                  style: TextStyle(
                                    color: Colors.blue,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "البطارية: ",
                                  style: TextStyle(fontSize: 18),
                                ),
                                Text(
                                  widget.battery,
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 16),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "الذاكرة :",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    Text(
                                      widget.memory,
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        "السعر:${widget.price}",
                                        style: TextStyle(color: Colors.red),
                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                return Details(
                                  id: widget.id,
                                  price: widget.price,
                                  screen: widget.screen,
                                  screen_protect: widget.screen_protect,
                                  system: widget.system,
                                  screen_res: widget.screen_res,
                                  cpu: widget.cpu,
                                  camera_main: widget.camera_main,
                                  battery: widget.battery,
                                  name: widget.name,
                                  ram: widget.ram,
                                  memory: widget.memory,
                                  image : widget.image,
                                );
                              })),
                              child: Text(
                                "للمزيد اضغط هنا ",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        )),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
