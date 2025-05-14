part of 'account_cubit.dart';

sealed class AccountState {
  XFile? localImage;
  String? imageLink;
  AccountState({required this.localImage, required this.imageLink});
}

final class AccountInitial extends AccountState {
  AccountInitial():super(localImage: null, imageLink: null);
}
final class AccountUpadted extends AccountState {
  AccountUpadted({required super.localImage, required super.imageLink});
}
