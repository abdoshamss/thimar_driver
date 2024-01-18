part of'bloc.dart';
class EditPasswordEvents{}
class PostEditPasswordDataEvent extends EditPasswordEvents{
  final BuildContext context;

  PostEditPasswordDataEvent({required this.context});

}