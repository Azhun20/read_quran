import 'generator_helper.dart';

class GeneratorModuleData {
  // DOMAIN
  static String entity({required String nameFeature}) {
    return """
import 'package:equatable/equatable.dart';

/// Domain entity untuk $nameFeature.
/// Tambahkan atribut sesuai kebutuhan implementasi.
class ${nameFeature}Entity extends Equatable {
  const ${nameFeature}Entity();

  @override
  List<Object?> get props => [];
}
""";
  }

  static String repositoryInterface({required String nameFeature}) {
    final snake = DataConverter.camelCaseToSnakeCase(nameFeature);
    return """
import '../entities/${snake}_entity.dart';

/// Abstraksi repository untuk mengelola $nameFeature.
/// Definisikan method yang diperlukan saat implementasi.
abstract class ${nameFeature}Repository {}
""";
  }

  // USECASES
  static String usecaseGetList({required String nameFeature}) {
    final snake = DataConverter.camelCaseToSnakeCase(nameFeature);
    return """
import '../repositories/${snake}_repository.dart';

/// Use case template untuk mengambil data $nameFeature.
/// Implementasikan logika bisnis sesuai kebutuhan.
class Get${nameFeature}ListUseCase {
  Get${nameFeature}ListUseCase(this._repository);

  final ${nameFeature}Repository _repository;

  Future<void> call() async {
    // TODO: panggil method repository dan olah hasilnya.
  }
}
""";
  }

  // DATA
  static String dataSource({required String nameFeature}) {
    return """
import '../../../../utils/services/api_service.dart';

/// Data source bertanggung jawab terhadap pemanggilan API $nameFeature.
/// Tambahkan method sesuai kebutuhan dan gunakan ApiService.
class ${nameFeature}RemoteDataSource {
  ${nameFeature}RemoteDataSource(this._apiService);

  final ApiService _apiService;
}
""";
  }

  static String repositoryImpl({required String nameFeature}) {
    final snake = DataConverter.camelCaseToSnakeCase(nameFeature);
    return """
import '../../domain/repositories/${snake}_repository.dart';
import '../datasources/${snake}_remote_datasource.dart';

/// Implementasi repository untuk $nameFeature.
/// Hubungkan data source dengan layer domain di dalam kelas ini.
class ${nameFeature}RepositoryImpl implements ${nameFeature}Repository {
  ${nameFeature}RepositoryImpl(this._remoteDataSource);

  final ${nameFeature}RemoteDataSource _remoteDataSource;
}
""";
  }

  // PRESENTATION - Cubit
  static String cubit({required String nameFeature}) {
    final snake = DataConverter.camelCaseToSnakeCase(nameFeature);
    return """
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/usecases/get_${snake}_list_usecase.dart';

part '${snake}_state.dart';
part '${snake}_cubit.freezed.dart';

class ${nameFeature}Cubit extends Cubit<${nameFeature}State> {
  ${nameFeature}Cubit(this._get${nameFeature}ListUseCase)
      : super(const ${nameFeature}State());

  final Get${nameFeature}ListUseCase _get${nameFeature}ListUseCase;

  void increment() {
    emit(state.copyWith(value: state.value + 1));
  }
}
""";
  }

  static String cubitState({required String nameFeature}) {
    final snake = DataConverter.camelCaseToSnakeCase(nameFeature);
    return """
part of '${snake}_cubit.dart';

@freezed
abstract class ${nameFeature}State with _\$${nameFeature}State {
  const factory ${nameFeature}State({
    @Default(false) bool isLoading,
    String? errorMessage,
    @Default(0) int value,
  }) = _${nameFeature}State;
}
""";
  }

  static String di({required String nameFeature}) {
    final snake = DataConverter.camelCaseToSnakeCase(nameFeature);
    return """
import '../../../core/di/service_locator.dart';
import '../../../utils/services/api_service.dart';
import '../data/datasources/${snake}_remote_datasource.dart';
import '../data/repositories/${snake}_repository_impl.dart';
import '../domain/repositories/${snake}_repository.dart';
import '../domain/usecases/get_${snake}_list_usecase.dart';
import '../presentation/cubit/${snake}_cubit.dart';

class ${nameFeature}DI {
  static void inject() {
    if (sl.isRegistered<${nameFeature}Repository>()) return;

    sl
      ..registerLazySingleton<${nameFeature}RemoteDataSource>(
        () => ${nameFeature}RemoteDataSource(sl<ApiService>()),
      )
      ..registerLazySingleton<${nameFeature}Repository>(
        () => ${nameFeature}RepositoryImpl(sl<${nameFeature}RemoteDataSource>()),
      )
      ..registerLazySingleton<Get${nameFeature}ListUseCase>(
        () => Get${nameFeature}ListUseCase(sl<${nameFeature}Repository>()),
      )
      ..registerFactory<${nameFeature}Cubit>(
        () => ${nameFeature}Cubit(sl<Get${nameFeature}ListUseCase>()),
      );
  }
}
""";
  }

  static String page({required String nameFeature}) {
    final snake = DataConverter.camelCaseToSnakeCase(nameFeature);
    return """
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/${snake}_cubit.dart';

class ${nameFeature}Page extends StatelessWidget {
  const ${nameFeature}Page({super.key});

  static const String routeName = '$snake';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('$nameFeature'),
      ),
      body: BlocBuilder<${nameFeature}Cubit, ${nameFeature}State>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.errorMessage != null) {
            return Center(child: Text(state.errorMessage!));
          }

          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Value: \${state.value}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.read<${nameFeature}Cubit>().increment(),
                  child: const Text('Increment'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
""";
  }
}
