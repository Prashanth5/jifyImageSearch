import 'package:flutter/material.dart';
import 'package:jify_image_search/model/image_model.dart';
import 'package:jify_image_search/service/api_helper.dart';
import 'package:jify_image_search/ui/image_listtile.dart';
import 'package:jify_image_search/viewmodel/my_home_viewmodel.dart';

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
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MyHomeViewModel homeViewModel = MyHomeViewModel();
  @override
  void initState() {
    homeViewModel.setUpApiWithSearchItem();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: buildSearchContainer(),
      ),
      body: buildFutureBuilderListView(),
    );
  }

  Container buildSearchContainer() {
    return Container(
        height: 50,
        padding: EdgeInsets.all(8),
        child: TextField(
            onSubmitted: (value) {
              setState(() {
                homeViewModel.setUpApiWithSearchItem(item: value);
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
      future: homeViewModel.imageHits,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(
              snapshot.error.toString(),
              // 'Use the search on the top'
            ),
          );
        } else if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            return buildListView(snapshot);
          } else {
            return Center(
              child: Text('No Data Found.'),
            );
          }
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  ListView buildListView(AsyncSnapshot<List<Hit>> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          // return ListTile(
          //   leading: Container(
          //     child: Image.network(snapshot.data[index].previewUrl),
          //     height: 100,
          //     width: 100,
          //     padding: EdgeInsets.all(12.0),
          //   ),
          //   title: Text(snapshot.data[index].type.toString()),
          // );
          return ImageListTile(snapshot.data[index]);
        });
  }
}
