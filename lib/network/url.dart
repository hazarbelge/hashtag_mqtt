class Url {
  static const String baseUrl = "https://${productionPath}cosmopair.com";
  static const int clientId = 2;
  static const String clientSecret = "b2Ta5aiDvr4oq7MVMNhYkn16Jj3SKDMn8Anf1lEr";

  static const String stagingPath = "dev.";
  static const String productionPath = "";

  static const String translations = "$baseUrl/api/translations";
  static const String pages = "$baseUrl/api/pages";

  static const String facebookLogin = "$baseUrl/api/v1/social/login/facebook";
  static const String googleLogin = "$baseUrl/api/v1/social/login/google";
  static const String appleLogin = "$baseUrl/api/v1/social/login/apple";

  static const String registerPhone = "$baseUrl/api/users/register-with-phone";
  static const String verificationPhone = "$baseUrl/api/users/send-verification-code";
  static const String loginPhone = "$baseUrl/oauth/token";

  static String cities(String keyword) => "$baseUrl/api/cities/with/paginate?q=$keyword";

  static const String questions = "$baseUrl/api/questions";
  static const String userAnswers = "$baseUrl/api/user-answers";

  static const String me = "$baseUrl/api/me";
  static const String meFields = "$baseUrl/api/me/edit/fields";
  static const String meUpdate = "$baseUrl/api/me/update";
  static const String tags = "$baseUrl/api/tags";
  static String syncTags(int _userID) => "$baseUrl/api/users/$_userID/sync-tags";

  static const String users = "$baseUrl/api/users";
  static String usersById(int id) => "$baseUrl/api/users/$id";
  static String deleteUserReason(int _userID) => "$baseUrl/api/users/$_userID/delete-reason";
  static const String filters = "$baseUrl/api/filters";
  static const String yingYang = "$baseUrl/api/matches/best";

  static const String matches = "$baseUrl/api/matches";
  static String hints(int userId) => "$baseUrl/api/users/$userId/hints";
  static const String myLikes = "$baseUrl/api/likes/my";
  static const String opponentLikes = "$baseUrl/api/likes/opponents";

  static const String fcmTokenUpdate = "$baseUrl/api/store-device";
  static String locationUpdate(int userId) => "$baseUrl/api/users/$userId/update-locations";

  static const String threads = "$baseUrl/api/chat/start";
  static String message(int threadId) => "$baseUrl/api/chat/threads/$threadId/messages";
  static const String medias = "$baseUrl/api/medias";
  static const String blocks = "$baseUrl/api/blocks";
  static const String reports = "$baseUrl/api/reports";

  static String subscriptions(int _planID) => "$baseUrl/api/payments/plans/$_planID/subscriptions/without/provider";
  static const String restoreSubscriptions = "$baseUrl/api/payments/plans/subscriptions/restore";
}
