import 'package:teraflex_mobile/features/auth/domain/entities/user/user.dart';
import 'package:teraflex_mobile/features/auth/infrastructure/models/tfx/tfx_user_model.dart';

class UserMapper {
  static User fromTfxUser(TfxUserModel user) => User(
        id: user.data.id,
        firstName: user.data.firstName,
        lastName: user.data.lastName,
        docNumber: user.data.docNumber,
        phone: user.data.phone,
        description: user.data.description,
        status: user.data.status,
      );
}
