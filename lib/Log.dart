import 'package:logger/logger.dart' as l;
class Log {
  static final _logger = l.Logger(
    printer:l.PrettyPrinter(stackTraceBeginIndex: 1, printEmojis: true, methodCount: 0, errorMethodCount: 10),
    // level: l.Level.debug
  );

  ///Verbose log
  ///[message] is the message to log
  static void v(dynamic message) {
    _logger.v(message);
  }

  ///Debug log
  ///[message] is the message to log
  static void d(dynamic message) {
    _logger.d(message);
  }

  ///Info log
  ///[message] is the message to log
  static void i(dynamic message) {
    var frames = StackTrace.current.toString().split("\n");
    /* The second frame is the caller function */
    var callingFunction = _getFunctionNameFromFrame(frames[1]);

    print("${callingFunction}() --- ${message}");
    // _logger.i(message);
  }

  ///Warning log
  ///[message] is the message to log
  static void w(dynamic message) {
    _logger.w(message);
  }

  ///Error log
  ///[message] is the message to log
  static void e(dynamic message) {
    _logger.e(message);
  }

  ///What The Fuck?!?!
  ///[fuck] is the message to log
  static void wtf(dynamic fuck) {
    _logger.wtf(fuck);
  }


  static String _getFunctionNameFromFrame(String frame) {
    /* Just giving another nickname to the frame */
    var currentTrace = frame;

    /* To get rid off the #number thing, get the index of the first whitespace */
    var indexOfWhiteSpace = currentTrace.indexOf(' ');

    /* Create a substring from the first whitespace index till the end of the string */
    var subStr = currentTrace.substring(indexOfWhiteSpace);

    /* Grab the function name using reg expr */
    var indexOfFunction = subStr.indexOf(RegExp(r'[A-Za-z0-9]'));

    /* Create a new substring from the function name index till the end of string */
    subStr = subStr.substring(indexOfFunction);

    indexOfWhiteSpace = subStr.indexOf(' ');

    /* Create a new substring from start to the first index of a whitespace. This substring gives us the function name */
    subStr = subStr.substring(0, indexOfWhiteSpace);

    return subStr;
  }

  
}