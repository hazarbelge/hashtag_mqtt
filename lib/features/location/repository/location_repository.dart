import 'package:hashtag_mqtt/core/base/index.dart';

abstract class IHashTagProvider {}

class HashTagProvider extends BaseProvider implements IHashTagProvider {}

abstract class IHashTagRepository {}

class HashTagRepository extends BaseRepository<HashTagProvider> implements IHashTagRepository {
  HashTagRepository() : super(provider: HashTagProvider());
}
