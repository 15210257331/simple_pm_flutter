class ContactData {
  int id;
  int adminId;
  int headmasterId;
  String foreignName;
  String foreignPhone;
  String foreignEmail;
  int createTime;
  int updateTime;
  Null adminTalkId;
  String foreignTalkId;

  ContactData(
      {this.id,
        this.adminId,
        this.headmasterId,
        this.foreignName,
        this.foreignPhone,
        this.foreignEmail,
        this.createTime,
        this.updateTime,
        this.adminTalkId,
        this.foreignTalkId});

  ContactData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    adminId = json['adminId'];
    headmasterId = json['headmasterId'];
    foreignName = json['foreignName'];
    foreignPhone = json['foreignPhone'];
    foreignEmail = json['foreignEmail'];
    createTime = json['createTime'];
    updateTime = json['updateTime'];
    adminTalkId = json['adminTalkId'];
    foreignTalkId = json['foreignTalkId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['adminId'] = this.adminId;
    data['headmasterId'] = this.headmasterId;
    data['foreignName'] = this.foreignName;
    data['foreignPhone'] = this.foreignPhone;
    data['foreignEmail'] = this.foreignEmail;
    data['createTime'] = this.createTime;
    data['updateTime'] = this.updateTime;
    data['adminTalkId'] = this.adminTalkId;
    data['foreignTalkId'] = this.foreignTalkId;
    return data;
  }
}
