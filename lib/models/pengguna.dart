class Pengguna {
  final String nama;
  final String nik;
  final String email;
  final String noHp;
  final String gender;
  final String status;
  final String? fotoUrl;

  Pengguna({
    required this.nama,
    required this.nik,
    required this.email,
    required this.noHp,
    required this.gender,
    required this.status,
    this.fotoUrl,
  });
}
