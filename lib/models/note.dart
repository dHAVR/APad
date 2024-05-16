import 'package:isar/isar.dart';

//gggg
part 'note.g.dart';

@Collection()
class Note{
   Id id = Isar.autoIncrement;
   late String text;
}