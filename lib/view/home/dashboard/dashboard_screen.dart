import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:my_visitor_admin/view-model/home/dashboard_cubit/dashboard_cubit.dart';
import 'package:my_visitor_admin/widgets/custom_text_field.dart';

class DashboardScreen extends StatelessWidget {
  TextEditingController maxChatbotRequestsController = TextEditingController();
  TextEditingController maxImageDetectorRequestsController =
      TextEditingController();
  String? maxChatbotRequests;
  String? maxImageDetectorRequests;
  DashboardScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DashboardCubit(),
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16),
          children: [
            BlocBuilder<DashboardCubit, DashboardState>(
              builder: (context, state) {
                if (state is DashboardInitial) {
                  context.read<DashboardCubit>().getLimitRequests();
                }
                if (state is DashboardLoaded) {
                  maxChatbotRequests = state.maxChatbotRequests.toString();
                  maxImageDetectorRequests =
                      state.maxImageDetectorRequests.toString();
                  maxChatbotRequestsController.text = maxChatbotRequests!;
                  maxImageDetectorRequestsController.text =
                      maxImageDetectorRequests!;
                }
                return SizedBox();
              },
            ),
            LottieBuilder.asset(
              'images/society.json',
              fit: BoxFit.contain,
              height: 200,
              width: 200,
            ),
            SizedBox(height: 10),
            CustomTextField(
              controller: maxChatbotRequestsController,
              hintText: "maximum chatbot requests",
              prefixIcon: Icons.smart_toy,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            CustomTextField(
              controller: maxImageDetectorRequestsController,
              hintText: "maximum image detector requests",
              prefixIcon: Icons.photo,
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            BlocBuilder<DashboardCubit, DashboardState>(
              builder: (context, state) {
                return OutlinedButton.icon(
                  onPressed: () {
                    context.read<DashboardCubit>().sendLimitRequests(
                      maxChatbotRequests: int.parse(
                        maxChatbotRequestsController.text,
                      ),
                      maxImageDetectorRequests: int.parse(
                        maxImageDetectorRequestsController.text,
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "submitted successfully",
                          style: TextStyle(color: Colors.white),
                        ),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                        margin: EdgeInsets.only(
                          bottom: kBottomNavigationBarHeight + 16,
                          left: 16,
                          right: 16,
                        ),
                      ),
                    );
                  },
                  label: Text("submit"),
                  icon: Icon(Icons.send),
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(
                      Colors.deepOrange,
                    ),
                    foregroundColor: WidgetStateProperty.all<Color>(
                      Colors.white,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
