<!--
markdownlint-disable MD012 MD029 MD032 MD007 MD058
-->

# kashly_app

A new Flutter project.

## Getting Started

Thiseproject is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Full Project Roadmap – Kashly App

1. **Visió General de l'App**

   Kashly és una app de finances personals que ofereix:

   - **Dashboard resum:** visualitza saldo total de tots els comptes agrupats per categoria (estalvi, crèdit, dèbit, inversió, compte de pagament, provisió, actiu, passiu).
   - **Gràfics evolutius:** tendències del saldo i del comportament dels comptes al llarg del temps.
   - **Widgets personalitzables:** pressupostos amb barra de progrés i saldo restant, percentatge de despeses per categoria, taxa d’estalvi.
   - **Gestió de transaccions:** historial amb filtres (per data, compte, categoria), afegir despeses, ingressos, transferències i recurrents.
   - **Pressupostos per categories:** barres de progrés i avisos.
   - **Comptes múltiples:** diferenciació de comptes bancaris i moneders.
   - **Objectius i informes:** creació d’objectius d’estalvi, estadístiques, comparacions i exportació d’informes (PDF/CSV).
   - **Sincronització:** moviments bancaris i plataformes d’inversió (Trading212, exchanges de cripto).
   - **Xat IA:** assessorament financer amb OpenAI.
   - **Multi-idioma:** ca, es, en i més per llançament internacional.
   - **Onboarding informatiu:** breu introducció a l’app.

2. **Arquitectura i Estructura de Carpetes**

   ```text
   kashly_app/
   ├── android/             # Configuració específica per Android (gradle, manifests)
   ├── ios/                 # Configuració específica per iOS (Xcode project, plist)
   ├── lib/                 # Codi Dart principal de l'aplicació
   │   ├── core/            # Components bàsics: constants, errors, utilitats genèriques
   │   ├── data/            # Fonts de dades i repositoris (API, Firebase, local)
   │   ├── domain/          # Lògica de negoci: models, casos d'ús (use cases)
   │   ├── presentation/    # Capa d'interfície: pàgines, widgets, blocs
   │   │   ├── features/    # Mòduls per funcionalitat (login, transaccions...)
   │   │   └── shared/      # Components i widgets reutilitzables globalment
   │   ├── l10n/            # Arxius .arb i recursos de localització
   │   └── main.dart        # Punt d'entrada de l'app i inicialització global
   ├── test/                # Proves unitàries i de widget (bloc_test, mocktail)
   ├── pubspec.yaml         # Declaració de dependències, assets i configuració Flutter
   └── README.md            # Documentació principal i roadmap

### 3. Tecnologies i Serveis

- Flutter & Dart: únic codi per iOS, Android, Web.
- VSCode: IDE principal amb extensions Flutter.
- Android Studio: per a emuladors i SDK manager.
- Git & GitHub: control de versions, backup automàtic.
- Firebase: Auth, Firestore, Storage, Crashlytics.
- CI/CD: GitHub Actions amb `flutter analyze`, `flutter test`.
- Mocktail & `bloc_test`: per proves consistents.
- `intl_utils`: generació de localitzacions.
- Figma: disseny de prototips.

### 4. Disseny Global & Interaccions

- Paleta de colors: `kPrimaryColor`, `kSecondaryColor`, `kAccentColor`.
- Tipografia: SF Pro Text / Roboto + jerarquia (Headline, Title, Body, Caption).
- Components: botons, camps de text, targetes, sparklines.
- Accessibilitat: contrast WCAG AA, alta-contrast mode.
- Micro-interaccions clau:
  - Animació del botó “+” desplegant menú flotant.
  - Transicions suaus entre pantalles d’onboarding.
  - Feedback visual en formularis (validacions).

### 5. Flux d'inici (Startup Flow)

En prémer la icona de Kashly, l’usuari experimentarà:

1. **Splash Screen (0–2 s)**
    - Logotip mentre s’inicialitza Flutter i Firebase.
    - Carregar localització i tema.
2. **Onboarding interactiu (3–4 pantalles deslitzables)**
    - Breu introducció a funcions clau, política, permisos.
    - Botó `Començar`.
3. **Questionari de personalització**
    - 3–5 preguntes curtes per adaptar l’experiència inicial.
4. **Flux d’autenticació**
    - Login/signup (email/password, socials).
    - Omissió si sessió vàlida.
5. **Dashboard Principal**
    - Resum comptes i widgets destacats.
    - Navegació inferior: Transaccions, Pressupostos, Comptes, Xat IA.

### 6. Mòdul d’Ajustaments

Inclou:

- Gestió d’idiomes (ca, es, en, altres).
- Configuracions de seguretat (2FA, Touch/FaceID).
- Preferències de notificacions.
- Canal de Feedback i Suport.

### 7. Estratègia de Proves i Qualitat

- Cobertura mínima:
  - Unit tests: ≥ 70%
  - Widget tests: ≥ 50%
  - Integració: 5-10 scans de flux
- Entorns: dev, staging, prod
- CI: `flutter analyze`, `flutter test --coverage`, `flutter_lints`

### 8. Rendiment i Optimització

- Perfils: `flutter run --profile`, DevTools
- Lazy loading: Auth/Firestore inicial, inversions/xat on demand
- Imatges: `flutter_image_compress`, assets webp

### 9. Accessibilitat i Internacionalització

- `.arb` a `lib/l10n` per a cada idioma
- Semàntica: `semanticsLabel`, ordre focus
- Formats locals: `NumberFormat.currency(locale)`, `DateFormat.yMMMd(locale)`

### 10. Seguretat i Privadesa

- Emmagatzematge segur: `flutter_secure_storage`
- Regles Firestore: deny-all → permisos progressius
- Autenticació: email/password, socials; planificació 2FA v2

### 11. Monitoratge i Analytics

- Crashlytics: `FlutterError.onError`
- Events: `sign_up`, `login`, `add_transaction`, `view_budget`, `sync_bank`
- Segmentació: idioma, país, tipus d’usuari

### 12. Mètriques d’Èxit (KPIs)

- Onboarding adoption: ≥ 80%
- DAU: Usuari actiu diari
- Transaccions/més usuari
- Retenció a 7 dies

### 13. Feedback de l’Usuari i Iteració

- Beta testers: Discord/Slack, TestFlight, Play Beta
- FeedbackForm: guardar respostes a `feedback/{uid}`
- Roadmap públic: GitHub Discussions + reaccions

### 14. Escalabilitat i Arquitectura Backend

- Firestore sizing: índexs per usuari+data, paginació
- Cloud Functions: notificacions nocturnes; informes agregats
- Migracions: scripts, backups abans de canvis
