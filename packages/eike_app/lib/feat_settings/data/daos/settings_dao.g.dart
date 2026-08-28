// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_dao.dart';

// ignore_for_file: type=lint
mixin _$SettingsDaoMixin on DatabaseAccessor<EikeDatabase> {
  $TeamContactTableTable get teamContactTable =>
      attachedDatabase.teamContactTable;
  SettingsDaoManager get managers => SettingsDaoManager(this);
}

class SettingsDaoManager {
  final _$SettingsDaoMixin _db;
  SettingsDaoManager(this._db);
  $$TeamContactTableTableTableManager get teamContactTable =>
      $$TeamContactTableTableTableManager(
        _db.attachedDatabase,
        _db.teamContactTable,
      );
}
