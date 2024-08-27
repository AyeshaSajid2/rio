// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';

// class ImageHelper {
//   final ImagePicker _imagePicker;
//   final ImageCropper _imageCropper;
//   ImageHelper({ImagePicker? imagePicker, ImageCropper? imageCropper})
//       : _imagePicker = imagePicker ?? ImagePicker(),
//         _imageCropper = imageCropper ?? ImageCropper();

//   Future<List<XFile>> pickImage({
//     ImageSource source = ImageSource.gallery,
//     int imageQuality = 100,
//     bool multiple = false,
//   }) async {
//     if (multiple) {
//       return await _imagePicker.pickMultiImage(
//         imageQuality: imageQuality,
//       );
//     }
//     final file = await _imagePicker.pickImage(
//       source: source,
//       imageQuality: imageQuality,
//       maxWidth: 400,
//       maxHeight: 400,
//       preferredCameraDevice: CameraDevice.front,
//       requestFullMetadata: false,
//     );
//     if (file != null) {
//       return [file];
//     }
//     return [];
//   }

//   Future<CroppedFile?> crop({
//     required XFile file,
//     CropStyle cropStyle = CropStyle.circle,
//   }) async {
//     return await _imageCropper.cropImage(
//       sourcePath: file.path,
//       cropStyle: cropStyle,
//       aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
//       aspectRatioPresets: const [
//         CropAspectRatioPreset.square,
//         CropAspectRatioPreset.original,
//         CropAspectRatioPreset.ratio3x2,
//         CropAspectRatioPreset.ratio4x3,
//         CropAspectRatioPreset.ratio16x9
//       ],
//       maxWidth: 400,
//       maxHeight: 400,
//       compressFormat: ImageCompressFormat.png,
//       compressQuality: 90,
//     );
//   }
// }
