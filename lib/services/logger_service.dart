import 'dart:io';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';

class LoggerService {
  static final LoggerService _instance = LoggerService._internal();
  late Logger _logger;
  late File _logFile;
  late StringBuffer _logBuffer;

  LoggerService._internal();

  factory LoggerService() {
    return _instance;
  }

  Future<void> init() async {
    _logBuffer = StringBuffer();

    try {
      final appDocDir = await getApplicationDocumentsDirectory();
      final logsDir = Directory('${appDocDir.path}/logs');

      if (!await logsDir.exists()) {
        await logsDir.create(recursive: true);
      }

      final timestamp = DateTime.now().toString().replaceAll(':', '-').split('.')[0];
      _logFile = File('${logsDir.path}/aivo_$timestamp.log');

      _logger = Logger(
        printer: PrettyPrinter(
          methodCount: 2,
          errorMethodCount: 8,
          lineLength: 120,
          colors: true,
          printEmojis: true,
        ),
        output: _FileOutput(_logFile, _logBuffer),
      );

      i('=== AIVO Logger Service Initialized ===');
    } catch (e) {
      print('❌ Failed to initialize logger: $e');
      _logger = Logger();
    }
  }

  void i(String message) => _logger.i(message);
  void d(String message) => _logger.d(message);
  void e(String message, [dynamic error, StackTrace? stackTrace]) =>
      _logger.e(message, error: error, stackTrace: stackTrace);
  void w(String message) => _logger.w(message);

  Future<String> getLogPath() async {
    return _logFile.path;
  }

  Future<String> getLogContent() async {
    try {
      return await _logFile.readAsString();
    } catch (e) {
      return 'Error reading log file: $e';
    }
  }
}

class _FileOutput extends LogOutput {
  final File logFile;
  final StringBuffer logBuffer;

  _FileOutput(this.logFile, this.logBuffer);

  @override
  void output(OutputEvent event) {
    for (var line in event.lines) {
      logBuffer.writeln(line);
    }
    _writeToFile();
  }

  void _writeToFile() {
    try {
      logFile.writeAsStringSync(logBuffer.toString());
    } catch (e) {
      print('❌ Error writing to log file: $e');
    }
  }
}
