import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task/core/controllers/gallery_images/gallery_images_states.dart';
import 'package:task/data/controller_helpers/gallery_images_api_helper.dart';
import 'package:task/domain/models/gallery_image.dart';

class GalleryImagesCubit extends Cubit<GalleryImagesAbstractState> {
  GalleryImagesCubit() : super(GalleryImagesInitialState());
  List<GalleryImage> images = [];
  Future<void> getImages() async {
    emit(GalleryImagesLoadingState());
    await GalleryImagesApiHelper.getImages().then((response) {
      if (response.data['status'] == 'success') {
        List imagesLinks = response.data['data']['images'];
        images = imagesLinks.map((link) => GalleryImage(link)).toList();
        emit(GalleryImagesLoadedState());
      } else {
        emit(GalleryImagesLoadingFailState(response.data['message']));
      }
    });
  }

  Future<void> uploadImage(File image) async {
    emit(GalleryImagesUploadingState());
    await GalleryImagesApiHelper.uploadImage(image).then((response) {
      if (response.data['status'] == 'success') {
        emit(GalleryImagesUploadSuccessState(response.data['message']));
        getImages();
      } else {
        emit(GalleryImagesUploadFailedState(response.data['message']));
      }
    });
  }
}
