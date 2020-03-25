class UserLocation {
  int placeId;
  String licence;
  String osmType;
  int osmId;
  String lat;
  String lon;
  String displayName;
  Address address;
  List<String> boundingbox;

  UserLocation(
      {this.placeId,
      this.licence,
      this.osmType,
      this.osmId,
      this.lat,
      this.lon,
      this.displayName,
      this.address,
      this.boundingbox});

  UserLocation.fromJson(Map<String, dynamic> json) {
    placeId = json['place_id'];
    licence = json['licence'];
    osmType = json['osm_type'];
    osmId = json['osm_id'];
    lat = json['lat'];
    lon = json['lon'];
    displayName = json['display_name'];
    address =
        json['address'] != null ? new Address.fromJson(json['address']) : null;
    boundingbox = json['boundingbox'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['place_id'] = this.placeId;
    data['licence'] = this.licence;
    data['osm_type'] = this.osmType;
    data['osm_id'] = this.osmId;
    data['lat'] = this.lat;
    data['lon'] = this.lon;
    data['display_name'] = this.displayName;
    if (this.address != null) {
      data['address'] = this.address.toJson();
    }
    data['boundingbox'] = this.boundingbox;
    return data;
  }
}

class Address {
  String houseNumber;
  String road;
  String town;
  String city;
  String county;
  String stateDistrict;
  String state;
  String postcode;
  String country;
  String countryCode;

  Address(
      {this.houseNumber,
      this.road,
      this.town,
      this.city,
      this.county,
      this.stateDistrict,
      this.state,
      this.postcode,
      this.country,
      this.countryCode});

  Address.fromJson(Map<String, dynamic> json) {
    houseNumber = json['house_number'];
    road = json['road'];
    town = json['town'];
    city = json['city'];
    county = json['county'];
    stateDistrict = json['state_district'];
    state = json['state'];
    postcode = json['postcode'];
    country = json['country'];
    countryCode = json['country_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['house_number'] = this.houseNumber;
    data['road'] = this.road;
    data['town'] = this.town;
    data['city'] = this.city;
    data['county'] = this.county;
    data['state_district'] = this.stateDistrict;
    data['state'] = this.state;
    data['postcode'] = this.postcode;
    data['country'] = this.country;
    data['country_code'] = this.countryCode;
    return data;
  }
}
