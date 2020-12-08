class Constants {
  static const String FIRST_TIME_USER_CHECK_PREF = "firstTime";

  static final String MESSAGE_TYPE_TEXT = "text";
  static final String MESSAGE_TYPE_EVENT = "event";

  static final String EVENT_TYPE_OFFLINE = "offline";
  static final String EVENT_TYPE_ONLINE = "online";

  static final String EVENT_STATUS_DECLINED = "declined";
  static final String EVENT_STATUS_ACCEPTED = "accepted";
  static final String EVENT_STATUS_NONE = "none";

  static final String SEARCH_FILTER_TYPE_CATEGORY = "category";
  static final String SEARCH_FILTER_TYPE_SERVICE = "service";

  static final Map<String, int> RATING_MAP = {
    "five": 5,
    "four": 4,
    "three": 3,
    "two": 2,
    "one": 1,
  };
}
