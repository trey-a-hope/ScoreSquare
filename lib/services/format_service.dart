import 'package:intl/intl.dart';

abstract class IFormatService {
  String yMMMd({required DateTime date});
  String eMMMddhmmaa({required DateTime date});
}

class FormatService extends IFormatService {
  @override
  String yMMMd({required DateTime date}) {
    return DateFormat.yMMMd().format(date);
  }

  @override
  String eMMMddhmmaa({required DateTime date}) {
    return DateFormat('E, MMM dd @ h:mm aa').format(date);
  }
}
