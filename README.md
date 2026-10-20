## Архітектура

Проєкт побудований за принципами Clean Architecture з трьома шарами. Залежності спрямовані в один бік: **presentation → domain ← data**. Шар `domain` не знає ні про Flutter, ні про Dio, ні про JSON.

### Потік даних

```
Screen → Bloc → UseCase → Repository (interface)
                              │
                     RepositoryImpl → ApiClient (Dio) → Server
```

### Обробка помилок

Мережеві помилки не передаються винятками. `ApiClient` і репозиторії повертають `Result<T>`:

```dart
sealed class Result<T> {}

final class Success<T> extends Result<T> {
  final T data;
}

final class Failure<T> extends Result<T> {
  final AppException error;
}
```

## Бібліотеки

### Залежності

| Бібліотека | Для чого |
|---|---|
| [`flutter_bloc`](https://pub.dev/packages/flutter_bloc) | Керування станом (Bloc) |
| [`bloc_concurrency`](https://pub.dev/packages/bloc_concurrency) | Трансформери подій: `restartable()`, `droppable()` |
| [`get_it`](https://pub.dev/packages/get_it) | Service locator |
| [`injectable`](https://pub.dev/packages/injectable) | Кодогенерація реєстрації залежностей для GetIt |
| [`auto_route`](https://pub.dev/packages/auto_route) | Типобезпечна навігація |
| [`freezed_annotation`](https://pub.dev/packages/freezed_annotation) | Анотації для стану, подій і DTO |
| [`json_annotation`](https://pub.dev/packages/json_annotation) | Анотації для JSON-серіалізації |
| [`dio`](https://pub.dev/packages/dio) | HTTP-клієнт |
| [`equatable`](https://pub.dev/packages/equatable) | Порівняння entity за значенням |
| [`collection`](https://pub.dev/packages/collection) | Допоміжні колекції (потрібна згенерованому коду роутера) |

### Dev-залежності

| Бібліотека | Для чого |
|---|---|
| [`build_runner`](https://pub.dev/packages/build_runner) | Запуск кодогенерації |
| [`freezed`](https://pub.dev/packages/freezed) | Генерація immutable-класів, `copyWith`, union-типів |
| [`json_serializable`](https://pub.dev/packages/json_serializable) | Генерація `fromJson` / `toJson` |
| [`injectable_generator`](https://pub.dev/packages/injectable_generator) | Генерація `injection.config.dart` |
| [`auto_route_generator`](https://pub.dev/packages/auto_route_generator) | Генерація маршрутів |
| [`flutter_lints`](https://pub.dev/packages/flutter_lints) | Правила статичного аналізу |
| `flutter_test` | Юніт-тести |

## Запуск

Після клонування репозиторію:

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```
