class Client {
  String? _cin;
  String? _nom;
  String? _prenom;
  String? _addresse;
  String? _ville;
  String? _tel;

  Client(
      {String? cin,
        String? nom,
        String? prenom,
        String? addresse,
        String? ville,
        String? tel}) {
    this._cin = cin!;
    this._nom = nom!;
    this._prenom = prenom!;
    this._addresse = addresse!;
    this._ville = ville!;
    this._tel = tel!;
  }

  String? get cin => _cin;
  set cin(String? cin) => _cin = cin;
  String? get nom => _nom;
  set nom(String? nom) => _nom = nom;
  String? get prenom => _prenom;
  set prenom(String? prenom) => _prenom = prenom;
  String? get addresse => _addresse;
  set addresse(String? addresse) => _addresse = addresse;
  String? get ville => _ville;
  set ville(String? ville) => _ville = ville;
  String? get tel => _tel;
  set tel(String? tel) => _tel = tel;

  Client.fromJson(Map<String, dynamic> json) {
    _cin = json['cin'];
    _nom = json['nom'];
    _prenom = json['prenom'];
    _addresse = json['addresse'];
    _ville = json['ville'];
    _tel = json['tel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cin'] = this._cin;
    data['nom'] = this._nom;
    data['prenom'] = this._prenom;
    data['addresse'] = this._addresse;
    data['ville'] = this._ville;
    data['tel'] = this._tel;
    return data;
  }
}
class Conteneur {
  int? _id;
  String? _reference;
  String? _titre;
  String? _description;
  String? _temperature;
  String? _humidite;
  String? _coordonneGps;

  Conteneur(
      {int? id,
        String? reference,
        String? titre,
        String? description,
        String? temperature,
        String? humidite,
        String? coordonneGps}) {
    this._id = id;
    this._reference = reference;
    this._titre = titre;
    this._description = description;
    this._temperature = temperature;
    this._humidite = humidite;
    this._coordonneGps = coordonneGps;
  }

  int get id => _id!;
  set id(int id) => _id = id;
  String get reference => _reference!;
  set reference(String reference) => _reference = reference;
  String get titre => _titre!;
  set titre(String titre) => _titre = titre;
  String get description => _description!;
  set description(String description) => _description = description;
  String get temperature => _temperature!;
  set temperature(String temperature) => _temperature = temperature;
  String get humidite => _humidite!;
  set humidite(String humidite) => _humidite = humidite;
  String get coordonneGps => _coordonneGps!;
  set coordonneGps(String coordonneGps) => _coordonneGps = coordonneGps;

  Conteneur.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _reference = json['reference'];
    _titre = json['titre'];
    _description = json['description'];
    _temperature = json['temperature'];
    _humidite = json['humidite'];
    _coordonneGps = json['coordonne_Gps'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['reference'] = this._reference;
    data['titre'] = this._titre;
    data['description'] = this._description;
    data['temperature'] = this._temperature;
    data['humidite'] = this._humidite;
    data['coordonne_Gps'] = this._coordonneGps;
    return data;
  }
}
