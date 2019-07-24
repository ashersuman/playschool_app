class childModel{
  String firstName;
  String lastName;
  String nickName;
  String sex;
  String schoolName;
  var dateOfbirth;
  var adhaarNum;

  childModel(
      this.firstName,
      this.lastName,
      this.nickName,
      this.schoolName,
      this.sex,
      this.dateOfbirth,
      this.adhaarNum
      );

  childModel.fromJson();

  childModel.fromMap();
}