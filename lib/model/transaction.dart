// ignore_for_file: public_member_api_docs, sort_constructors_first


class FinancialTransaction {
  final int? id;
  final TransactionType type;
  final double amount;
  final String description;
  final DateTime date;
  final int isExpense;


  FinancialTransaction({
    this.id,
    required this.type,
    required this.amount,
    required this.description,
    required this.date,
    required this.isExpense,
  });

  Map<String, dynamic> toMap(){
    return {
      'id' : id,
      'description': description,
      'amount': amount,
      'date': date.toIso8601String(),
      'isExpense' : isExpense,
      'type': type.toString(),
    };
  }


  factory FinancialTransaction.fromMap(Map<String, dynamic> map) {
    return FinancialTransaction(
      id: map['id'] as int?,
      description: map['description'] as String,
      amount: map['amount'] as double,
      date: DateTime.parse(map['date'] as String),
      isExpense: map['isExpense'] as int,
      type: TransactionType.values.firstWhere(
        (e) => e.toString() == map['type'],
        orElse: () => TransactionType.expense,
      ),
    );
  }
}


enum TransactionType{ income, expense }
