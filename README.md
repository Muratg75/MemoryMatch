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


flutter run -d chrome --web-port=8080