import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_test/model/repo.dart';
import 'package:technical_test/widgets/repoWidget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _pageController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flutter Repos",
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _pageController,
                    onFieldSubmitted: (_) {},
                    decoration: InputDecoration(
                        suffixIcon: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Colors.grey,
                              size: 15,
                            ),
                            onPressed: () {
                              _pageController.clear();
                            }),
                        labelText: "Page No."),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: MaterialButton(
                      color: Colors.blue,
                      onPressed: () {
                        setState(() {});
                      },
                      child: Text("SEARCH PAGE"),
                    ))
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.8,
            width: MediaQuery.of(context).size.width,
            child: FutureBuilder(
              future: Provider.of<AppProvider>(context, listen: false)
                  .getRepos(_pageController.text),
              builder: (ctx, dataSnapShot) {
                if (dataSnapShot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  if (dataSnapShot.error != null) {
                    return Center(
                      child: Text("An Error has Occured"),
                    );
                  } else {
                    return Consumer<AppProvider>(
                        builder: (ctx, appData, child) => appData.repos.length >
                                0
                            ? ListView.builder(
                                itemBuilder: (BuildContext context, int index) {
                                  return RepoWidget(
                                    repo: appData.repos[index],
                                  );
                                },
                                itemCount: appData.repos.length,
                              )
                            : Center(
                                child: Text("Repos Data is currently Empty"),
                              ));
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
