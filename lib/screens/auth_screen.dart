import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../state/current_user.dart';
import '../theme/app_theme.dart';

enum AuthMode { welcome, login, signup }

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, this.mode = AuthMode.welcome});

  final AuthMode mode;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (widget.mode == AuthMode.signup) {
      CurrentUser.update(
        firstName: _firstNameController.text,
        lastName: _lastNameController.text,
      );
    }
    context.go('/');
  }

  @override
  Widget build(BuildContext context) {
    final isWelcome = widget.mode == AuthMode.welcome;
    final isSignup = widget.mode == AuthMode.signup;
    final title = isWelcome
        ? 'Bienvenue dans votre\ncommunauté professionnelle'
        : isSignup
        ? 'Inscrivez-vous sur LinkedIn, c’est gratuit.'
        : 'Ravi de vous revoir';

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 18, 24, 28),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _Header(showActions: isWelcome),
                    const SizedBox(height: 52),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 32,
                        height: 1.15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.text,
                      ),
                    ),
                    const SizedBox(height: 34),
                    if (isWelcome) ...[
                      _GoogleButton(onPressed: () => context.go('/')),
                      const SizedBox(height: 14),
                      OutlinedButton(
                        onPressed: () => context.go('/login'),
                        child: const Text('S’identifier avec un e-mail'),
                      ),
                    ] else ...[
                      if (isSignup) ...[
                        _field(
                          controller: _firstNameController,
                          label: 'Prénom',
                          validator: (_) => null,
                        ),
                        const SizedBox(height: 16),
                        _field(
                          controller: _lastNameController,
                          label: 'Nom',
                          validator: (_) => null,
                        ),
                        const SizedBox(height: 16),
                      ],
                      _field(
                        controller: _emailController,
                        label: 'E-mail',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) =>
                            value != null && value.contains('@')
                            ? null
                            : 'Saisissez une adresse e-mail valide.',
                      ),
                      const SizedBox(height: 16),
                      _field(
                        controller: _passwordController,
                        label: 'Mot de passe',
                        obscureText: _obscurePassword,
                        suffixIcon: IconButton(
                          tooltip: _obscurePassword
                              ? 'Afficher le mot de passe'
                              : 'Masquer le mot de passe',
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          onPressed: () => setState(
                            () => _obscurePassword = !_obscurePassword,
                          ),
                        ),
                        validator: (value) => value != null && value.length >= 6
                            ? null
                            : 'Le mot de passe doit contenir 6 caractères.',
                      ),
                      if (!isSignup)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () => _showDemoMessage(
                              context,
                              'La réinitialisation du mot de passe est une fonctionnalité de démonstration.',
                            ),
                            child: const Text('Mot de passe oublié ?'),
                          ),
                        ),
                      const SizedBox(height: 10),
                      FilledButton(
                        onPressed: _submit,
                        child: Text(
                          isSignup ? 'Accepter et s’inscrire' : 'S’identifier',
                        ),
                      ),
                      const SizedBox(height: 16),
                      _GoogleButton(onPressed: () => context.go('/')),
                    ],
                    const SizedBox(height: 28),
                    const _LegalText(),
                    const SizedBox(height: 28),
                    _SwitchAuth(mode: widget.mode),
                    const SizedBox(height: 42),
                    const Text(
                      'Vous cherchez à créer une page pour une entreprise ?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: () => _showDemoMessage(
                        context,
                        'L’aide est indisponible dans cette maquette front-end.',
                      ),
                      child: const Text('Obtenir de l’aide'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _field({
    required TextEditingController controller,
    required String label,
    required String? Function(String?) validator,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
  }) => TextFormField(
    controller: controller,
    validator: validator,
    keyboardType: keyboardType,
    obscureText: obscureText,
    decoration: InputDecoration(
      labelText: label,
      suffixIcon: suffixIcon,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.mutedText),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.mutedText),
      ),
    ),
  );
}

void _showDemoMessage(BuildContext context, String message) =>
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));

class _Header extends StatelessWidget {
  const _Header({required this.showActions});
  final bool showActions;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final actions = [
        OutlinedButton(
          onPressed: () => context.go('/login'),
          child: const Text('S’identifier'),
        ),
        const SizedBox(width: 8),
        FilledButton(
          onPressed: () => context.go('/signup'),
          child: const Text('S’inscrire'),
        ),
      ];

      if (!showActions) return const _LinkedInLogo();
      if (constraints.maxWidth < 520) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const _LinkedInLogo(),
            const SizedBox(height: 12),
            Row(children: actions),
          ],
        );
      }
      return Row(children: [const _LinkedInLogo(), const Spacer(), ...actions]);
    },
  );
}

class _LinkedInLogo extends StatelessWidget {
  const _LinkedInLogo();
  @override
  Widget build(BuildContext context) => RichText(
    text: const TextSpan(
      style: TextStyle(
        color: AppColors.blue,
        fontSize: 27,
        fontWeight: FontWeight.w700,
      ),
      children: [
        TextSpan(text: 'Linked'),
        TextSpan(text: 'in'),
      ],
    ),
  );
}

class _GoogleButton extends StatelessWidget {
  const _GoogleButton({required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) => OutlinedButton.icon(
    onPressed: onPressed,
    icon: const Text(
      'G',
      style: TextStyle(
        color: Color(0xFF4285F4),
        fontSize: 23,
        fontWeight: FontWeight.w700,
      ),
    ),
    label: const Text('Continuer avec Google'),
  );
}

class _LegalText extends StatelessWidget {
  const _LegalText();
  @override
  Widget build(BuildContext context) => const Text(
    'En continuant, vous acceptez les Conditions d’utilisation, la Politique '
    'de confidentialité et la Politique relative aux cookies de LinkedIn.',
    textAlign: TextAlign.center,
    style: TextStyle(color: AppColors.mutedText, height: 1.35),
  );
}

class _SwitchAuth extends StatelessWidget {
  const _SwitchAuth({required this.mode});
  final AuthMode mode;
  @override
  Widget build(BuildContext context) {
    final login = mode == AuthMode.login;
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(login ? 'Nouveau sur LinkedIn ?' : 'Déjà inscrit(e) ?'),
        TextButton(
          onPressed: () => context.go(login ? '/signup' : '/login'),
          child: Text(login ? 'S’inscrire' : 'S’identifier'),
        ),
      ],
    );
  }
}
