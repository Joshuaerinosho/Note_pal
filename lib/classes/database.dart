import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';

//import 'constants.dart';

class DatabaseFileRoutines {
  //document directory path
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // path combined with file name
  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/local_persistence.json');
  }

  //reads the file
  Future<String> readJournals() async {
    try {
      final file = await _localFile;
      if (!file.existsSync()) {
        print("File does not Exist: ${file.absolute}");
        await writeJournals('{"journals": []}');
      }
      // Read the file
      String contents = await file.readAsString();
      return contents;
    } catch (e) {
      //print("error readJournals: $e");
      return "";
    }
  }

  //creates a new jornal
  Future<File> writeJournals(String json) async {
    final file = await _localFile;
    // Write the file
    return file.writeAsString('$json');
  }
}

  // To read and parse from JSON data 
  Database databaseFromJson(String str) {
    final dataFromJson = json.decode(str);
    return Database.fromJson(dataFromJson);
  }

  // To save and parse to JSON Data
  String databaseToJson(Database data) {
    final dataToJson = data.toJson();
    return json.encode(dataToJson);
  }

class Database {
  List<Journal> journal;
  Database({
    this.journal,
  });
  //To retrieve and map the JSON objects to a list of Journal classes
  factory Database.fromJson(Map<String, dynamic> json) => Database(
        journal: List<Journal>.from(
            json["journals"].map((x) => Journal.fromJson(x))),
      );
//To convert the List<Journal> to JSON objects
  Map<String, dynamic> toJson() => {
        "journals": List<dynamic>.from(journal.map((x) => x.toJson())),
      };
}

//journal class
class Journal {
  String id;
  String date;
  String mood;
  String note;
  Journal({
    this.id,
    this.date,
    this.mood,
    this.note,
  });

  //To retrieve and convert the JSON object to a Journal class
    factory Journal.fromJson(Map<String, dynamic> json) => Journal(
          id: json["id"],
          date: json["date"],
          mood: json["mood"],
          note: json["note"],
        );
  //To convert the journal class to a JSON object
    Map<String, dynamic> toJson() => {
          "id": id,
          "date": date,
          "mood": mood,
          "note": note,
        };
}

//the JournalEdit class that is responsible for passing the action and a journal entry between pages.
class JournalEdit {
String action; Journal journal;
JournalEdit({this.action, this.journal});
}
