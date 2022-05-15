// part of 'imag_picker_bloc.dart';

// abstract class ImagPickerState extends Equatable {
//   final File? images;
//   ImagPickerState(this.images);

//   @override
//   List<Object> get props => [];
// }

// class ImagPickerInitial extends ImagPickerState {
//   ImagPickerInitial(File? images) : super(images);

//   @override
//   String toString() => 'ImagPickerInitial { images: $images }';
// }

// class SelectCameraState extends ImagPickerState {
//   SelectCameraState(File? images) : super(images);

//   @override
//   String toString() => 'SelectCameraState { images: $images }';
// }

// class SelectGalleryState extends ImagPickerState {
//   SelectGalleryState(File? images) : super(images);

//   @override
//   String toString() => 'SelectGalleryState { images: $images }';
// }


part of 'image_picker_bloc.dart';

@immutable
class ImagePickerState {
  final XFile? images;

  ImagePickerState({this.images});

  ImagePickerState copywith({XFile? images}) =>
      ImagePickerState(images: images ?? this.images);
}
