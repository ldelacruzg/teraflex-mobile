import 'package:teraflex_mobile/features/tasks/domain/entities/multimedia.dart';
import 'package:teraflex_mobile/features/tasks/infrastructure/models/tfx/multimedia_model.dart';

class MultimediaMapper {
  static List<Multimedia> fromTfxMultimedia(TfxMultimediaModel model) {
    return model.data
        .map((multimedia) => Multimedia(
              id: multimedia.id,
              title: multimedia.title,
              description: multimedia.description,
              url: multimedia.url,
              type: MultimediaType.values.firstWhere(
                  (e) => e.toString() == 'MultimediaType.${multimedia.type}'),
              status: multimedia.status,
              uploadedBy: multimedia.therapist,
            ))
        .toList();
  }
}
