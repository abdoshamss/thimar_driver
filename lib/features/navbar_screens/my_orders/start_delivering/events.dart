part of'bloc.dart';

class StartDeliveringEvents {}

class StartDeliveringEvent extends StartDeliveringEvents {
  final int id;
  final BuildContext context;

  StartDeliveringEvent({required this.id, required this.context});
}