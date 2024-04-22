import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'more_info_state.dart';

class MoreInfoCubit extends Cubit<MoreInfoState> {
  MoreInfoCubit() : super(MoreInfoInitial());
  String? Text;
  bool? showView_more_Details;
  Future<void> viewmore({required text, required bool showmore}) async {
    if (text != null && text.length > 580 && !showmore) {
      Text = text.substring(0, 580);
      showView_more_Details = true;
      emit(showFullTextstate());
    } else {
      Text = text;
      showView_more_Details = false;
    }
    emit(showbriefstate());
  }
}
