// part of 'imag_picker_bloc.dart';

// abstract class ImagPickerEvent extends Equatable {
//   const ImagPickerEvent();

//   @override
//   List<Object> get props => [];
// }

// class SelectCameraEvent extends ImagPickerEvent {
  
// }

// class SelectGalleryEvent extends ImagPickerEvent {
  
// }

part of 'image_picker_bloc.dart';

@immutable
abstract class ImagePickerEvent {}

class SelectImageEvent extends ImagePickerEvent {
  final XFile images;

  SelectImageEvent(this.images);
}
