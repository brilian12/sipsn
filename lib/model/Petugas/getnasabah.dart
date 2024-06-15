class Nasabahp {
    int id;
    int userId;
    String name;
    String alamat;
    String noHp;
    String kodePengguna;
    DateTime createdAt;
    DateTime updatedAt;
    

    Nasabahp({
        required this.id,
        required this.userId,
        required this.name,
        required this.alamat,
        required this.noHp,
        required this.kodePengguna,
        required this.createdAt,
        required this.updatedAt,
    });

    factory Nasabahp.fromJson(Map<String, dynamic> json) => Nasabahp(
        id: json["id"],
        userId: json["user_id"],
        name: json["name"],
        alamat: json["alamat"],
        noHp: json["no_hp"],
        kodePengguna: json["kode_pengguna"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "name": name,
        "alamat": alamat,
        "no_hp": noHp,
        "kode_pengguna": kodePengguna,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}
