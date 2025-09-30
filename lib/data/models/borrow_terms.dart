class BorrowTerms {
  int lateFeeDays;
  int flatFeeMonths;
  int lateFeeCost;
  int flatFeeCost;
  bool dailyFeeEnabled;
  bool flatFeeEnabled;

  BorrowTerms({
    this.dailyFeeEnabled = false,
    this.flatFeeEnabled = false,
    this.lateFeeCost   = 0,
    this.flatFeeCost   = 0,
    this.lateFeeDays   = 0,
    this.flatFeeMonths = 0
  });

  factory BorrowTerms.fromMap(
    Map<String, dynamic>? data
  ) {
    if(data == null) { return BorrowTerms(); }
    return BorrowTerms(
      lateFeeDays: data["lateFeeDays"] is int ? data["lateFeeDays"] : 0,
      flatFeeMonths: data["flatFeeMonths"] is int ? data["flatFeeMonths"] : 0,
      lateFeeCost: data["lateFeeCost"] is int ? data["lateFeeCost"] : 0,
      flatFeeCost: data["flatFeeCost"] is int ? data["flatFeeCost"] : 0,
      dailyFeeEnabled: data["dailyFeeEnabled"] == true,
      flatFeeEnabled: data["flatFeeEnabled"] == true,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'lateFeeDays': lateFeeDays,
      'flatFeeMonths': flatFeeMonths,
      'lateFeeCost': lateFeeCost,
      'flatFeeCost': flatFeeCost,
      'dailyFeeEnabled':  dailyFeeEnabled,
      'flatFeeEnabled':  flatFeeEnabled,
    };
  }
}