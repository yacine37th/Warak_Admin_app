class UserModel {
  late String? uID;
  late String? firstName;
  late String? lastName;

  late String? imageURL;
  late String? coverImageURL;

  late String? email;
  late List? autherBooks;
  late List? myBooks;
  late List? favoriteBooks;

  UserModel({
    required this.uID,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.imageURL,
    required this.coverImageURL,
    required this.autherBooks,
    required this.myBooks,
    required this.favoriteBooks,
  });
}
