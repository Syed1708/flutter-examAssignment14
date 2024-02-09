import 'dart:convert';
//import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'Photo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Viewer App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PhotoListScreen(),
    );
  }
}

class PhotoListScreen extends StatefulWidget {
  @override
  _PhotoListScreenState createState() => _PhotoListScreenState();
}

class _PhotoListScreenState extends State<PhotoListScreen> {
  List<Photo> PhotoList = [];
  bool isLoading = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _getPhotoList();
  }

  Future<void> _getPhotoList() async {


    try {
      isLoading = true;
      setState(() {});

      //make URL
      Uri url = Uri.parse('https://jsonplaceholder.typicode.com/photos');

      //get response get,post or other
      final response = await get(url);

      if (response.statusCode == 200) {
        PhotoList.clear();

        var list = jsonDecode(response.body);
        print(list);

          for (var item in list) {
            //create product with Product obj
            //or build Photo just call photo model
            //fromJson with transform json data into an obj
            Photo photo = Photo.fromJson(item);
            //then add photo in photo array
            PhotoList.add(photo);
          }


        isLoading = false;
        setState(() {});

      } else {
        setState(() {
          errorMessage = 'Failed to load photos';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }

 /* Future<void> _getPhotoList() async {

    //make URL
    Uri url = Uri.parse('https://crud.teamrabbil.com/api/V1/ReadProduct');
    //get response get,post or other
    Response response = await get(url);
    //then response
    //print(response);
    //print(response.statusCode);
    //print(response.body);

    if (response.statusCode == 200) {
      // first clear previous data
      PhotoList.clear();

      var decodeResponse = jsonDecode(response.body);
      print(decodeResponse);
      if (decodeResponse['status'] == 'success') {
        var list = decodeResponse['data'];
        for (var item in list) {
          //create product with Product obj

          *//*Product product = Product(
            id: item['_id'],
            productName: item['ProductName'],
            productCode: item['ProductCode'],
            image: item['Img'],
            unitPrice: item['UnitPrice'],
            quantity: item['Qty'],
            totalPrice: item['TotalPrice'],
            createDate: item['CreateDate'],
          );*//*
          //or build product just call product model
          //fromJson with transform json data into an obj
          Photo photo = Photo.fromJson(item);
          //then add product in product array
          PhotoList.add(photo);
        }
      }
    }


  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Viewer'),
      ),

      body: RefreshIndicator(
        onRefresh: () async {
          _getPhotoList();
        },
        child: Visibility(
          visible:  isLoading == false,
          //replacement
          replacement: const Center(child: CircularProgressIndicator()),
          child: ListView.builder(
              itemCount: PhotoList.length,
              itemBuilder: (context, index) {
                return _getPhotoListTile(PhotoList[index]);
              }),
        ),
      ),
    );
  }

  //method extraction

  Widget _getPhotoListTile(Photo photo){


    return ListTile(
      leading: CircleAvatar(
        backgroundImage:
        NetworkImage(photo.thumbnailUrl ?? ''),
      ),
      title: Text('${photo.title}'),


      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PhotoDetailScreen(
              photo: photo,
            ),
          ),
        );
      },
    );

  }

/*
  Widget _getPhotoListTile(Photo photo) {
    return ListTile(
      title: Text('${photo.title}'),
      leading: CachedNetworkImage(
        imageUrl: "${photo.thumbnailUrl}",
        width: 50,
        height: 50,
        fit: BoxFit.cover,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PhotoDetailScreen(
              photo: photo,
            ),
          ),
        );
      },
    );
  }

*/


}



class PhotoDetailScreen extends StatelessWidget {
  final Photo photo;

  const PhotoDetailScreen({required this.photo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Photo Details'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            '${photo.url}',
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 20),
          Text('Title: ${photo.title}'),
          SizedBox(height: 10),
          Text('ID: ${photo.id}'),
        ],
      ),
    );
  }
}


