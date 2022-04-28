import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poc_golde_2/golden_state.dart';

class GoldenCubit extends Cubit<GoldenState> {
  GoldenCubit() : super(GoldenInitialState());

  emitsOneState() {
    emit(GoldenOneState());
  }

  emitsSecondState() {
    emit(GoldenSecondState());
  }

  emitsThirdState() {
    emit(GoldenThirdState());
  }
}
