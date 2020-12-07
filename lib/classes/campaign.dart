import 'dart:convert';
import 'package:http/http.dart' as http;
List<campaign> camapignsFromJson(String str)=>List<campaign>.from(json.decode(str).map((x)=>campaign.fromJson(x)));
class campaign {
  int id;
  String slug;
  String status;
  String link;
  Title title;
  int featuredMedia;

  campaign(
      {this.id,
        this.slug,
        this.status,
        this.link,
        this.title,
        this.featuredMedia});

  campaign.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    slug = json['slug'];
    status = json['status'];
    link = json['link'];
    title = json['title'] != null ? new Title.fromJson(json['title']) : null;
    featuredMedia = json['featured_media'];

  }
  


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['slug'] = this.slug;
    data['status'] = this.status;
    data['link'] = this.link;
    if (this.title != null) {
      data['title'] = this.title.toJson();
    }
    data['featured_media'] = this.featuredMedia;
    return data;
  }
}

class Title {
  String rendered;

  Title({this.rendered});

  Title.fromJson(Map<String, dynamic> json) {
    rendered = json['rendered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rendered'] = this.rendered;
    return data;
  }
}

