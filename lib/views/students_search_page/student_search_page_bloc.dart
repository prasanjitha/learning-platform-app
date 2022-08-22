import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../../models/user_details.dart';
import 'student_search_page_event.dart';
import 'student_search_page_state.dart';
import 'package:http/http.dart' as http;

class StudentSearchPageBloc
    extends Bloc<StudentSearchPageEvent, StudentSearchPageState> {
  StudentSearchPageBloc(BuildContext context)
      : super(StudentSearchPageState.initialState) {
    on<InitEvent>((event, emit) async {
      emit(state.clone(isLoading: true));
      try {
        const String url = 'https://jsonplaceholder.typicode.com/users';
        final response = await http.get(Uri.parse(url));
        List data = jsonDecode(response.body);
        final List<UserDetails> userDetails = [];
        for (Map user in data) {
          userDetails.add(UserDetails.fromJson(user));
        }
        log(data.toString());
        emit(state.clone(users: userDetails, isLoading: false));
      } catch (e) {
        log(e.toString());
      }
    });
    add(InitEvent());
    final List<UserDetails> searchResult = [];
    on<OnSearchTextChangedEvent>((event, emit) async {
      emit(state.clone(isLoading: true));
      searchResult.clear();
      if (event.text.isEmpty) {
        log(event.text);

        emit(state.clone(searchResults: [], isLoading: false));
        return;
      }
      emit(state.clone(isLoading: true));
      state.users.forEach((userDetail) {
        log('call function');
        log(userDetail.toString());
        if (userDetail.firstName.contains(event.text) ||
            userDetail.lastName.contains(event.text)) {
          searchResult.add(userDetail);
          emit(state.clone(searchResults: searchResult, isLoading: false));
        }
      });
    });
  }
}
