part of 'image_picker_bloc.dart';

@immutable
class ImagePickerState {
  final XFile? images;

  ImagePickerState({this.images});

  ImagePickerState copywith({XFile? images}) =>
      ImagePickerState(images: images ?? this.images);
}
