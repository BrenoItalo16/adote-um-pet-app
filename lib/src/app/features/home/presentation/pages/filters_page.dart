import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class FiltersPage extends StatelessWidget {
  const FiltersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                children: [
                  // const TextSpan(text: 'Bem-vindo(a), '),
                  TextSpan(
                    text: 'Bem-vindo(a),',
                    style: theme.textTheme.headlineSmall,
                  ),
                  TextSpan(
                    text: 'Mariana!',
                    style: theme.textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
            Text(
              'Encontre o seu amigo peludo.',
              style: theme.textTheme.labelSmall!
                  .copyWith(fontSize: 16), //!Sugerir alteração no tema
            ),
            const Gap(24),
            const ChoosePetTypeRow(
              label: 'Qual pet você gostaria de doar?',
            ),
            const Gap(24),
            const ChoosePetGenderRow(
              label: 'Qual o sexo?',
            ),
          ],
        ),
      ),
    );
  }
}
