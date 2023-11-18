part of 'rating_cubit.dart';

@immutable
abstract class RatingState {}

class RatingInitial extends RatingState {}

class SelectRatingState extends RatingState {}

class SendRatingLoadingState extends RatingState {}

class SendRatingSuccessState extends RatingState {}
