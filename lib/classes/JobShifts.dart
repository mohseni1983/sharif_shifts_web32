class JobShifts {
    List<JobShift> jobShift;
    int id;
    String jobDate;
    String registerStart;
    String registerEnd;
    String description;

    JobShifts(
        {this.jobShift,
            this.id,
            this.jobDate,
            this.registerStart,
            this.registerEnd,
            this.description});

    JobShifts.fromJson(Map<String, dynamic> json) {
        if (json['JobShift'] != null) {
            jobShift = new List<JobShift>();
            json['JobShift'].forEach((v) {
                jobShift.add(new JobShift.fromJson(v));
            });
        }
        id = json['id'];
        jobDate = json['JobDate'];
        registerStart = json['RegisterStart'];
        registerEnd = json['RegisterEnd'];
        description = json['Description'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.jobShift != null) {
            data['JobShift'] = this.jobShift.map((v) => v.toJson()).toList();
        }
        data['id'] = this.id;
        data['JobDate'] = this.jobDate;
        data['RegisterStart'] = this.registerStart;
        data['RegisterEnd'] = this.registerEnd;
        data['Description'] = this.description;
        return data;
    }
}

class JobShift {
    List<ShiftPersons> shiftPersons;
    int id;
    int jobId;
    String shiftStartTime;
    String shiftEndTime;
    int shiftQuantity;
    int shiftValue;
    bool deleted;

    JobShift(
        {this.shiftPersons,
            this.id,
            this.jobId,
            this.shiftStartTime,
            this.shiftEndTime,
            this.shiftQuantity,
            this.shiftValue,
        this.deleted
        });

    JobShift.fromJson(Map<String, dynamic> json) {
        if (json['ShiftPersons'] != null) {
            shiftPersons = new List<ShiftPersons>();
            json['ShiftPersons'].forEach((v) {
                shiftPersons.add(new ShiftPersons.fromJson(v));
            });
        }
        id = json['id'];
        jobId = json['JobId'];
        shiftStartTime = json['ShiftStartTime'];
        shiftEndTime = json['ShiftEndTime'];
        shiftQuantity = json['ShiftQuantity'];
        shiftValue = json['ShiftValue'];
        deleted=json['deleted'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.shiftPersons != null) {
            data['ShiftPersons'] = this.shiftPersons.map((v) => v.toJson()).toList();
        }
        data['id'] = this.id;
        data['JobId'] = this.jobId;
        data['ShiftStartTime'] = this.shiftStartTime;
        data['ShiftEndTime'] = this.shiftEndTime;
        data['ShiftQuantity'] = this.shiftQuantity;
        data['ShiftValue'] = this.shiftValue;
        data['deleted'] = this.deleted;
        return data;
    }
}

class ShiftPersons {
    int id;
    int shiftId;
    int madadkarId;
    String madadkarName;
    String enterTime;
    String exitTime;

    ShiftPersons(
        {this.id,
            this.shiftId,
            this.madadkarId,
            this.madadkarName,
            this.enterTime,
            this.exitTime});

    ShiftPersons.fromJson(Map<String, dynamic> json) {
        id = json['id'];
        shiftId = json['ShiftId'];
        madadkarId = json['MadadkarId'];
        madadkarName = json['MadadkarName'];
        enterTime = json['EnterTime'];
        exitTime = json['ExitTime'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['id'] = this.id;
        data['ShiftId'] = this.shiftId;
        data['MadadkarId'] = this.madadkarId;
        data['MadadkarName'] = this.madadkarName;
        data['EnterTime'] = this.enterTime;
        data['ExitTime'] = this.exitTime;
        return data;
    }
}
