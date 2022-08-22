import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'student_search_page_bloc.dart';
import 'student_search_page_view.dart';

class StudentSearchPageProvider extends BlocProvider<StudentSearchPageBloc> {
  StudentSearchPageProvider({Key? key})
      : super(
          key: key,
          create: (context) => StudentSearchPageBloc(context),
          child: const StudentSearchPageView(),
        );
}
