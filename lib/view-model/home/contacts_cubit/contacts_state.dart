part of 'contacts_cubit.dart';

sealed class ContactsState {
  List<ContactsModel> contacts = [];
  ContactsState({required this.contacts});
}

final class ContactsInitial extends ContactsState {
  ContactsInitial() : super(contacts: []);
}
final class ContactsLoaded extends ContactsState {
  ContactsLoaded({required super.contacts});
}

