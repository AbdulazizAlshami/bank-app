
class MyTransaction {
  int id;
  double amount;
  String phone;

  MyTransaction({required this.id, required this.amount, required this.phone});

  factory MyTransaction.fromJson(Map<String,dynamic> map)=>MyTransaction(id: map["id"],amount: map["amount"],phone: map["phone"]);

  Map<String,dynamic> toMap()=>{
    "amount":amount,
    "phone":phone
};
}
