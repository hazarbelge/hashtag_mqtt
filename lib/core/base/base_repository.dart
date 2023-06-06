import 'package:hashtag_mqtt/core/base/index.dart';

abstract class BaseRepository<P extends BaseProvider> {
  BaseRepository({
    required this.provider,
  });

  final P provider;
}
