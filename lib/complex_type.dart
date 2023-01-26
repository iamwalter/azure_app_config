abstract class ComplexType {
  ComplexType fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();
}

class PlannedMaintenance extends ComplexType {
  PlannedMaintenance(this.start, this.end);

  DateTime start;
  DateTime end;

  @override
  ComplexType fromJson(Map<String, dynamic> json) {
    return PlannedMaintenance(
      json["start"] as DateTime,
      json["end"] as DateTime,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'start': start.toIso8601String(),
      'end': end.toIso8601String(),
    };
  }
}
