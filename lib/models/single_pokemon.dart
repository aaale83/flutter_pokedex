class SinglePokemon {
  int? id;
  String? name;
  int? height;
  int? weight;
  List<String>? moves;
  List<String>? types;
  String? urlImage;
  String? urlImageOfficial;

  SinglePokemon({
    this.id,
    this.name,
    this.height,
    this.weight,
    this.moves,
    this.types,
    this.urlImage,
    this.urlImageOfficial
  });

  SinglePokemon.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    height = json['height'];
    weight = json['weight'];
    moves = json['moves'].cast<String>();
    types = json['types'].cast<String>();
    urlImage = json['urlImage'];
    urlImageOfficial = json['urlImageOfficial'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['height'] = height;
    data['weight'] = weight;
    data['moves'] = moves;
    data['types'] = types;
    data['urlImage'] = urlImage;
    data['urlImageOfficial'] = urlImageOfficial;
    return data;
  }
}