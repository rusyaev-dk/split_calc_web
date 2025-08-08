class BalanceEntry {
  // >0 значит должен получить, <0 — должен заплатить
  const BalanceEntry(this.participantId, this.balance);
  final String participantId;
  final double balance;
}
