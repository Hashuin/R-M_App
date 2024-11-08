import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../domain/graph.dart';

class GraphQLConfig implements GraphDataSource {
@override
  ValueNotifier<GraphQLClient> initializeClient() {
    final HttpLink httpLink = HttpLink(
      dotenv.env['RICK_AND_MORTY_API_URL']!,
    );

    final AuthLink authLink = AuthLink(
      getToken: () async => 'Bearer ${dotenv.env['RICK_AND_MORTY_API_URL']}',
    );

    final Link link = authLink.concat(httpLink);

    return ValueNotifier(
      GraphQLClient(
        cache: GraphQLCache(),
        link: link,
      ),
    );
  }
}
