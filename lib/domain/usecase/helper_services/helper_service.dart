import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../data/models/employee_model.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    try {
      _database = await _initDatabase();
      return _database!;
    } catch (e) {
      throw Exception('Failed to initialize database: $e');
    }
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    try {
      return await openDatabase(
        join(dbPath, 'employees.db'),
        onCreate: (db, version) {
          return db.execute(
            '''
            CREATE TABLE employee (
              id INTEGER PRIMARY KEY,
              employee_name TEXT,
              employee_salary INTEGER,
              employee_age INTEGER,
              profile_image TEXT
            )
            ''',
          );
        },
        version: 1,
      );
    } catch (e) {
      throw Exception('Failed to open or create database: $e');
    }
  }

  Future<void> insertEmployees(List<Data> employees) async {
    final db = await database;
    try {
      await db.delete('employee'); // Clear existing data
      for (var emp in employees) {
        await db.insert('employee', emp.toJson());
      }
    } catch (e) {
      throw Exception('Failed to insert employees: $e');
    }
  }

  Future<List<Data>> getEmployees() async {
    final db = await database;
    try {
      final List<Map<String, dynamic>> maps = await db.query('employee');
      return List.generate(maps.length, (i) {
        return Data.fromJson(maps[i]);
      });
    } catch (e) {
      throw Exception('Failed to retrieve employees: $e');
    }
  }
}
