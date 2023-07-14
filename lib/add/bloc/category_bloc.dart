import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:track/repositories/models/category.dart';
import 'package:track/repositories/repos/category/category_repository.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;
  CategoryBloc({required this.categoryRepository})
      : super(CategoryState.initial()) {
    on<DisplayAllCategoryRequested>(_onDisplayAllCategoryRequested);
  }

  //actions
  _onDisplayAllCategoryRequested(
    DisplayAllCategoryRequested event,
    Emitter emit,
  ) async {
    if (state.status == CategoryStatus.loading) return;
    emit(state.copyWith(status: CategoryStatus.loading));
    try {
      List<SpendingCategory> categoryList =
          await categoryRepository.getCategories();
      emit(state.copyWith(
        status: CategoryStatus.success,
        success: 'loadedData',
        categoryList: categoryList,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: CategoryStatus.failure,
        error: e.toString(),
      ));
    }
  }
}
