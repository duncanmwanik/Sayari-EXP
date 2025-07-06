import 'package:flutter/material.dart';

import 'constants.dart';
import 'feature_data.dart';

Features features = Features();

class Features {
  String space = 'space';
  String timeline = 'timeline';
  String calendar = 'calendar';
  String docs = 'docs';
  String notes = 'notes';
  String todo = 'todo';
  String kanban = 'kanban';
  String finances = 'finances';
  String habits = 'habits';
  String links = 'links';
  String story = 'story';
  String bookings = 'bookings';
  String shop = 'shop';
  String orders = 'orders';
  String transactions = 'transactions';
  String events = 'events';
  String chat = 'chat';
  String tags = 'tags';
  String flags = 'flags';
  String subTypes = 'subTypes';
  String pomodoro = 'pomodoro';
  String explore = 'explore';
  String saved = 'saved';
  String ghost = 'ghost';

  List<String> docTypes() => [notes, kanban, finances, habits, bookings, links];

  // space types
  List<String> personal() => [notes, kanban, finances, habits, bookings, links, story];
}

extension FeatureExtentions on String {
  String title() => featureData[this]!.title;
  String message() => featureData[this]!.message;
  String intro() => featureData[this]!.intro;
  IconData icon() => featureData[this]!.icon;
  String color() => featureData[this]!.color;

  bool isTimeline() => features.timeline == this;
  bool isNote() => features.notes == this;
  bool isCalendar() => features.calendar == this;
  bool isTodo() => features.todo == this;
  bool isKanban() => features.kanban == this;
  bool isChat() => features.chat == this;
  bool isFinance() => features.finances == this;
  bool isLink() => features.links == this;
  bool isStory() => features.story == this;
  bool isBooking() => features.bookings == this;
  bool isSpace() => features.space == this;

  bool isNormal() => docLayoutNormal == this;
  bool isTags() => docLayoutTags == this;
  bool isAlternate() => docLayoutAlternate == this;

  bool isNewest() => orderTypeNewest == this;
  bool isOldest() => orderTypeOldest == this;
  bool isTitleAZ() => orderTypeTitleAZ == this;
  bool isTitleZA() => orderTypeTitleZA == this;
}
