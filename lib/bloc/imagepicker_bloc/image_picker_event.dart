part of 'image_picker_bloc.dart';

@immutable
abstract class ImagePickerEvent {}

class SelectAvatarEvent extends ImagePickerEvent {
  final ImageSource source;

  SelectAvatarEvent(this.source);
}
class SelectImageEvent extends ImagePickerEvent {
  final ImageSource source;

  SelectImageEvent(this.source);
}

class SelectMultiImageEvent extends ImagePickerEvent {
}