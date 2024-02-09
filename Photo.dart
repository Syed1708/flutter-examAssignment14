
class Photo {
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  Photo({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  Photo.fromJson(Map<String, dynamic> json) {
    albumId = json['albumId'];
    id = json['id'];
    title = json['title'];
    url = json['url'];
    thumbnailUrl = json['thumbnailUrl'];
  }


  // now encode product to json format
  Map<String, dynamic> toJson(){
    return {
      "albumId" : albumId,
      "id" : id,
      "title" : title,
      "url" : url,
      "thumbnailUrl" : thumbnailUrl,
    };
  }
}


//
// class Photo{
//
//   String? id;
//   String? productName;
//   String? productCode;
//   String? image;
//   String? unitPrice;
//   String? quantity;
//   String? totalPrice;
//   String? createDate;
//
//   //constructor
//   Photo({
//     this.id,
//     this.productName,
//     this.productCode,
//     this.image,
//     this.unitPrice,
//     this.quantity,
//     this.totalPrice,
//     this.createDate,
//   });
//
//   //name conductor to decode json data
//   Photo.fromJson(Map<String, dynamic> json){
//     id = json['_id'];
//     productName = json['ProductName'];
//     productCode= json['ProductCode'];
//     image= json['Img'];
//     unitPrice= json['UnitPrice'];
//     quantity= json['Qty'];
//     totalPrice= json['TotalPrice'];
//     createDate= json['CreateDate'];
//
//   }
//
// // now encode product to json format
//   Map<String, dynamic> toJson(){
//     return {
//       "ProductName" : productName,
//       "ProductCode" : productCode,
//       "Img" : image,
//       "Qty" : quantity,
//       "UnitPrice" : unitPrice,
//       "TotalPrice" : totalPrice,
//       "_id" : id,
//     };
//   }



//}
