part of 'image_picker_bloc.dart';

@immutable
class ImagePickerState {
  final XFile? image;
  final List<XFile>? lstImage;

  ImagePickerState({this.image, this.lstImage});

  ImagePickerState selectImage({XFile? image}) =>
      ImagePickerState(image: image ?? this.image);

  ImagePickerState selectMultiImage({List<XFile>? lstImage}) =>
      ImagePickerState(lstImage: lstImage ?? this.lstImage);
}
