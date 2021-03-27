import 'package:flutter/material.dart';
import 'package:great_places/providers/greate_places.dart';
import 'package:great_places/utils/app_routes.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Places',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PLACE_FORM);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).loadPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                child: Center(
                  child: Text('No places registered!'),
                ),
                builder: (context, greatPlaces, child) =>
                    greatPlaces.itemsCount == 0
                        ? child
                        : ListView.builder(
                            itemCount: greatPlaces.itemsCount,
                            itemBuilder: (ctx, i) => Card(
                              margin: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              // elevation: 8.0,
                              child: Padding(
                                padding: const EdgeInsets.all(6),
                                child: Column(
                                  children: [
                                    ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: FileImage(
                                          greatPlaces.itemByIndex(i).image,
                                        ),
                                      ),
                                      title: Text(
                                        greatPlaces.itemByIndex(i).title,
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(greatPlaces
                                          .itemByIndex(i)
                                          .location
                                          .address),
                                      onTap: () {
                                        Navigator.of(context).pushNamed(
                                          AppRoutes.PLACE_DETAIL,
                                          arguments: greatPlaces.itemByIndex(i),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(AppRoutes.PLACE_FORM);
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
