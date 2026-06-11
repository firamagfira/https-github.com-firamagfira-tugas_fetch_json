// import 'package:flutter_test/flutter_test.dart';

// // Fungsi utama dari asdos untuk menghitung diskon
// double hitungTotalHarga(double hargaAwal, double persenDiskon) {
//   return hargaAwal - (hargaAwal * persenDiskon / 100);
// }

// void main() {
//   test('Menguji fungsi diskon kasir kopi', () {
  
//     // 1. Mendeklarasikan variabel harga kopi 50000 dan diskon 10%
//     double hargaPesanan = 50000;
//     double diskonKopi = 10;

//     // 2. Memanggil fungsi dan menyimpan hasilnya ke variabel 'hasil'
//     double hasil = hitungTotalHarga(hargaPesanan, diskonKopi);

//     // 3. Memastikan hasil perhitungan sesuai matematika (45000)
//     expect(hasil, 45000);
    
//     // ----------------------------------------------------
//   });
// }
class Note {
  int? id;
  String title;
  String content;

  Note({
    this.id,
    required this.title,
    required this.content,
  });

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      content: map['content'],
    );
  }
}