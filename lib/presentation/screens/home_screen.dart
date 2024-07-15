import 'package:bloc_flutterly/logic/cubit/counter_cubit.dart';
import 'package:bloc_flutterly/logic/cubit/counter_state.dart';
import 'package:bloc_flutterly/logic/cubit/internet_cubit.dart';
import 'package:bloc_flutterly/logic/cubit/internet_state.dart';
import 'package:bloc_flutterly/presentation/screens/second_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title, required this.color});

  final String title;
  final Color color;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
              style: TextStyle(fontSize: 20),
            ),
            BlocConsumer<CounterCubit, CounterState>(
              listener: (context, state) {
                if (state.wasIncremented == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Incremented'),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                } else if (state.wasIncremented == false) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Decremented'),
                      duration: Duration(milliseconds: 300),
                    ),
                  );
                }
              },
              builder: (context, state) {
                return Text(
                  state.counterValue.toString(),
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    context.read<CounterCubit>().decrement();
                    // BlockProvider.of<CounterCubit>().decrement();
                  },
                  child: const Icon(Icons.remove),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<CounterCubit>().increment();
                  },
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            MaterialButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (newContext) => BlocProvider.value(
                          //do not directly give CounterCubit() instance
                          value: BlocProvider.of<CounterCubit>(context),
                          child: SecondScreen(
                            title: 'Second Screen',
                            color: Colors.pinkAccent,
                          ),
                        )));
              },
              color: widget.color,
              child: Text('Go to the 2nd screen'),
            ),
          ],
        ),
      ),
    );
  }
}

// BlocListener and BlocBuilder separately (Above one is BlocConsumer - combines both);

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: BlocListener<CounterCubit, CounterState>(
//         listener: (context, state) {
//           if (state.wasIncremented == true) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text('Incremented'),
//                 duration: Duration(milliseconds: 300),
//               ),
//             );
//           } else if (state.wasIncremented == false) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(
//                 content: Text('Decremented'),
//                 duration: Duration(milliseconds: 300),
//               ),
//             );
//           }
//         },
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               const Text(
//                 'You have pushed the button this many times:',
//               ),
//               BlocBuilder<CounterCubit, CounterState>(
//                 builder: (context, state) {
//                   return Text(
//                     state.counterValue.toString(),
//                     style: Theme.of(context).textTheme.headlineMedium,
//                   );
//                 },
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   FloatingActionButton(
//                     onPressed: () {
//                       context.read<CounterCubit>().decrement();
//                       // BlockProvider.of<CounterCubit>().decrement();
//                     },
//                     tooltip: 'Decrement',
//                     child: const Icon(Icons.remove),
//                   ),
//                   FloatingActionButton(
//                     onPressed: () {
//                       context.read<CounterCubit>().increment();
//                     },
//                     tooltip: 'Increment',
//                     child: const Icon(Icons.add),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
