import 'package:intl/intl.dart';

abstract class IFormatService {
  String yMMMd({required DateTime date});
}

class FormatService extends IFormatService {
  @override
  String yMMMd({required DateTime date}) {
    return DateFormat.yMMMd().format(date);
  }
}
