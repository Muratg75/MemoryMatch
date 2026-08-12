# Hafıza Eşleştirme Oyunu

Flutter Dart kullanarak geliştirilmiş hafıza eşleştirme oyunu.

## Özellikler

- **Kategori Seçimi**: Kelimeler, Meyveler, Hayvanlar kategorilerinden birini seçebilirsiniz
- **Zorluk Seviyeleri**: 
  - Kolay: 4 kart (2x2)
  - Orta: 6 kart (3x2) 
  - Zor: 8 kart (4x2)
  - Uzman: 12 kart (4x3)
- **Oyun Mekanikleri**:
  - 5 saniye kartları görme süresi
  - Her seferinde 2 kart açabilme
  - Eşleşen kartlar için puan kazanma
  - Hamle sayısı takibi

## Kurulum

1. Flutter SDK'nın yüklü olduğundan emin olun
2. Projeyi klonlayın
3. `flutter pub get` komutunu çalıştırın
4. Görselleri `assets/images/` klasörlerine ekleyin
5. `flutter run` ile uygulamayı başlatın

## Görsel Gereksinimleri

Her kategori için 200x200 piksel boyutunda PNG görselleri ekleyin:
- `assets/images/words/`: word1.png, word2.png, vb.
- `assets/images/fruits/`: apple.png, banana.png, vb.
- `assets/images/animals/`: cat.png, dog.png, vb.

## Oynanış

1. Ana menüden kategori ve zorluk seviyesi seçin
2. 5 saniye boyunca kartları hatırlayın
3. Kartları tıklayarak eşleştirin
4. Tüm kartları eşleştirerek oyunu tamamlayın

## Demo Sayfasında Tecrübe edebilirisiniz.

  https://muratg75.github.io/MemoryMatchDemo/

## Kodu browser da çalıştırmak için

-  flutter run -d chrome --web-port=8080

# Memory Matching Game

A memory matching game developed using Flutter Dart.

## Features

Category Selection: You can choose one of the following categories: Words, Fruits, Animals

-  Difficulty Levels:

-  Easy: 4 cards (2x2)

-  Medium: 6 cards (3x2)

-  Hard: 8 cards (4x2)

-  Expert: 12 cards (4x3)

## Game Mechanics:

-  5-second card preview time

-  You can flip 2 cards at a time

-  Earn points for matching cards

-  Move counter tracking

## Installation

-  Make sure Flutter SDK is installed

-  Clone the project

-  Run flutter pub get

-  Add images to the assets/images/ directories

-  Start the application with flutter run

## Image Requirements

-  Add 200x200 pixel PNG images for each category:

    assets/images/words/: word1.png, word2.png, etc.

    assets/images/fruits/: apple.png, banana.png, etc.

    assets/images/animals/: cat.png, dog.png, etc.

## Gameplay

-    Select a category and difficulty level from the main menu

-    Memorize the cards for 5 seconds

-    Match the cards by tapping on them

-    Complete the game by matching all cards

## You can try it on demo page

  https://muratg75.github.io/MemoryMatchDemo/
