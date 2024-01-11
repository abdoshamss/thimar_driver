part of 'bloc.dart';
class PrivacyEvents{}

class GetPrivacyDataEvent extends PrivacyEvents{
  final int id ;

  GetPrivacyDataEvent({required this.id});
}