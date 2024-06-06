part of 'getcartitems_cubit.dart';

sealed class GetcartitemsState extends Equatable {
  const GetcartitemsState();

  @override
  List<Object> get props => [];
}

final class GetcartitemsInitial extends GetcartitemsState {}

class ProductLoading extends GetcartitemsState {}

class ProductFailure extends GetcartitemsState {
  final String errMessage;

  const ProductFailure(this.errMessage);
}

class ProductSuccess extends GetcartitemsState {
  final List<Usercart> cartitems_list;

  const ProductSuccess(this.cartitems_list);
}
