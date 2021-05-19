import 'dart:io';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';
import 'package:qr_reader/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';

const DATABASE_FILE_NAME = 'scans.db';

class DBProvider {
  static Database? _database;

  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> initDB() async {
    // Database path

    Directory dataDirectory = await getApplicationDocumentsDirectory();

    final path = join(dataDirectory.path, DATABASE_FILE_NAME);
    print("Path");
    print(path);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          create table scans(
            id integer primary key autoincrement,
            tipo text,
            valor text
          );
        ''');
      },
    );
  }

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  Future<ScanModel?> insertScan(ScanModel newScan) async {
    final db = await database;

    if (db == null) return null;

    final res = await db.insert('scans', {
      'tipo': newScan.tipo,
      'valor': newScan.valor,
    });

    newScan.id = res;

    return newScan;
  }

  Future<ScanModel?> getScanCode(int id) async {
    final db = await database;

    if (db == null) return null;

    final response = await db.query('scans', where: 'id = ?', whereArgs: [id]);

    if (response.isEmpty) return null;

    return ScanModel.fromJson(response.first);
  }

  Future<List<ScanModel>> listScanCodes({String? tipo}) async {
    final db = await database;

    if (db == null) return [];
    List response;
    if (tipo == null) {
      response = await db.query('scans');
    } else {
      response = await db.query('scans', where: 'tipo = ?', whereArgs: [tipo]);
    }

    return response.map((scan) => ScanModel.fromJson(scan)).toList();
  }

  Future<int?> updateScan(ScanModel updatedScan) async {
    final db = await database;

    if (db == null) return null;

    return await db.update(
      'scans',
      updatedScan.toJson(),
      where: 'id = ?',
      whereArgs: [updatedScan.id],
    );
  }

  Future<int> deleteScan({int? id}) async {
    final db = await database;

    if (db == null) return 0;

    if (id == null) return await db.rawDelete('delete from scans');

    return await db.delete('scans', where: 'id = ?', whereArgs: [id]);
  }
}
