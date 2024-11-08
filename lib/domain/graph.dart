
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

abstract class GraphDataSource {
  ValueNotifier<GraphQLClient> initializeClient();
}