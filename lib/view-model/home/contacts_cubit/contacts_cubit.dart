import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_visitor_admin/model/contacts/contacts_model.dart';
import 'package:my_visitor_admin/services/contacts/contacts.dart';

part 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  ContactsCubit() : super(ContactsInitial());
  ContactsAPI contactsAPI = ContactsAPI();
  List<ContactsModel> contacts = [];
  void getContacts() async {
    // Simulate loading contacts from a database or API
    contacts = await contactsAPI.getContacts();
    if (!isClosed) {
      emit(ContactsLoaded(contacts: contacts));
    }
  }
}
