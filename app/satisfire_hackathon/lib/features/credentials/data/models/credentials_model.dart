import 'package:equatable/equatable.dart';

class CredentialsModel extends Equatable {
  final String phoneNum, name;
  final bool isCustomer;

  CredentialsModel(
      {this.phoneNum,
      this.name,
      this.isCustomer = true});

  @override
  List<Object> get props => [phoneNum, name, isCustomer];
}
