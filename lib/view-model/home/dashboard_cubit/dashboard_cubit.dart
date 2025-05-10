import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardInitial());
  int maxChatbotRequests = 0;
  int maxImageDetectorRequests = 0;
  void sendLimitRequests({required int maxChatbotRequests, required int maxImageDetectorRequests}) async {
    var rule= FirebaseFirestore.instance;
    await rule.collection("limits").doc("appLimits").set({
    "max_chatbot_requests":maxChatbotRequests,
    "max_image_detector_requests":maxImageDetectorRequests
    });
    emit(
      DashboardLoaded(
        maxChatbotRequests: maxChatbotRequests,
        maxImageDetectorRequests: maxImageDetectorRequests,
      ),
    );
  }

  void getLimitRequests() async {
    var rule = FirebaseFirestore.instance;
    var docSnapshot = await rule.collection("limits").doc("appLimits").get();
    if (docSnapshot.exists) {
      var data = docSnapshot.data();
      if (data != null) {
      maxChatbotRequests = data["max_chatbot_requests"] ?? 0;
      maxImageDetectorRequests = data["max_image_detector_requests"] ?? 0;
      }
    }
    emit(
      DashboardLoaded(
        maxChatbotRequests: maxChatbotRequests,
        maxImageDetectorRequests: maxImageDetectorRequests,
      ),
    );
  }
}
