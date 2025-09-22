import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

final _hiveHandlerProvider = Provider<HiveHandler>((_) => HiveHandler());

class HiveHandler {
  static Provider<HiveHandler> get provider => _hiveHandlerProvider;

  static const _boxName = 'favorite_service_ids';

  Box<String> get _box => Hive.box<String>(_boxName);

  List<String> getAll() => _box.values.toList();

  bool isFav(String id) => _box.containsKey(id);

  Future<void> add(String id) async => _box.put(id, id);

  Future<void> remove(String id) async => _box.delete(id);
}
