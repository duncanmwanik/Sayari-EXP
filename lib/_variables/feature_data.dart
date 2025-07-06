import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

import '../_models/features.dart';
import 'features.dart';

Map<String, FeatureData> featureData = {
  features.space: const FeatureData(title: 'Spaces'),
  features.timeline: const FeatureData(
    title: 'Timeline',
    intro: 'And more to explore...',
    icon: Icons.bolt,
    color: '1',
  ),
  features.todo: const FeatureData(
    title: 'ToDo',
    icon: Icons.format_list_bulleted_rounded,
  ),
  features.calendar: const FeatureData(
    title: 'Calendar',
    message: 'Session',
    intro: 'Manage your plans',
    icon: FontAwesome.calendar,
    color: '2',
  ),
  features.docs: const FeatureData(
    title: 'Docs',
    message: 'Doc',
    intro: 'Write anything',
    icon: FontAwesome.note_sticky,
    color: '0',
  ),
  features.notes: const FeatureData(
    title: 'Notes',
    message: 'Note',
    icon: FontAwesome.note_sticky_solid,
    color: '1',
  ),
  features.kanban: const FeatureData(
    title: 'Kanban',
    message: 'Kanban',
    intro: 'Plan your projects',
    icon: FontAwesome.circle_check_solid,
    color: '1',
  ),
  features.habits: const FeatureData(
    title: 'Habits',
    message: 'Habit',
    intro: 'Keep it in check',
    icon: FontAwesome.cubes_stacked_solid,
    color: '4',
  ),
  features.finances: const FeatureData(
    title: 'Finance',
    message: 'Tracker',
    intro: 'Learn how you spend',
    icon: FontAwesome.coins_solid,
    color: '5',
  ),
  features.links: const FeatureData(
    title: 'Links',
    message: 'Link',
    intro: 'Share your work & art',
    icon: FontAwesome.link_solid,
    color: '6',
  ),
  features.story: const FeatureData(
    title: 'Story',
    message: 'Story',
    intro: 'Share your work & art',
    icon: FontAwesome.timeline_solid,
    color: '6',
  ),
  features.bookings: const FeatureData(
    title: 'Bookings',
    message: 'Booking',
    intro: 'Manage your availability',
    icon: FontAwesome.calendar_check_solid,
    color: '7',
  ),
  features.chat: const FeatureData(
    title: 'Chat',
    intro: 'Communication on the fly',
    icon: FontAwesome.comment,
    color: '8',
  ),
  features.shop: const FeatureData(
    title: 'Shop',
    intro: 'Sell your products',
    icon: FontAwesome.store_solid,
    color: '11',
  ),
  features.transactions: const FeatureData(
    title: 'Transactions',
    intro: 'Track your invoices',
    icon: FontAwesome.file_invoice_solid,
    color: '12',
  ),
  features.events: const FeatureData(
    title: 'Events',
    intro: 'Make the best of events',
    icon: FontAwesome.ticket_simple_solid,
    color: '13',
  ),
  features.pomodoro: const FeatureData(
    title: 'Pomodoro',
    intro: 'Productivity made easy',
    icon: FontAwesome.stopwatch_solid,
    color: '14',
  ),
  features.saved: const FeatureData(title: 'Saved'),
  features.ghost: const FeatureData(title: 'Ghostly', message: 'Play', icon: FontAwesome.circle),
  features.explore: const FeatureData(title: 'Explore'),
};
