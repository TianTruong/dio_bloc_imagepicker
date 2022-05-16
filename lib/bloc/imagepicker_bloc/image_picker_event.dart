part of 'image_picker_bloc.dart';

@immutable
abstract class ImagePickerEvent {}

class SelectImageEvent extends ImagePickerEvent {
  final ImageSource source;

  SelectImageEvent(this.source);
}

class SelectMultiImageEvent extends ImagePickerEvent {
}