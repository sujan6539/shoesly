class Filter {
  String brand;
  SortByFilter? sortBy;
  GenderFilter? gender;
  String? color;
  double minPrice;
  double maxPrice;

  Filter({
    required this.brand,
    required this.sortBy,
    required this.gender,
    required this.color,
    required this.minPrice,
    required this.maxPrice,
  });
}

enum GenderFilter {
  all,
  men,
  women,
  unisex;

  static String toStr(GenderFilter filter) {
    switch (filter) {
      case GenderFilter.all:
        return 'All';
      case GenderFilter.men:
        return 'men';
      case GenderFilter.women:
        return 'women';
      case GenderFilter.unisex:
        return 'unisex';
    }
  }

  static GenderFilter toFilter(String? filter) {
    switch (filter) {
      case 'All':
        return GenderFilter.all;
      case 'Man':
        return GenderFilter.men;
      case 'Woman':
        return GenderFilter.women;
      case 'Unisex':
        return GenderFilter.unisex;
      default:
        return GenderFilter.all;
    }
  }
}

enum SortByFilter {
  random,
  nameAToZ,
  priceLowToHigh,
  priceHighToLow;

  static String toStr(SortByFilter filter) {
    switch (filter) {
      case SortByFilter.random:
        return 'random';
      case SortByFilter.nameAToZ:
        return 'Name (A-Z)';
      case SortByFilter.priceLowToHigh:
        return 'Price (Low-High)';
      case SortByFilter.priceHighToLow:
        return 'Price (High-Low)';
    }
  }

  static SortByFilter toFilter(String? filter) {
    switch (filter) {
      case 'Random':
        return SortByFilter.random;
      case 'Name (A-Z)':
        return SortByFilter.nameAToZ;
      case 'Price (Low-High)':
        return SortByFilter.priceLowToHigh;
      case 'Price (High-Low)':
        return SortByFilter.priceHighToLow;
      default:
        return SortByFilter.random;
    }
  }
}
