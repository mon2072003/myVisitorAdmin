// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get enter_your_email {
    return Intl.message(
      'Enter your email',
      name: 'enter_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get enter_your_password {
    return Intl.message(
      'Enter your password',
      name: 'enter_your_password',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email`
  String get please_enter_your_email {
    return Intl.message(
      'Please enter your email',
      name: 'please_enter_your_email',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email`
  String get please_enter_a_valid_email {
    return Intl.message(
      'Please enter a valid email',
      name: 'please_enter_a_valid_email',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get please_enter_your_password {
    return Intl.message(
      'Please enter your password',
      name: 'please_enter_your_password',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgot_password {
    return Intl.message(
      'Forgot Password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Login failed`
  String get login_failed {
    return Intl.message(
      'Login failed',
      name: 'login_failed',
      desc: '',
      args: [],
    );
  }

  /// `Login successful`
  String get login_successful {
    return Intl.message(
      'Login successful',
      name: 'login_successful',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get change_password {
    return Intl.message(
      'Change Password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get reset_password {
    return Intl.message(
      'Reset Password',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Enter your new password`
  String get enter_your_new_password {
    return Intl.message(
      'Enter your new password',
      name: 'enter_your_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your new password`
  String get please_enter_your_new_password {
    return Intl.message(
      'Please enter your new password',
      name: 'please_enter_your_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters`
  String get password_must_be_at_least_6_characters {
    return Intl.message(
      'Password must be at least 6 characters',
      name: 'password_must_be_at_least_6_characters',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirm_password {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your new password`
  String get please_confirm_your_new_password {
    return Intl.message(
      'Please confirm your new password',
      name: 'please_confirm_your_new_password',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get passwords_do_not_match {
    return Intl.message(
      'Passwords do not match',
      name: 'passwords_do_not_match',
      desc: '',
      args: [],
    );
  }

  /// `Password changed successfully`
  String get password_changed_successfully {
    return Intl.message(
      'Password changed successfully',
      name: 'password_changed_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Support Team`
  String get support_team {
    return Intl.message(
      'Support Team',
      name: 'support_team',
      desc: '',
      args: [],
    );
  }

  /// `Typically replies within 5 minutes`
  String get Typically_replies_within_5_minutes {
    return Intl.message(
      'Typically replies within 5 minutes',
      name: 'Typically_replies_within_5_minutes',
      desc: '',
      args: [],
    );
  }

  /// `Chats`
  String get chats {
    return Intl.message(
      'Chats',
      name: 'chats',
      desc: '',
      args: [],
    );
  }

  /// `No contacts found`
  String get no_contacts_found {
    return Intl.message(
      'No contacts found',
      name: 'no_contacts_found',
      desc: '',
      args: [],
    );
  }

  /// `Send Message`
  String get send_message {
    return Intl.message(
      'Send Message',
      name: 'send_message',
      desc: '',
      args: [],
    );
  }

  /// `Booking Reservations`
  String get booking_reservations {
    return Intl.message(
      'Booking Reservations',
      name: 'booking_reservations',
      desc: '',
      args: [],
    );
  }

  /// `Send Notification`
  String get send_notification {
    return Intl.message(
      'Send Notification',
      name: 'send_notification',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get title {
    return Intl.message(
      'Title',
      name: 'title',
      desc: '',
      args: [],
    );
  }

  /// `Subtitle`
  String get subtitle {
    return Intl.message(
      'Subtitle',
      name: 'subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Send Done`
  String get send_done {
    return Intl.message(
      'Send Done',
      name: 'send_done',
      desc: '',
      args: [],
    );
  }

  /// `Please complete all fields`
  String get complete_fields {
    return Intl.message(
      'Please complete all fields',
      name: 'complete_fields',
      desc: '',
      args: [],
    );
  }

  /// `Set Darkness`
  String get set_darkeness {
    return Intl.message(
      'Set Darkness',
      name: 'set_darkeness',
      desc: '',
      args: [],
    );
  }

  /// `You can switch on and off the button`
  String get you_can_switch_on_and_off_the_button {
    return Intl.message(
      'You can switch on and off the button',
      name: 'you_can_switch_on_and_off_the_button',
      desc: '',
      args: [],
    );
  }

  /// `Choose Application Language`
  String get choose_application_language {
    return Intl.message(
      'Choose Application Language',
      name: 'choose_application_language',
      desc: '',
      args: [],
    );
  }

  /// `You can drop and choose from the menu`
  String get you_can_drop_and_choose_from_the_menu {
    return Intl.message(
      'You can drop and choose from the menu',
      name: 'you_can_drop_and_choose_from_the_menu',
      desc: '',
      args: [],
    );
  }

  /// `Admin`
  String get admin {
    return Intl.message(
      'Admin',
      name: 'admin',
      desc: '',
      args: [],
    );
  }

  /// `Support Chats`
  String get support_chats {
    return Intl.message(
      'Support Chats',
      name: 'support_chats',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Check In`
  String get check_in {
    return Intl.message(
      'Check In',
      name: 'check_in',
      desc: '',
      args: [],
    );
  }

  /// `Check Out`
  String get check_out {
    return Intl.message(
      'Check Out',
      name: 'check_out',
      desc: '',
      args: [],
    );
  }

  /// `Total Payment`
  String get total_payment {
    return Intl.message(
      'Total Payment',
      name: 'total_payment',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to leave the chat?`
  String get are_you_sure_you_want_to_leave_the_chat {
    return Intl.message(
      'Are you sure you want to leave the chat?',
      name: 'are_you_sure_you_want_to_leave_the_chat',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong`
  String get something_went_wrong {
    return Intl.message(
      'Something went wrong',
      name: 'something_went_wrong',
      desc: '',
      args: [],
    );
  }

  /// `Write a message`
  String get write_message {
    return Intl.message(
      'Write a message',
      name: 'write_message',
      desc: '',
      args: [],
    );
  }

  /// `View Profile`
  String get view_profile {
    return Intl.message(
      'View Profile',
      name: 'view_profile',
      desc: '',
      args: [],
    );
  }

  /// `About Us`
  String get about_us {
    return Intl.message(
      'About Us',
      name: 'about_us',
      desc: '',
      args: [],
    );
  }

  /// `View Details`
  String get view_details {
    return Intl.message(
      'View Details',
      name: 'view_details',
      desc: '',
      args: [],
    );
  }

  /// `Hotel Reservation Info`
  String get hotel_reservation_info {
    return Intl.message(
      'Hotel Reservation Info',
      name: 'hotel_reservation_info',
      desc: '',
      args: [],
    );
  }

  /// `Image not available`
  String get image_not_available {
    return Intl.message(
      'Image not available',
      name: 'image_not_available',
      desc: '',
      args: [],
    );
  }

  /// `Hotel Name`
  String get hotel_name {
    return Intl.message(
      'Hotel Name',
      name: 'hotel_name',
      desc: '',
      args: [],
    );
  }

  /// `Hotel Rating`
  String get hotel_rating {
    return Intl.message(
      'Hotel Rating',
      name: 'hotel_rating',
      desc: '',
      args: [],
    );
  }

  /// `Guests`
  String get guests {
    return Intl.message(
      'Guests',
      name: 'guests',
      desc: '',
      args: [],
    );
  }

  /// `Payment Info`
  String get payment_info {
    return Intl.message(
      'Payment Info',
      name: 'payment_info',
      desc: '',
      args: [],
    );
  }

  /// `Total Amount`
  String get total_amount {
    return Intl.message(
      'Total Amount',
      name: 'total_amount',
      desc: '',
      args: [],
    );
  }

  /// `Payment Status`
  String get payment_status {
    return Intl.message(
      'Payment Status',
      name: 'payment_status',
      desc: '',
      args: [],
    );
  }

  /// `Payment Successful`
  String get payment_successful {
    return Intl.message(
      'Payment Successful',
      name: 'payment_successful',
      desc: '',
      args: [],
    );
  }

  /// `Payment Failed`
  String get payment_failed {
    return Intl.message(
      'Payment Failed',
      name: 'payment_failed',
      desc: '',
      args: [],
    );
  }

  /// `Change Account Info`
  String get change_account_info {
    return Intl.message(
      'Change Account Info',
      name: 'change_account_info',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name`
  String get enter_your_name {
    return Intl.message(
      'Enter your name',
      name: 'enter_your_name',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your name`
  String get please_enter_your_name {
    return Intl.message(
      'Please enter your name',
      name: 'please_enter_your_name',
      desc: '',
      args: [],
    );
  }

  /// `Enter your phone number`
  String get enter_your_phone_number {
    return Intl.message(
      'Enter your phone number',
      name: 'enter_your_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your phone number`
  String get please_enter_your_phone_number {
    return Intl.message(
      'Please enter your phone number',
      name: 'please_enter_your_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid phone number`
  String get please_enter_a_valid_phone_number {
    return Intl.message(
      'Please enter a valid phone number',
      name: 'please_enter_a_valid_phone_number',
      desc: '',
      args: [],
    );
  }

  /// `Update Info`
  String get update_info {
    return Intl.message(
      'Update Info',
      name: 'update_info',
      desc: '',
      args: [],
    );
  }

  /// `Select Image`
  String get select_image {
    return Intl.message(
      'Select Image',
      name: 'select_image',
      desc: '',
      args: [],
    );
  }

  /// `Account info updated successfully`
  String get account_info_updated_successfully {
    return Intl.message(
      'Account info updated successfully',
      name: 'account_info_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `You are not admin`
  String get you_are_not_admin {
    return Intl.message(
      'You are not admin',
      name: 'you_are_not_admin',
      desc: '',
      args: [],
    );
  }

  /// `Rooms`
  String get rooms {
    return Intl.message(
      'Rooms',
      name: 'rooms',
      desc: '',
      args: [],
    );
  }

  /// `City Details`
  String get city_details {
    return Intl.message(
      'City Details',
      name: 'city_details',
      desc: '',
      args: [],
    );
  }

  /// `Tourist Places`
  String get tourist_places {
    return Intl.message(
      'Tourist Places',
      name: 'tourist_places',
      desc: '',
      args: [],
    );
  }

  /// `Place name updated successfully`
  String get place_name_updated_successfully {
    return Intl.message(
      'Place name updated successfully',
      name: 'place_name_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Place description updated successfully`
  String get place_description_updated_successfully {
    return Intl.message(
      'Place description updated successfully',
      name: 'place_description_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Tourist place added successfully`
  String get tourist_place_added_successfully {
    return Intl.message(
      'Tourist place added successfully',
      name: 'tourist_place_added_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Activities`
  String get activities {
    return Intl.message(
      'Activities',
      name: 'activities',
      desc: '',
      args: [],
    );
  }

  /// `No activities found`
  String get no_activities_available {
    return Intl.message(
      'No activities found',
      name: 'no_activities_available',
      desc: '',
      args: [],
    );
  }

  /// `Unknown activity`
  String get unKnown_activity {
    return Intl.message(
      'Unknown activity',
      name: 'unKnown_activity',
      desc: '',
      args: [],
    );
  }

  /// `No description available`
  String get no_description_available {
    return Intl.message(
      'No description available',
      name: 'no_description_available',
      desc: '',
      args: [],
    );
  }

  /// `Tourist place deleted successfully`
  String get tourist_place_deleted_successfully {
    return Intl.message(
      'Tourist place deleted successfully',
      name: 'tourist_place_deleted_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Add a new city`
  String get add_a_new_city {
    return Intl.message(
      'Add a new city',
      name: 'add_a_new_city',
      desc: '',
      args: [],
    );
  }

  /// `Enter city name`
  String get enter_city_name {
    return Intl.message(
      'Enter city name',
      name: 'enter_city_name',
      desc: '',
      args: [],
    );
  }

  /// `Enter city description`
  String get enter_city_description {
    return Intl.message(
      'Enter city description',
      name: 'enter_city_description',
      desc: '',
      args: [],
    );
  }

  /// `Please enter city name`
  String get please_enter_city_name {
    return Intl.message(
      'Please enter city name',
      name: 'please_enter_city_name',
      desc: '',
      args: [],
    );
  }

  /// `Please enter city description`
  String get please_enter_city_description {
    return Intl.message(
      'Please enter city description',
      name: 'please_enter_city_description',
      desc: '',
      args: [],
    );
  }

  /// `City added successfully`
  String get city_added_successfully {
    return Intl.message(
      'City added successfully',
      name: 'city_added_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Delete City`
  String get delete_city {
    return Intl.message(
      'Delete City',
      name: 'delete_city',
      desc: '',
      args: [],
    );
  }

  /// `Activity Details`
  String get activity_details {
    return Intl.message(
      'Activity Details',
      name: 'activity_details',
      desc: '',
      args: [],
    );
  }

  /// `No activities found`
  String get no_activities_found {
    return Intl.message(
      'No activities found',
      name: 'no_activities_found',
      desc: '',
      args: [],
    );
  }

  /// `No title available`
  String get no_title_available {
    return Intl.message(
      'No title available',
      name: 'no_title_available',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
      desc: '',
      args: [],
    );
  }

  /// `Title updated successfully`
  String get title_updated_successfully {
    return Intl.message(
      'Title updated successfully',
      name: 'title_updated_successfully',
      desc: '',
      args: [],
    );
  }

  /// `Add New Activity`
  String get add_new_activity {
    return Intl.message(
      'Add New Activity',
      name: 'add_new_activity',
      desc: '',
      args: [],
    );
  }

  /// `Enter activity name`
  String get enter_activity_name {
    return Intl.message(
      'Enter activity name',
      name: 'enter_activity_name',
      desc: '',
      args: [],
    );
  }

  /// `Enter activity description`
  String get enter_activity_description {
    return Intl.message(
      'Enter activity description',
      name: 'enter_activity_description',
      desc: '',
      args: [],
    );
  }

  /// `Please enter activity name`
  String get please_enter_activity_name {
    return Intl.message(
      'Please enter activity name',
      name: 'please_enter_activity_name',
      desc: '',
      args: [],
    );
  }

  /// `Please enter activity description`
  String get please_enter_activity_description {
    return Intl.message(
      'Please enter activity description',
      name: 'please_enter_activity_description',
      desc: '',
      args: [],
    );
  }

  /// `Activity added successfully`
  String get activity_added_successfully {
    return Intl.message(
      'Activity added successfully',
      name: 'activity_added_successfully',
      desc: '',
      args: [],
    );
  }

  /// `This field is required`
  String get field_required {
    return Intl.message(
      'This field is required',
      name: 'field_required',
      desc: '',
      args: [],
    );
  }

  /// `Image URL`
  String get image_url {
    return Intl.message(
      'Image URL',
      name: 'image_url',
      desc: '',
      args: [],
    );
  }

  /// `Add Image URL`
  String get add_image_url {
    return Intl.message(
      'Add Image URL',
      name: 'add_image_url',
      desc: '',
      args: [],
    );
  }

  /// `Latitude`
  String get latitude {
    return Intl.message(
      'Latitude',
      name: 'latitude',
      desc: '',
      args: [],
    );
  }

  /// `Longitude`
  String get longitude {
    return Intl.message(
      'Longitude',
      name: 'longitude',
      desc: '',
      args: [],
    );
  }

  /// `Invalid latitude`
  String get invalid_latitude {
    return Intl.message(
      'Invalid latitude',
      name: 'invalid_latitude',
      desc: '',
      args: [],
    );
  }

  /// `Invalid longitude`
  String get invalid_longitude {
    return Intl.message(
      'Invalid longitude',
      name: 'invalid_longitude',
      desc: '',
      args: [],
    );
  }

  /// `Delete Activity`
  String get delete_activity {
    return Intl.message(
      'Delete Activity',
      name: 'delete_activity',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this activity?`
  String get are_you_sure_you_want_to_delete_this_activity {
    return Intl.message(
      'Are you sure you want to delete this activity?',
      name: 'are_you_sure_you_want_to_delete_this_activity',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Activity deleted successfully`
  String get activity_deleted_successfully {
    return Intl.message(
      'Activity deleted successfully',
      name: 'activity_deleted_successfully',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
