class CommonModel {
  final String icon;
  final String url;
  final String title;
  final String statusBarColor;
  final bool hideAppBar;

  CommonModel(
      {this.icon, this.url, this.title, this.statusBarColor, this.hideAppBar});
  factory CommonModel.fromJson(Map<String, dynamic> map) {
    return CommonModel(
      icon: map['icon'],
      url: map['url'],
      title: map['title'],
      statusBarColor: map['statusBarColor'],
      hideAppBar: map['hideAppBar'],
    );
  }


}
