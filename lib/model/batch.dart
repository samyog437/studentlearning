import 'package:batch_student_objbox_api/model/student.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';

//flutter pub run build_runner build  --delete-conflicting-outputs
@Entity()
@JsonSerializable()
class Batch {
  @Id(assignable: true)
  int id;

  @Unique()
  @JsonKey(name: '_id')
  String? batchId;
  String? batchName;

  @Backlink()
  final student = ToMany<Student>();

  //Constructor
  Batch(this.batchId, this.batchName, {this.id = 0});

  // Receiving data from server, convert json to objectbox
  factory Batch.fromJson(Map<String, dynamic> json) {
    return Batch(
      json['_id'],
      json['batchName'],
    );
  }

  // Sending data to server, convert objectbox to json
  Map<String, dynamic> toJson() => {
        '_id': batchId,
        'batchName': batchName,
      };
}
