

class JobShift {
    int id;
    int jobId;
    String shiftEndTime;
    int shiftQuantity;
    String shiftStartTime;
    int shiftValue;

    JobShift({this.id, this.jobId, this.shiftEndTime, this.shiftQuantity, this.shiftStartTime, this.shiftValue});

    factory JobShift.fromJson(Map<String, dynamic> json) {
        return JobShift(
            id: json['id'], 
            jobId: json['jobId'], 
            shiftEndTime: json['shiftEndTime'], 
            shiftQuantity: json['shiftQuantity'], 
            shiftStartTime: json['shiftStartTime'], 
            shiftValue: json['shiftValue'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['jobId'] = this.jobId;
        data['shiftEndTime'] = this.shiftEndTime;
        data['shiftQuantity'] = this.shiftQuantity;
        data['shiftStartTime'] = this.shiftStartTime;
        data['shiftValue'] = this.shiftValue;
        return data;
    }
    Map<String, dynamic> toJsonForSave() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['shiftEndTime'] = this.shiftEndTime;
        data['shiftQuantity'] = this.shiftQuantity;
        data['shiftStartTime'] = this.shiftStartTime;
        data['shiftValue'] = this.shiftValue;
        return data;
    }

}