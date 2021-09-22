import 'package:bloc/bloc.dart';
import "customize_state.dart";
import '../model/customize_model.dart';
import '../model/customize_repository.dart';

class CustomizeCubit extends Cubit<CustomizeState> {
  CustomizeCubit({required this.repository}) : super(InitialState()) {
    initializeParams();
  }

  final CustomizeRepository repository;

  void initializeParams() async {
    try {
      emit(LoadingState());
      final customizeInfo = await repository.getCustomizeInfo();
      emit(LoadedState(customizeInfo));
    } catch (e) {
      emit(ErrorState());
    }
  }

  void changeParams(CustomizeModel model) async {
    try {
      emit(LoadingState());
      repository.putCustomizeInfo(model);
      emit(LoadedState(model));
    } catch (e) {
      emit(ErrorState());
    }
  }
}
