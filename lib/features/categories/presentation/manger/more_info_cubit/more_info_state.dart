part of 'more_info_cubit.dart';

@immutable
sealed class MoreInfoState {}

final class MoreInfoInitial extends MoreInfoState {}

class showbriefstate extends MoreInfoState {}

class showFullTextstate extends MoreInfoState {}
