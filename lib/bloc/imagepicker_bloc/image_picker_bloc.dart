import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {
  ImagePickerBloc() : super(ImagePickerState()) {
    on<SelectImageEvent>(_onSelectImageEvent);
    on<SelectMultiImageEvent>(_onSelectMultiImageEvent);
  }

  Future<void> _onSelectAvatarEvent(
      SelectImageEvent event, Emitter<ImagePickerState> emit) async {
    final ImagePicker _picker = ImagePicker();

    final XFile? avatar = await _picker.pickImage(source: event.source);

    emit(state.selectAvatar(avatar: avatar));
  }

  Future<void> _onSelectImageEvent(
      SelectImageEvent event, Emitter<ImagePickerState> emit) async {
    final ImagePicker _picker = ImagePicker();

    final XFile? image = await _picker.pickImage(source: event.source);

    emit(state.selectImage(image: image));
  }

  Future<void> _onSelectMultiImageEvent(
      SelectMultiImageEvent event, Emitter<ImagePickerState> emit) async {
    final ImagePicker _picker = ImagePicker();

    final List<XFile>? lstImage = await _picker.pickMultiImage();
    emit(state.selectMultiImage(lstImage: lstImage));
  }
}
