class SearchModel {
  String keyWord;
  List<Data> data;

  SearchModel({this.data});

   SearchModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String code;
  String word;
  String type;
  String districtname;
  String url;
  String price;
  String zonename;
  String star;

  Data(
      {this.code,
        this.word,
        this.type,
        this.districtname,
        this.url,
        this.price,
        this.zonename,
        this.star});

  Data.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    word = json['word'];
    type = json['type'];
    districtname = json['districtname'];
    url = json['url'];
    price = json['price'];
    zonename = json['zonename'];
    star = json['star'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['word'] = this.word;
    data['type'] = this.type;
    data['districtname'] = this.districtname;
    data['url'] = this.url;
    data['price'] = this.price;
    data['zonename'] = this.zonename;
    data['star'] = this.star;
    return data;
  }
}
