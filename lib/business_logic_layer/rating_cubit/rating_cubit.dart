import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../components/constans.dart';
import '../../data_layer/network/dio_helper.dart';

part 'rating_state.dart';

class RatingCubit extends Cubit<RatingState> {
  RatingCubit() : super(RatingInitial());

  static RatingCubit get(context) => BlocProvider.of(context);

  var db = FirebaseFirestore.instance;

  List<int> selectedRatingsIndex = [];
  List<dynamic> selectedRatingsText = [];

  var notesController = TextEditingController();

  void selectRating({required int index, required String text}) {
    if (selectedRatingsIndex.contains(index)) {
      selectedRatingsIndex.remove(index);
      selectedRatingsText.remove(text);
    } else {
      selectedRatingsIndex.add(index);
      selectedRatingsText.add(text);
    }
    emit(SelectRatingState());
  }

  bool isRatingSelected(index) {
    return selectedRatingsIndex.contains(index);
  }

  Future<String?> isLastServiceRated() async {
    String? serviceDocId;
    await FirebaseFirestore.instance
        .collection('allServices')
        .orderBy('serviceTime', descending: true)
        .where('userUid', isEqualTo: myUid)
        .limit(1)
        .get()
        .then((value) {
      if (value.docs.isNotEmpty) {
        if (!value.docs.last.data()['isRated']||value.docs.last.data()['isRated']==null) {
          serviceDocId = value.docs[0].data()['docId'];
        } else {
          serviceDocId = null;
        }
      } else {
        serviceDocId = null;
      }
    });
    return serviceDocId;
  }

  Future<void> rateService({
    required String serviceDocId,
    required double rating,
    required String? ratingNotes,
    required String userName,
  }) async {
    emit(SendRatingLoadingState());
    await db.collection('allServices').doc(serviceDocId).update({
      'rating': rating,
      'ratingTexts': selectedRatingsText,
      'ratingNotes': ratingNotes,
      'isRated': true,
      'ratingTime': FieldValue.serverTimestamp(),
    });
    selectedRatingsText = [];
    selectedRatingsIndex = [];
    emit(SendRatingSuccessState());
    DioHelper.pushNotification(data: {
      'to': '/topics/admin',
      'notification': {
        "title": "تقييم جديد للخدمه من $userName  ",
        "body": '${rating.round()} نجوم ',
        "sound": "default",
      },
      'data': {
        "rating": 'rating',
        "click_action": "FLUTTER_NOTIFICATION_CLICK"
      },
    });
  }
}
