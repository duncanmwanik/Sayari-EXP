import 'package:collection/collection.dart';

import '../_helpers/common/global.dart';
import '../_helpers/common/helpers.dart';
import '../_helpers/extentions/strings.dart';
import '../_variables/constants.dart';
import '../_variables/features.dart';
import '../_widgets/files/_helpers/helper.dart';
import '../features/finance/_helpers/calculations.dart';
import '../features/kanban/_helpers/helper.dart';
import '../features/spaces/_helpers/common.dart';

class Item {
  Item({
    this.db = spaces,
    this.parent = '',
    this.type = '',
    this.id = '',
    this.sid = '',
    this.data = const {},
    this.isNew = false,
    this.isInput = false,
    this.label,
    this.temp,
  });

  String db;
  String parent;
  String type;
  String id;
  String sid;
  Map data;
  bool isNew;
  bool isInput;
  String? label;
  dynamic temp;

  Item.empty() : this(data: {});

  // general
  String title([String? place]) => data[itemTitle] ?? (place ?? 'Untitled');
  String color() => data[itemColor] ?? '';
  String emoji() => data[itemEmoji] ?? '';
  String content() => data[itemContent] ?? '';
  String reminder() => data[itemReminder] ?? '';
  String tags() => data[itemTags] ?? '';
  String email() => data[itemEmail] ?? '';
  String coverId([String parentKey = '']) {
    return (parentKey.isNotEmpty ? data[parentKey] : data)
        .keys
        .firstWhere((key) => key.toString().startsWith(itemFileCover), orElse: () => '');
  }

  bool has(String key) => data.containsKey(key);

  String coverName([String parentKey = '']) => (parentKey.isNotEmpty ? data[parentKey] : data)[coverId(parentKey)] ?? '';
  List<String> flags() => splitList(data[itemFlags]);
  String typee() => data[itemType] ?? '';
  String timestamp() => data[itemTimestamp] ?? '';
  String sortType() => data[itemSortEntries] ?? itemSortAll;
  bool isExpanded([bool place = false]) => data[itemExpand] != null ? data[itemExpand] == 1 : place;
  bool isNote() => typee() == features.notes;
  bool isKanban() => typee() == features.kanban;
  bool isHabit() => typee() == features.habits;
  bool isFinance() => typee() == features.finances;
  bool isLink() => typee() == features.links;
  bool isStory() => typee() == features.story;
  bool isBooking() => typee() == features.bookings;
  bool hasCover() => coverId().isNotEmpty;
  bool hasContent() => content().isNotEmpty;
  bool isSortAll() => sortType() == itemSortAll;

  // sessions
  String start() => data[itemStart] ?? '';
  String end() => data[itemEnd] ?? '';
  String about() => data[itemAbout] ?? '';
  String venue() => data[itemVenue] ?? '';
  String leads() => data[itemLead] ?? '';

  // tasks
  Map subItems() => getSubItems(data);
  List subKeys() => data.keys.where((key) => key.startsWith(itemSubItem)).toList();
  int taskCount() => subKeys().length;
  int checkedCount() => data.keys.where((key) => key.startsWith(itemSubItem) && data[key][itemChecked] == 1).length;
  bool hasTasks() => taskCount() > 0;

  // habits
  List<String> customHabitDates() => splitList(data[itemHabitCustomDates]);
  List checkedHabitDates() => data.keys.where((key) => key.toString().startsWith(itemSubItem)).toList();
  int checkedHabitDatesCount() => checkedHabitDates().length;
  String habitView() => data[itemHabitView] ?? monthlyView;
  bool isHabitChecked(String key) => data[key] != null;

  // bookings
  List<String> bookingDates() => splitList(data[itemBookingDates]);
  List<String> bookingTimes() => splitList(data[itemBookingTimes]);
  List bookings() => data.keys.where((key) => key.toString().startsWith(itemSubItem)).toList();

  // links
  List sharedlinks() => data.keys
      .where((key) => key.toString().startsWith(itemSubItem))
      .whereNot((key) => data[key][itemType] == itemLinkTypeSocial)
      .toList();
  List sharedSocials() =>
      data.keys.where((key) => key.toString().startsWith(itemSubItem)).where((key) => data[key][itemType] == itemLinkTypeSocial).toList();

  // finances
  double amount() => data[itemAmount] ?? 0;
  bool hasAmount() => amount() > 0;
  double goal(String type) => data['$itemGoal$type'] ?? 0;
  double total(String type) => getTotalAmount(data, type);

  // portfolios

  // files
  Map files([bool showHidden = true]) => getFiles(data, showHidden: showHidden);
  Map allFiles() => getFiles(data, deep: true);
  int fileCount() => getFiles(data).length;
  bool hasFiles() => files().isNotEmpty;

  // shared
  bool isShared() => data[itemShared] != null;
  bool hasCustomLink() => customLink().isNotEmpty;
  String sharedStatus() => data[itemShared] ?? itemSharedRestricted;
  bool isSharedRestricted() => sharedStatus() == itemSharedRestricted;
  bool isSharedPublic() => sharedStatus() == itemSharedPublic;
  String sharedLink() => '$sayariDefaultPath/${title().bare()}-${liveSpace()}-$id';
  String sharedCustomLink() => '$sayariDefaultPath/${customLink()}';
  String customLink() => data[itemCustomLink] ?? '';
  // String publishedLink() => '$sayariDefaultPath/${title().bare()}-${liveSpace()}';
  String demoLink() => '/${title().bare()}-${liveSpace()}$id';
  String sharedCreator() => shareItemMembers().firstOrNull ?? '';
  List shareItemMembers() => splitList(data[itemSharedMembers]);

  // checks
  bool exists() => data.isNotEmpty;
  bool hasTitle() => data[itemTitle] != null && data[itemTitle] != '';
  bool hasColor() => data[itemColor] != null;
  bool hasEmoji() => data[itemEmoji] != null;
  bool hasTags() => tags().isNotEmpty;
  bool hasReminder() => reminder().isNotEmpty;
  bool hasReminderPassed() => hasReminder() ? DateTime.parse(reminder()).isBefore(now()) : false;
  bool hasDetails() => reminder().isNotEmpty || tags().isNotEmpty || files().isNotEmpty;
  bool hasOverview() => coverId().isNotEmpty;
  bool hasFlags() => flags().isNotEmpty;
  bool isPinned() => data[itemPinned] == 1;
  bool isArchived() => data[itemArchived] == 1;
  bool isTrashed() => data[itemTrashed] == 1;
  bool isChecked() => data[itemChecked] == 1;
  bool showChecks() => data[itemShowChecks] == 1;
  bool showEditor() => isNote();
  bool showFooter() => (isNote() || isBooking() || isFinance()) && !isShare();
  bool showEditorOverview() => isNote();
  bool showCover() => coverId().isNotEmpty && !isKanban() && !isLink();
  bool showNewEntriesFirst() => data[itemSortEntries] == 1;
}
