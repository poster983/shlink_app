import 'package:shlink_app/types/Domain.dart';

class ShlinkGetDomains {
  _Domains domains;

  ShlinkGetDomains({this.domains});

  ShlinkGetDomains.fromJson(Map<String, dynamic> json) {
    domains =
        json['domains'] != null ? new _Domains.fromJson(json['domains']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.domains != null) {
      data['domains'] = this.domains.toJson();
    }
    return data;
  }

  List<Domain> toDomainList() {
    List<Domain> domainList = List<Domain>();

    domains.data.forEach((element) {
      domainList.add(new Domain(domain: element.domain, isDefault: element.isDefault));
    });

    return domainList;
  } 
}

class _Domains {
  List<_Data> data;

  _Domains({this.data});

  _Domains.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<_Data>();
      json['data'].forEach((v) {
        data.add(new _Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class _Data {
  String domain;
  bool isDefault;

  _Data({this.domain, this.isDefault});

  _Data.fromJson(Map<String, dynamic> json) {
    domain = json['domain'];
    isDefault = json['isDefault'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['domain'] = this.domain;
    data['isDefault'] = this.isDefault;
    return data;
  }
}
