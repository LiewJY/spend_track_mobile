part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}
class DisplayAllCategoryRequested extends CategoryEvent {
  const DisplayAllCategoryRequested();

  @override
  List<Object> get props => [];
}