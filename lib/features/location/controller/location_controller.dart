import 'package:hashtag_mqtt/core/base/index.dart';
import 'package:hashtag_mqtt/features/location/index.dart';

class HashTagController extends BaseRepositoryController<HashTagRepository, HashTagProvider, dynamic> {
  HashTagController() : super(repository: HashTagRepository());
}
