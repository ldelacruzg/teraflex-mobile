import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:teraflex_mobile/features/auth/infrastructure/datasources/isardb_login_local_storage_datasource.dart';
import 'package:teraflex_mobile/features/auth/infrastructure/repositories/login_local_storage_repository_impl.dart';
import 'package:teraflex_mobile/features/welcome_messages/domain/entities/welcome_message.dart';
import 'package:teraflex_mobile/features/welcome_messages/domain/mappers/welcome_message_mapper.dart';
import 'package:teraflex_mobile/shared/data/local_welcome_messages.dart';

class WelcomeMessagesScreen extends StatelessWidget {
  static const name = 'welcome_messages_screen';
  const WelcomeMessagesScreen({super.key});

  Future<bool> isAuthenticated() async {
    final repository = LoginLocalStorageRepositoryImpl(
        datasource: IsarDBLoginLocalStorageDatasource());
    return await repository.hasToken();
  }

  @override
  Widget build(BuildContext context) {
    isAuthenticated().then((value) {
      if (value) {
        context.go('/home');
      }
    });

    return const Scaffold(
      body: WelcomeMessageView(),
    );
  }
}

class WelcomeMessageView extends StatefulWidget {
  const WelcomeMessageView({
    super.key,
  });

  @override
  State<WelcomeMessageView> createState() => _WelcomeMessageViewState();
}

class _WelcomeMessageViewState extends State<WelcomeMessageView> {
  var indexActive = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Sliders
          Expanded(
            child: PageView.builder(
              itemCount: welcomeMessages.length,
              onPageChanged: (pageIndex) {
                setState(() {
                  indexActive = pageIndex;
                });
              },
              itemBuilder: (context, index) {
                final welcomeMessage = WelcomeMessageMapper.toEntityFromJson(
                    welcomeMessages[index]);
                return SlideItem(welcomeMessage: welcomeMessage);
              },
            ),
          ),

          // Buttoms Slider
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: DotsIndicator(
              count: welcomeMessages.length,
              positionActive: indexActive,
            ),
          ),

          // Button
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    context.push('/login');
                  },
                  child: const Text('INICIAR SESIÓN'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SlideItem extends StatelessWidget {
  const SlideItem({
    super.key,
    required this.welcomeMessage,
  });

  final WelcomeMessage welcomeMessage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Image
        Image.asset(
          welcomeMessage.image,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 20),

        // Message
        Center(
          child: Text(
            welcomeMessage.message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              height: 2,
            ),
          ),
        ),
      ],
    );
  }
}

class DotsIndicator extends StatelessWidget {
  final int count;
  final int positionActive;
  final double separator;

  const DotsIndicator({
    super.key,
    required this.count,
    this.separator = 25,
    this.positionActive = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < count; i++)
          Column(
            children: [
              PointIndicator(isActive: i == positionActive),
              SizedBox(width: separator),
            ],
          ),
      ],
    );
  }
}

class PointIndicator extends StatelessWidget {
  final bool isActive;

  const PointIndicator({
    super.key,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    final colorSchema = Theme.of(context).colorScheme;

    return Container(
      width: isActive ? 25 : 10, // Ancho del círculo
      height: 10, // Altura del círculo
      decoration: BoxDecoration(
        //shape: BoxShape.circle,
        borderRadius: BorderRadius.circular(5),
        color: isActive
            ? colorSchema.primary
            : colorSchema.onSurface.withOpacity(0.5),
      ),
    );
  }
}
