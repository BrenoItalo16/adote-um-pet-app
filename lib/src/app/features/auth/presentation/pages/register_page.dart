import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/show_snack_bar.dart';
import '../../../../../routes.dart';
import '../bloc/auth_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  MaskedTextController numberController =
      MaskedTextController(mask: '(00) 00000-0000');
  MaskedTextController cepController = MaskedTextController(mask: '00000-000');
  final _addressController = TextEditingController();
  final _numberHouseController = TextEditingController();
  final _complementController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);
    final authBloc = GetIt.I.get<AuthBloc>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(17),
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Cadastro',
                  style: theme.textTheme.displaySmall,
                ),
                const Gap(29),
                TextInputDs(
                  label: 'nome',
                  controller: _nameController,
                  width: size.width,
                ),
                const Gap(25),
                TextInputDs(
                  label: 'e-mail',
                  controller: _emailController,
                  textInputType: TextInputType.emailAddress,
                  width: size.width,
                ),
                const Gap(25),
                TextInputDs(
                  width: size.width,
                  label: 'senha',
                  controller: _passwordController,
                  isPassword: true,
                ),
                const Gap(25),
                TextInputDs(
                  width: size.width,
                  label: 'confirmar senha',
                  controller: _confirmPasswordController,
                  isPassword: true,
                ),
                const Gap(25),
                TextInputDs(
                  label: 'telefone',
                  controller: numberController,
                  textInputType: TextInputType.number,
                  width: size.width,
                ),
                const Gap(25),
                TextInputDs(
                  label: 'cep',
                  controller: cepController,
                  textInputType: TextInputType.number,
                  width: size.width,
                ),
                const Gap(25),
                TextInputDs(
                  label: 'Endereço',
                  controller: _addressController,
                  textInputType: TextInputType.number,
                  width: size.width,
                ),
                const Gap(25),
                Row(
                  children: [
                    TextInputDs(
                      label: 'Número',
                      controller: _numberHouseController,
                      textInputType: TextInputType.number,
                      width: size.width * 0.3,
                    ),
                    const Gap(10),
                    Flexible(
                      child: TextInputDs(
                        label: 'Complemento',
                        controller: _complementController,
                        textInputType: TextInputType.number,
                        width: size.width * 0.59,
                      ),
                    ),
                  ],
                ),
                const Gap(40),
                Align(
                  alignment: Alignment.center,
                  child: BlocConsumer<AuthBloc, AuthState>(
                    listener: (context, state) {
                      if (state is SignUpAuthSuccess) {
                        showMessageSnackBar(
                          context,
                          state.data.message,
                          icon: Icons.check,
                          iconColor: AppColors.whiteColor,
                          color: AppColors.secondaryColor,
                        );
                        formKey.currentState!.reset();

                        router.go('/auth/welcome');
                      }
                      if (state is SignUpAuthFailure) {
                        showMessageSnackBar(
                          context,
                          state.message,
                          icon: Icons.error,
                          iconColor: AppColors.whiteColor,
                          color: AppColors.primaryColor,
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is SignUpAuthLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return PrimaryButtonDs(
                        title: 'Cadastrar',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            authBloc.add(
                              SignUpAuthEvent(
                                name: _nameController.text.trim(),
                                email: _emailController.text.trim(),
                                password: _passwordController.text.trim(),
                                phone: numberController.text.trim(),
                                zipCode: cepController.text.trim(),
                                address: _addressController.text.trim(),
                                numberHouse: int.parse(
                                    _numberHouseController.text.trim()),
                                complement: _complementController.text.trim(),
                              ),
                            );
                          }
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
