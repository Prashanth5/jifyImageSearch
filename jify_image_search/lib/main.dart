import 'package:flutter/material.dart';
import 'package:jify_image_search/model/image_model.dart';
import 'package:jify_image_search/service/api_helper.dart';
import 'package:jify_image_search/ui/image_listtile.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyHomePageState();
  }
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Hit>> imageHits;
  Future<List<Hit>> tempImageHits;
  List<Hit> imageList = List<Hit>();
  List<Hit> tempImageList = List<Hit>();
  ScrollController _scrollController = new ScrollController();
  var pageCount = 1;
  var userInput = "";
  bool isLoading = false;
  // @override
  // void initState() {
  //   setUpApiWithSearchItem();
  //   _scrollController.addListener(() {
  //     if (_scrollController.position.pixels ==
  //             _scrollController.position.maxScrollExtent &&
  //         !isLoading) {
  //       print('NEW DATA CALLED');
  //       userInput = (userInput.length > 0) ? userInput : 'Flower';
  //       setUpApiWithSearchItem(item: userInput);
  //     }
  //   });
  //   super.initState();
  // }
  @override
  void initState() {
    setUpApiWithSearchItem2();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          !isLoading) {
        userInput = (userInput.length > 0) ? userInput : 'Flower';
        setUpApiWithSearchItem2(item: userInput);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void setUpApiWithSearchItem({String item = 'flower'}) {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
    }

    tempImageHits = ApiHelper().getImages(searchItem: item, page: pageCount);
    pageCount++;
    if (tempImageHits != null) {
      Future.delayed(Duration(seconds: 5), () {
        setState(() {
          imageHits = tempImageHits;
          isLoading = false;
        });
      });
    }
  }

  void setUpApiWithSearchItem2({String item = 'flower'}) async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
    }

    tempImageList =
        await ApiHelper().getImages(searchItem: item, page: pageCount);

    if (tempImageList.isNotEmpty) {
      imageList.addAll(tempImageList);
      pageCount++;
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: buildSearchContainer(),
      ),
      // body: buildFutureBuilderListView(),
      body: getListView(),
    );
  }

  Container buildSearchContainer() {
    return Container(
        height: 50,
        padding: EdgeInsets.all(8),
        child: TextField(
            onSubmitted: (value) {
              setState(() {
                userInput = value;
                setUpApiWithSearchItem(item: value);
              });
            },
            decoration: InputDecoration(
                fillColor: Colors.black.withOpacity(0.1),
                filled: true,
                prefixIcon: Icon(Icons.search),
                hintText: 'Search For Images ...',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                contentPadding: EdgeInsets.zero)));
  }

  FutureBuilder<List<Hit>> buildFutureBuilderListView() {
    return FutureBuilder<List<Hit>>(
      future: imageHits,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error.toString(),
              // 'Use the search on the top'
            ),
          );
        } else if (snapshot.hasData) {
          return buildListView(snapshot);
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget buildListView(AsyncSnapshot<List<Hit>> snapshot) {
    return Stack(children: [
      ListView.builder(
        controller: _scrollController,
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          return ImageListTile(snapshot.data[index]);
        },
      ),
      if (isLoading) ...[
        Positioned(
          child: Container(
            height: 80,
            width: MediaQuery.of(context).size.width,
            child: Center(child: CircularProgressIndicator()),
          ),
          left: 0,
          bottom: 0,
        )
      ]
    ]);
  }

  Widget buildCircularProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }

  Widget getListView() {
    return Stack(
      children: [
        ListView.builder(
            itemCount: imageList.length,
            controller: _scrollController,
            itemBuilder: (context, index) {
              return ImageListTile(imageList[index]);
            }),
        if (isLoading) ...[
          Positioned(
            child: Container(
              height: 80,
              width: MediaQuery.of(context).size.width,
              child: Center(child: CircularProgressIndicator()),
            ),
            left: 0,
            bottom: 0,
          )
        ]
      ],
    );
  }
}
