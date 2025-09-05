class AppConstants {
  static const String appName = 'Production Management';
  
  // API Configuration
  static const String baseUrl = 'https://api.production.example.com';
  static const Duration requestTimeout = Duration(seconds: 30);
  
  // Pagination
  static const int defaultPageSize = 20;
  
  // Validation
  static const int maxBarcodeLength = 50;
  static const int maxQuantity = 999999;
  
  // Status values
  static const String statusPending = 'PENDING';
  static const String statusInProgress = 'IN_PROGRESS';
  static const String statusCompleted = 'COMPLETED';
  static const String statusCancelled = 'CANCELLED';
  
  // Material movement types
  static const String movementTypeOutput = 'OUTPUT';
  static const String movementTypeReturn = 'RETURN';
  
  // Quality statuses
  static const String qualityGood = 'GOOD';
  static const String qualityReject = 'REJECT';
  static const String qualityReprocess = 'REPROCESS';
}