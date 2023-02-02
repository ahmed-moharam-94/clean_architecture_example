
import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_app/application/error/failures.dart';


abstract class BaseUseCase<In, Out> {
  Future<Either<Failure, Out>> call(In inputs);
}