import 'package:teraflex_mobile/features/auth/domain/entities/login_token.dart';
import 'package:teraflex_mobile/features/auth/infrastructure/models/tfx/tfx_login_model.dart';

class LoginTokenMapper {
  static LoginToken fromTfx(LoginTokenModel loginTokenModel) => LoginToken(
        token: loginTokenModel.data.token,
        role: loginTokenModel.data.role,
        firstTime: loginTokenModel.data.firstTime,
      );
}
