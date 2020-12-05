import 'package:equatable/equatable.dart';

class CredentialsModel extends Equatable {
  final String email, password, phoneNum, name;
  final bool isCustomer;

  CredentialsModel(
      {this.phoneNum,
      this.name,
      this.email,
      this.password,
      this.isCustomer = true});

  @override
  List<Object> get props => [phoneNum, name, email, password, isCustomer];
}
