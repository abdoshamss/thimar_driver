part of'bloc.dart';
class GiveAdviceEvents{}
class PostGiveAdviceDataEvent extends GiveAdviceEvents{
  final BuildContext context;

  PostGiveAdviceDataEvent({required this.context});
}