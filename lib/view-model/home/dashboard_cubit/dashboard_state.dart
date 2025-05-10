part of 'dashboard_cubit.dart';

sealed class DashboardState {
int maxChatbotRequests;
int maxImageDetectorRequests;
DashboardState({required this.maxChatbotRequests,required this.maxImageDetectorRequests});
}

final class DashboardInitial extends DashboardState {
DashboardInitial():super(maxChatbotRequests: 0,maxImageDetectorRequests: 0);
}

final class DashboardLoaded extends DashboardState{
  DashboardLoaded({required super.maxChatbotRequests,required super.maxImageDetectorRequests});
}