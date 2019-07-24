class parentModel {
  String firstName;
  String lastName;
  String email;
  var mobileNum;
  var adhaarNum;
  String adhaarEmail;
  var adhaarMobileNum;
  String relationship;

  parentModel(
      this.firstName,
      this.lastName,
      this.email,
      this.mobileNum,
      this.adhaarNum,
      this.adhaarEmail,
      this.adhaarMobileNum,
      this.relationship,
  );

  parentModel.fromJson();
}