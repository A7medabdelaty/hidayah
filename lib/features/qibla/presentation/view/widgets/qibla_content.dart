import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hidayah/features/qibla/presentation/cubit/qibla_cubit.dart';
import 'package:hidayah/features/qibla/presentation/view/widgets/qibla_compass.dart';

class QiblaContent extends StatelessWidget {
  const QiblaContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QiblaCubit, QiblaState>(
      builder: (context, state) {
        if (state is QiblaSuccessState) {
          return QiblaCompass(qiblaDirection: state.data.data.direction);
        } else if (state is QiblaErrorState) {
          return Center(child: Text('Error: ${state.errMessage}'));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
