import 'dart:async';
import 'package:bloc_flutterly/logic/cubit/counter_state.dart';
import 'package:bloc_flutterly/logic/cubit/internet_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'internet_cubit.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState(counterValue: 0));
  void increment() {
    emit(CounterState(
        counterValue: state.counterValue + 1, wasIncremented: true));
  }

  void decrement() {
    emit(CounterState(
        counterValue: state.counterValue - 1, wasIncremented: false));
  }
}

// class CounterCubit extends Cubit<CounterState> {
//   final InternetCubit internetCubit; // field
//   late StreamSubscription internetStreamSubscription;
//
//   CounterCubit({required this.internetCubit})
//       : super(CounterState(counterValue: 0)) {
//     internetStreamSubscription = internetCubit.stream.listen((internetState) {
//       if (internetState is InternetConnected &&
//           internetState.connectionType == ConnectionType.Wifi) {
//         increment();
//       } else if (internetState is InternetConnected &&
//           internetState.connectionType == ConnectionType.Mobile) {
//         decrement();
//       }
//     });
//   }
//
//   void increment() {
//     emit(CounterState(
//         counterValue: state.counterValue + 1, wasIncremented: true));
//   }
//
//   void decrement() {
//     emit(CounterState(
//         counterValue: state.counterValue - 1, wasIncremented: false));
//   }
//
//   @override
//   Future<void> close() {
//     internetStreamSubscription.cancel();
//     return super.close();
//   }
// }
