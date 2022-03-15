class ServerException implements Exception {
  ServerException();
}

class ConnectionException implements Exception {
  ConnectionException();
}

class CacheException implements Exception {}

//** this exception is only for developper account
class UpgradeToPayedPlanException implements Exception {}
