import 'dart:io';

import 'package:batch_student_objbox_api/app/network_connectivity.dart';
import 'package:batch_student_objbox_api/data_source/local_data_source/student_data_source.dart';
import 'package:batch_student_objbox_api/data_source/remote_data_source/student_data_source.dart';
import 'package:batch_student_objbox_api/model/student.dart';

abstract class StudentRepository {
  Future<List<Student>> getStudents();
  Future<List<Student>?> getStudentsByCourse(String courseId);
  Future<List<Student>?> getStudentsByBatch(String batchId);
  Future<int> addStudent(File? file, Student student);
  Future<bool> loginStudent(String username, String password);
}

class StudentRepositoryImpl extends StudentRepository {
  @override
  Future<int> addStudent(File? file, Student student) async {
    return StudentRemoteDataSource().addStudent(file, student);
  }

  @override
  Future<List<Student>> getStudents() async {
    bool status = await NetworkConnectivity.isOnline();
    if (status) {
      return StudentDataSource().getStudents();
    } else {
      return [];
    }
  }

  @override
  Future<bool> loginStudent(String username, String password) async {
    return StudentRemoteDataSource().loginStudent(username, password);
  }

  @override
  Future<List<Student>?> getStudentsByBatch(String batchId) async {
    bool status = await NetworkConnectivity.isOnline();
    if (status) {
      return StudentRemoteDataSource().getStudentsByBatch(batchId);
    } else {
      return [];
    }
  }

  @override
  Future<List<Student>?> getStudentsByCourse(String courseId) async {
    bool status = await NetworkConnectivity.isOnline();
    if (status) {
      return StudentRemoteDataSource().getStudentsByCourse(courseId);
    } else {
      return [];
    }
  }
}
