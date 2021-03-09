class Members {
  String memberId, memberName, memberEmail,khatmaId;

  Members({
    this.memberId,
    this.memberName,
    this.memberEmail,
    this.khatmaId
  });

  Members.fromJson(Map<String,dynamic>maps){
    memberId = maps['memberId'];
    memberName = maps['memberName'];
    memberEmail = maps['memberEmail'];
    khatmaId = maps['khatmaId'];
  }

  toJson(){
    return {
      'memberId' : memberId,
      'memberName' : memberName,
      'memberEmail' : memberEmail,
      'khatmaId' : khatmaId
    };
  }

}
