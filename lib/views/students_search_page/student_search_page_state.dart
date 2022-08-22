import 'package:flutter/foundation.dart';

import '../../models/user_details.dart';

@immutable
class StudentSearchPageState {
  final String error;
  final List<UserDetails> users;
  final List<UserDetails> searchResults;
  final bool isLoading;

  const StudentSearchPageState({
    required this.error,
    required this.users,
    required this.isLoading,
    required this.searchResults,
  });

  static StudentSearchPageState get initialState {
    return const StudentSearchPageState(
        error: '', users: [], isLoading: false, searchResults: []);
  }

  StudentSearchPageState clone({
    String? error,
    List<UserDetails>? users,
    bool? isLoading,
    List<UserDetails>? searchResults,
  }) {
    return StudentSearchPageState(
      error: error ?? this.error,
      users: users ?? this.users,
      isLoading: isLoading ?? this.isLoading,
      searchResults: searchResults ?? this.searchResults,
    );
  }
}
