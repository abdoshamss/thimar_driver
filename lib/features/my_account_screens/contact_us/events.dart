part of'bloc.dart';

class ContactUsEvents {}

class GetContactUsDataEvent extends ContactUsEvents {}
class PostContactUsDataEvent extends ContactUsEvents {
  final BuildContext context;

  PostContactUsDataEvent({required this.context});
}