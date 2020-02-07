class UserInfoStore {
  const UserInfoStore({
    this.userId,
  });

  static final String CONST_USER_ID = 'userId';

  final String userId;

  factory UserInfoStore.fromJson(Map<String, dynamic> data) {
    return UserInfoStore(
      userId: data[CONST_USER_ID] as String,
    );
  }
}
