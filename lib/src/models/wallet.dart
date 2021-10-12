class Wallet {
  double topupAccount;
  double serviceAccount;

  Wallet({required this.topupAccount, required this.serviceAccount});

  factory Wallet.fromJson(dynamic json) {
    return Wallet(topupAccount:json['topup_account'] as double, 
    serviceAccount:json['service_account'] as double);
  }

  @override
  String toString() {
    return '{${this.topupAccount}, ${this.serviceAccount}}';
  }
}
