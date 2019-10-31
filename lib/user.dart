class User {
  static const String CategoryGrocery = 'grocery';
  static const String CategoryHousehold = 'household';
  static const String CategoryPersonal = 'personal';
  static const String CategorySnacks = 'snacks';
  static const String CategoryDairy = 'dairy';
  static const String CategoryFrozenFood = 'frozen food';
  String ProductName = '';
  String ProductPrice = '';
  Map category = {
    CategoryGrocery: false,
    CategoryHousehold: false,
    CategoryPersonal: false,
    CategorySnacks: false,
    CategoryDairy: false,
    CategoryFrozenFood: false
  };
  bool newsletter = false;
  save() {
    print('saving user using a web service');
  }
}