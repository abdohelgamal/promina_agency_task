abstract class GalleryImagesAbstractState {}

class GalleryImagesInitialState extends GalleryImagesAbstractState {}

class GalleryImagesLoadingState extends GalleryImagesAbstractState {}

class GalleryImagesLoadingFailState extends GalleryImagesAbstractState {
  final String message;

  GalleryImagesLoadingFailState(this.message);
}

class GalleryImagesLoadedState extends GalleryImagesAbstractState {}

class GalleryImagesUploadingState extends GalleryImagesAbstractState {}

class GalleryImagesUploadSuccessState extends GalleryImagesAbstractState {
  final String message;

  GalleryImagesUploadSuccessState(this.message);
}

class GalleryImagesUploadFailedState extends GalleryImagesAbstractState {
  final String message;

  GalleryImagesUploadFailedState(this.message);
}
