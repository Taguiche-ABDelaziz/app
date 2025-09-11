// ignore: non_constant_identifier_names
import 'package:course_getx/constant/message.dart';

validInput(String val, int min, int max) {
  if (val.length > max) {
    return "$messageInputMax $max";
  }
  if (val.isEmpty) {
    // ignore: unnecessary_string_interpolations
    return "$messageInputEmput";
  }
  if (val.length < min) {
    return "$messageInputMin $min";
  }
}
