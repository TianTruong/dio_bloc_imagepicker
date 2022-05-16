part of 'image_picker_bloc.dart';

@immutable
abstract class ImagePickerEvent {}

class SelectImageEvent extends ImagePickerEvent {
  final XFile images;

  SelectImageEvent(this.images);
}
