import 'package:equatable/equatable.dart';
import '../model/customize_model.dart';

abstract class CustomizeState extends Equatable {}

class InitialState extends CustomizeState {
  @override
  List<Object> get props => [];
}

class LoadingState extends CustomizeState {
  @override
  List<Object> get props => [];
}

class LoadedState extends CustomizeState {
  LoadedState(this.customizeInfo);

  final CustomizeModel customizeInfo;

  @override
  List<Object> get props => [customizeInfo];
}

class ErrorState extends CustomizeState {
  @override
  List<Object> get props => [];
}
