import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../_helpers/common/global.dart';
import '../../../_state/_providers.dart';
import '../../../_theme/colors.dart';
import '../../../_widgets/others/toast.dart';
import '../var/variables.dart';
import 'audio.dart';

String getStoppingTime() {
  return DateFormat('h:mm a').format(now().add(Duration(seconds: state.pomodoro.remainingTime)));
}

String getCounter() {
  int time = !state.pomodoro.isCounting && !state.pomodoro.isPaused
      ? int.parse(state.pomodoro.data['${state.pomodoro.currentTimer}t'] ?? '1') * 60
      : state.pomodoro.remainingTime;
  String seconds = (time % 60).toString();
  String minutes = (time / 60).truncate().toString();
  return '${minutes.length < 2 ? '0$minutes' : minutes}:${seconds.length < 2 ? '0$seconds' : seconds}';
}

void startTimer() {
  String type = state.pomodoro.currentTimer;
  // if not counting
  if (state.pomodoro.remainingTime == 0) {
    Duration time = Duration(minutes: int.parse(state.pomodoro.data['${type}t'] ?? '1'));
    state.pomodoro.updateRemainingTime(time.inSeconds);
  }
  // start timer
  state.pomodoro.updateCounter(Timer.periodic(Duration(seconds: 1), (counter) {
    // count down
    if (state.pomodoro.remainingTime != 0) {
      state.pomodoro.updateRemainingTime(state.pomodoro.remainingTime - 1);
    }
    // if timer is done
    if (state.pomodoro.remainingTime == 0) {
      state.pomodoro.reset();
      playAudio(state.pomodoro.data['as']);
      autoPlayTimers(type);
    }
    // show reminder if 5 minutes/seconds is left to stop timer
    if ((state.pomodoro.remainingTime / 60) == 5) toastInfo('5 minutes left!');
    if (state.pomodoro.remainingTime == 5) toastInfo('5 seconds left!');
  }));

  // keep track of types for long break interval
  if (type == 'f' || type == 'l') {
    state.pomodoro.updateTimerLoops();
  }
}

void playPauseTimer(String type) {
  if (state.pomodoro.isCounting) {
    if (state.pomodoro.isPaused) {
      // pause timimg
      startTimer();
      state.pomodoro.updateIsPaused(false);
    } else {
      // resume timimg
      state.pomodoro.cancelCounter();
      state.pomodoro.updateIsPaused(true);
    }
  } else {
    startTimer(); // if not counting yet
  }
}

void autoPlayTimers(String previousType) {
  if (state.pomodoro.data['ap'] == '1') {
    String newType = state.pomodoro.timerLoops == int.parse(state.pomodoro.data['longBreakInterval'] ?? '4')
        ? 'l'
        : previousType == 'f'
            ? 's'
            : 'f';

    showToast(
      'Time ${newType == 'f' ? 'to' : 'for a'} <b>${pomodoroTitles[newType]?.toLowerCase()}!</b>',
      color: backgroundColors[state.pomodoro.data['${newType}c']]!.color,
      icon: Icons.timer,
    );
    state.pomodoro.reset(newType);
    startTimer();
  } else {
    String type = state.pomodoro.currentTimer;
    showToast(
      '<b>${type == 'f' ? 'Focus time' : type == 's' ? 'Short break' : 'Long break'}<b> is over!',
      color: backgroundColors[state.pomodoro.data['${type}c']]!.color,
      icon: Icons.timer,
    );
  }
}
