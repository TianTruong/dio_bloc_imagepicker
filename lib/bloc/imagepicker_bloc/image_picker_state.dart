part of 'image_picker_bloc.dart';

@immutable
class ImagePickerState {
  final XFile? avatar;
  final XFile? image;
  final List<XFile>? lstImage;

  ImagePickerState({this.avatar, this.image, this.lstImage});

  ImagePickerState selectAvatar({XFile? avatar}) =>
      ImagePickerState(avatar: avatar ?? this.avatar);

  ImagePickerState selectImage({XFile? image}) =>
      ImagePickerState(image: image ?? this.image);

  ImagePickerState selectMultiImage({List<XFile>? lstImage}) =>
      ImagePickerState(lstImage: lstImage ?? this.lstImage);
}
