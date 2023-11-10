abstract class ChatStates {}

class ChatIntState extends ChatStates {}

class GetProfileLoadingState extends ChatStates {}

class GetProfileSuccessState extends ChatStates {}

class GetProfileErrorState extends ChatStates {}

class MessageImagePickedSuccessState extends ChatStates {}

class EditMessageImagePickedSuccessState extends ChatStates {}

class RemoveMessagePhoto extends ChatStates {}

class SendMessageLoadingState extends ChatStates {}

class SendMessageSuccessState extends ChatStates {}

class SelectMessageState extends ChatStates {}

class ReplyMessageState extends ChatStates {}

class DeleteMessageSuccessState extends ChatStates {}

class DeleteMessageLoadingState extends ChatStates {}

class DeleteMessageErrorState extends ChatStates {}

class RecordSuccessState extends ChatStates {}

class RecordLoadingState extends ChatStates {}

class ChatBackgroundImagePickedSuccessState extends ChatStates {}

class UploadChatBackgroundImageLoadingState extends ChatStates {}

class UploadChatBackgroundImageSuccessState extends ChatStates {}
