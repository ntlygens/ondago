class DohModel {
  String? _camis;
  String? _dba;
  String? _boro;
  String? _building;
  String? _street;
  String? _zipcode;
  String? _phone;
  String? _cuisineDescription;
  String? _inspectionDate;
  String? _action;
  String? _violationCode;
  String? _violationDescription;
  String? _criticalFlag;
  String? _score;
  String? _grade;
  String? _gradeDate;
  String? _recordDate;
  String? _inspectionType;
  String? _latitude;
  String? _longitude;
  String? _communityBoard;
  String? _councilDistrict;
  String? _censusTract;
  String? _bin;
  String? _bbl;
  String? _nta;

  DohModel(
      {String? camis,
        String? dba,
        String? boro,
        String? building,
        String? street,
        String? zipcode,
        String? phone,
        String? cuisineDescription,
        String? inspectionDate,
        String? action,
        String? violationCode,
        String? violationDescription,
        String? criticalFlag,
        String? score,
        String? grade,
        String? gradeDate,
        String? recordDate,
        String? inspectionType,
        String? latitude,
        String? longitude,
        String? communityBoard,
        String? councilDistrict,
        String? censusTract,
        String? bin,
        String? bbl,
        String? nta}) {
    if (camis != null) {
      this._camis = camis;
    }
    if (dba != null) {
      this._dba = dba;
    }
    if (boro != null) {
      this._boro = boro;
    }
    if (building != null) {
      this._building = building;
    }
    if (street != null) {
      this._street = street;
    }
    if (zipcode != null) {
      this._zipcode = zipcode;
    }
    if (phone != null) {
      this._phone = phone;
    }
    if (cuisineDescription != null) {
      this._cuisineDescription = cuisineDescription;
    }
    if (inspectionDate != null) {
      this._inspectionDate = inspectionDate;
    }
    if (action != null) {
      this._action = action;
    }
    if (violationCode != null) {
      this._violationCode = violationCode;
    }
    if (violationDescription != null) {
      this._violationDescription = violationDescription;
    }
    if (criticalFlag != null) {
      this._criticalFlag = criticalFlag;
    }
    if (score != null) {
      this._score = score;
    }
    if (grade != null) {
      this._grade = grade;
    }
    if (gradeDate != null) {
      this._gradeDate = gradeDate;
    }
    if (recordDate != null) {
      this._recordDate = recordDate;
    }
    if (inspectionType != null) {
      this._inspectionType = inspectionType;
    }
    if (latitude != null) {
      this._latitude = latitude;
    }
    if (longitude != null) {
      this._longitude = longitude;
    }
    if (communityBoard != null) {
      this._communityBoard = communityBoard;
    }
    if (councilDistrict != null) {
      this._councilDistrict = councilDistrict;
    }
    if (censusTract != null) {
      this._censusTract = censusTract;
    }
    if (bin != null) {
      this._bin = bin;
    }
    if (bbl != null) {
      this._bbl = bbl;
    }
    if (nta != null) {
      this._nta = nta;
    }
  }

  String? get camis => _camis;
  set camis(String? camis) => _camis = camis;
  String? get dba => _dba;
  set dba(String? dba) => _dba = dba;
  String? get boro => _boro;
  set boro(String? boro) => _boro = boro;
  String? get building => _building;
  set building(String? building) => _building = building;
  String? get street => _street;
  set street(String? street) => _street = street;
  String? get zipcode => _zipcode;
  set zipcode(String? zipcode) => _zipcode = zipcode;
  String? get phone => _phone;
  set phone(String? phone) => _phone = phone;
  String? get cuisineDescription => _cuisineDescription;
  set cuisineDescription(String? cuisineDescription) =>
      _cuisineDescription = cuisineDescription;
  String? get inspectionDate => _inspectionDate;
  set inspectionDate(String? inspectionDate) =>
      _inspectionDate = inspectionDate;
  String? get action => _action;
  set action(String? action) => _action = action;
  String? get violationCode => _violationCode;
  set violationCode(String? violationCode) => _violationCode = violationCode;
  String? get violationDescription => _violationDescription;
  set violationDescription(String? violationDescription) =>
      _violationDescription = violationDescription;
  String? get criticalFlag => _criticalFlag;
  set criticalFlag(String? criticalFlag) => _criticalFlag = criticalFlag;
  String? get score => _score;
  set score(String? score) => _score = score;
  String? get grade => _grade;
  set grade(String? grade) => _grade = grade;
  String? get gradeDate => _gradeDate;
  set gradeDate(String? gradeDate) => _gradeDate = gradeDate;
  String? get recordDate => _recordDate;
  set recordDate(String? recordDate) => _recordDate = recordDate;
  String? get inspectionType => _inspectionType;
  set inspectionType(String? inspectionType) =>
      _inspectionType = inspectionType;
  String? get latitude => _latitude;
  set latitude(String? latitude) => _latitude = latitude;
  String? get longitude => _longitude;
  set longitude(String? longitude) => _longitude = longitude;
  String? get communityBoard => _communityBoard;
  set communityBoard(String? communityBoard) =>
      _communityBoard = communityBoard;
  String? get councilDistrict => _councilDistrict;
  set councilDistrict(String? councilDistrict) =>
      _councilDistrict = councilDistrict;
  String? get censusTract => _censusTract;
  set censusTract(String? censusTract) => _censusTract = censusTract;
  String? get bin => _bin;
  set bin(String? bin) => _bin = bin;
  String? get bbl => _bbl;
  set bbl(String? bbl) => _bbl = bbl;
  String? get nta => _nta;
  set nta(String? nta) => _nta = nta;

  DohModel.fromJson(Map<String, dynamic> json) {
    _camis = json['camis'];
    _dba = json['dba'];
    _boro = json['boro'];
    _building = json['building'];
    _street = json['street'];
    _zipcode = json['zipcode'];
    _phone = json['phone'];
    _cuisineDescription = json['cuisine_description'];
    _inspectionDate = json['inspection_date'];
    _action = json['action'];
    _violationCode = json['violation_code'];
    _violationDescription = json['violation_description'];
    _criticalFlag = json['critical_flag'];
    _score = json['score'];
    _grade = json['grade'];
    _gradeDate = json['grade_date'];
    _recordDate = json['record_date'];
    _inspectionType = json['inspection_type'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _communityBoard = json['community_board'];
    _councilDistrict = json['council_district'];
    _censusTract = json['census_tract'];
    _bin = json['bin'];
    _bbl = json['bbl'];
    _nta = json['nta'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['camis'] = this._camis;
    data['dba'] = this._dba;
    data['boro'] = this._boro;
    data['building'] = this._building;
    data['street'] = this._street;
    data['zipcode'] = this._zipcode;
    data['phone'] = this._phone;
    data['cuisine_description'] = this._cuisineDescription;
    data['inspection_date'] = this._inspectionDate;
    data['action'] = this._action;
    data['violation_code'] = this._violationCode;
    data['violation_description'] = this._violationDescription;
    data['critical_flag'] = this._criticalFlag;
    data['score'] = this._score;
    data['grade'] = this._grade;
    data['grade_date'] = this._gradeDate;
    data['record_date'] = this._recordDate;
    data['inspection_type'] = this._inspectionType;
    data['latitude'] = this._latitude;
    data['longitude'] = this._longitude;
    data['community_board'] = this._communityBoard;
    data['council_district'] = this._councilDistrict;
    data['census_tract'] = this._censusTract;
    data['bin'] = this._bin;
    data['bbl'] = this._bbl;
    data['nta'] = this._nta;
    return data;
  }
}
