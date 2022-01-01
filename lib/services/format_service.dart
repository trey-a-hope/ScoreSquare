import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

abstract class IFormatService {
  String yMMMd({required DateTime date});
  String eMMMddhmmaa({required DateTime date});
  String timeAgo({required DateTime date});
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

  @override
  String timeAgo({required DateTime date}) {
    return timeago.format(date);
  }
}
