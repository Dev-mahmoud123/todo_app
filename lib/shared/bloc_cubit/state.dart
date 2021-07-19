abstract class AppState {}

// BOTTOM NAVIGATOR STATE
class AppInitState extends AppState{}
class AppChangeBottomNavState extends AppState{}

// BOTTOM SHEET STATE
class AppBottomSheetState extends AppState{}
// Loading state
class AppLoadingState extends AppState{}

// SQFLite database State
class AppCreateDatabaseState extends AppState{}
class AppInsertDatabaseState extends AppState{}
class AppGetDatabaseState extends AppState{}
class AppUpdateDatabaseState extends AppState{}
class AppDeleteDatabaseState extends AppState{}
