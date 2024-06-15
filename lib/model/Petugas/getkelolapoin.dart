class Poin {
    int id;
    int adminId;
    int jumlahPoin;
    int jumlahSaldo;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;

    Poin({
        required this.id,
        required this.adminId,
        required this.jumlahPoin,
        required this.jumlahSaldo,
        required this.createdAt,
        required this.updatedAt,
        required this.deletedAt,
    });

    factory Poin.fromJson(Map<String, dynamic> json) => Poin(
        id: json["id"],
        adminId: json["admin_id"],
        jumlahPoin: json["jumlah_poin"],
        jumlahSaldo: json["jumlah_saldo"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "admin_id": adminId,
        "jumlah_poin": jumlahPoin,
        "jumlah_saldo": jumlahSaldo,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "deleted_at": deletedAt,
    };
}
