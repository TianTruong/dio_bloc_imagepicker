import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

part 'image_picker_event.dart';
part 'image_picker_state.dart';

class ImagePickerBloc extends Bloc<ImagePickerEvent, ImagePickerState> {

  ImagePickerBloc() : super(ImagePickerState()) {
    on<SelectImageEvent>(_onSelectCameraEvent);
  }

  Future<void> _onSelectCameraEvent(SelectImageEvent event, Emitter<ImagePickerState> emit) async {
    emit(state.copywith(images: event.images));
  }

}



