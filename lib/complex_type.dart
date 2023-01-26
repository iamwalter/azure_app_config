abstract class ComplexType {
  ComplexType fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}

class PlannedMaintenance extends ComplexType {
  PlannedMaintenance(this.start, this.end);

  String start;
  String end;

  @override
  ComplexType fromJson(Map<String, dynamic> json) {
    return PlannedMaintenance(
      json['start'] as String,
      json['end'] as String,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'start': start,
      'end': end,
    };
  }
}
