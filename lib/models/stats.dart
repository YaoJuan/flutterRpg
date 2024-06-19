mixin Stats {
  // fields
  int _points = 10;
  int _health = 10;
  int _attack = 10;
  int _defense = 10;
  int _skill = 10;

  // getters
  int get points => _points;

  List<Map<String, String>> get statsAsFormattedList => [
        {'title': 'health', 'value': _health.toString()},
        {'title': 'attack', 'value': _attack.toString()},
        {'title': 'defense', 'value': _defense.toString()},
        {'title': 'skill', 'value': _skill.toString()}
      ];

  Map<String, int> get statsAsMap => {
        'health': _health,
        'attack': _attack,
        'defense': _defense,
        'skill': _skill
      };

  // methods
  void increaseStats(String stat) {
    if (_points > 0) {
      switch (stat) {
        case 'health':
          _health++;
          break;
        case 'attack':
          _attack++;
          break;
        case 'defense':
          _defense++;
          break;
        case 'skill':
          _skill++;
          break;
      }
      _points--;
    }
  }

  void decreaseStats(String stats) {
    switch (stats) {
      case 'health':
        if (_health > 5) {
          _health--;
          _points++;
        }
        break;
      case 'attack':
        if (_attack > 5) {
          _attack--;
          _points++;
        }
        break;
      case 'defense':
        if (_defense > 5) {
          _defense--;
          _points++;
        }
        break;
      case 'skill':
        if (_skill > 5) {
          _skill--;
          _points++;
        }
        break;
    }
  }

  

    // set stats & points
  void setStats({ required int points, required Map<String, dynamic> stats}) {
    _points = points;
    
    _health = stats['health'];
    _attack = stats['attack'];
    _defense = stats['defense'];
    _skill = stats['skill'];
  }
}
