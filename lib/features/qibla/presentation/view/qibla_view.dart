import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/qibla_cubit.dart';
import 'widgets/qibla_content.dart';

class QiblaView extends StatefulWidget {
  const QiblaView({super.key});

  @override
  State<QiblaView> createState() => _QiblaViewState();
}

class _QiblaViewState extends State<QiblaView> {
  @override
  void initState() {
    super.initState();
    context.read<QiblaCubit>().getQiblaDirection();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('qiblaDirection'.tr())),
      body: const QiblaContent(),
    );
  }
}
