import 'package:flutter/material.dart';
import 'package:finalapi/files.dart';

void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        accentColor: Colors.black,
        primaryColor: Colors.white,
        brightness: Brightness.light,
      ),
      home: const FinalApi(),
    ));

class FinalApi extends StatefulWidget {
  const FinalApi({Key? key}) : super(key: key);

  @override
  _FinalApiState createState() => _FinalApiState();
}

class _FinalApiState extends State<FinalApi> {
  Future<List<User>> fetchUser(BuildContext context) async {
    final jsonString =
        await DefaultAssetBundle.of(context).loadString('lib/assets/user.json');
    return userFromJson(jsonString);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Final Api Testing'),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: FutureBuilder(
            future: fetchUser(context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: (snapshot.data as dynamic).length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    User user = (snapshot.data as dynamic)[index];
                    return ListTile(
                      title: Text(
                        user.email,
                      ),
                      subtitle: Text(user.username),
                      trailing: Text(user.address.city),
                      leading: Text(user.id.toString()),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Container(
                  child: const Center(
                    child: Text('Connection not Successful '),
                  ),
                );
              } else {
                return Container(
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            }),
      ),
    );
  }
}
