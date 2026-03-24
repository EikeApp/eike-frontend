// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact_dao.dart';

// ignore_for_file: type=lint
mixin _$ContactDaoMixin on DatabaseAccessor<EikeDatabase> {
  $TeamContactTableTable get teamContactTable =>
      attachedDatabase.teamContactTable;
  ContactDaoManager get managers => ContactDaoManager(this);
}

class ContactDaoManager {
  final _$ContactDaoMixin _db;
  ContactDaoManager(this._db);
  $$TeamContactTableTableTableManager get teamContactTable =>
      $$TeamContactTableTableTableManager(
        _db.attachedDatabase,
        _db.teamContactTable,
      );
}
