import 'package:flutter/material.dart';
import 'package:flutter_app_name/model/travel_item_model.dart';
import 'package:flutter_app_name/net/travel_net.dart';
import 'package:flutter_app_name/widget/loading_widget.dart';
import 'package:flutter_app_name/widget/webview.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class TravelPageItem extends StatefulWidget {
  final String groupChannelCode;
  final int type;

  const TravelPageItem({Key key, this.groupChannelCode, this.type})
      : super(key: key);

  @override
  _TravelItemState createState() => _TravelItemState();
}

class _TravelItemState extends State<TravelPageItem> with AutomaticKeepAliveClientMixin{
  int pageIndex = 1;
  TraveItemlModel traveItemlModel;
  bool isLoading = true;
  List<TravelItem> resultList;
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    _loadData();
    scrollController.addListener(() {
      if(scrollController.position.pixels==scrollController.position.maxScrollExtent){
        _loadData(loadMore: true);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingWidget(
        isLoading: isLoading,
        child: RefreshIndicator(
          onRefresh: _onPullRefresh,
          child: MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: StaggeredGridView.countBuilder(
              controller: scrollController,
              crossAxisCount: 2,
              itemCount: resultList?.length ?? 0,
              itemBuilder: (BuildContext context, int index) =>
                  _addItem(context, index),
              staggeredTileBuilder: (int index) => new StaggeredTile.fit(1),
            ),
          ),
        ));
  }

  void _loadData({bool loadMore=false}) {
    if(loadMore){
      pageIndex++;
    }else{
      resultList=null;
      pageIndex=1;
    }
    TravelNet.getTravelData(pageIndex, widget.groupChannelCode, widget.type)
        .then((data) {
      setState(() {
        if(resultList==null){
          resultList=data.resultList.where((element) => element.article!=null).toList();
        }else{
          resultList.addAll(data.resultList.where((element) => element.article!=null).toList());
        }
        traveItemlModel = data;
        isLoading = false;
      });
    }).catchError((onError) {
      setState(() {
        isLoading = false;
      });
    });
  }

  _addItem(BuildContext context, int index) {
    if (resultList == null ||
       resultList.length == 0) return Text('');
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => WebView(
                  url: resultList[index].article.urls[0].h5Url,
                  title: '详情',
                  hideAppBar: false,
                )));
      },
      child: Card(
          child: PhysicalModel(
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _topItem(context, index),
            Container(
              margin: EdgeInsets.only(left: 5),
              padding: EdgeInsets.fromLTRB(5, 8, 8, 8),
              child: Text(
                resultList[index].article.articleTitle,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            _BottomItem(context, index)
          ],
        ),
      )),
    );
  }

  _topItem(BuildContext context, int index) {
    return Stack(
      children: [
        Image.network(
          resultList[index].article.images[0].dynamicUrl,
        ),
        Positioned(
            left: 10,
            bottom: 8,
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Color(int.parse('0xC7000000'))),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.white,
                    size: 12,
                  ),
                  LimitedBox(
                    maxWidth: 130,
                    child: Padding(
                      padding: EdgeInsets.only(left: 7),
                      child: Text(
                        resultList[index].article.poiName,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  )
                ],
              ),
            ))
      ],
    );
  }

  _BottomItem(BuildContext context, int index) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              PhysicalModel(
                  color: Colors.transparent,
                  clipBehavior: Clip.antiAlias,
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    resultList[index].article.author.coverImage.dynamicUrl,
                    width: 24,
                    height: 24,
                  )),
              Container(
                width: 90,
                padding: EdgeInsets.only(left: 5),
                child: Text(
                    resultList[index].article.author.nickName,
                    style: TextStyle(color: Colors.black, fontSize: 12),maxLines: 1,overflow: TextOverflow.ellipsis,),
              )
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.thumb_up,
                color: Colors.grey,
                size: 12,
              ),
              Container(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  resultList[index].article.likeCount
                      .toString(),
                  style: TextStyle(color: Colors.black, fontSize: 12),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Future<Null> _onPullRefresh() async {
    _loadData();
    return null;
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
