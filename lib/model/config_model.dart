

class ConfigModel{
  final String searchUrl;

  ConfigModel({this.searchUrl});

  factory ConfigModel.fromJson(Map<String,dynamic> map){
    return ConfigModel(searchUrl:map['searchUrl']);
  }

  Map<String,dynamic> toJson(){
    return{
      searchUrl:searchUrl
    };
  }
}